create or replace procedure labconf."sp_nmincem1"  ( wn_key_pro numeric, ws_key_per varchar, ws_key_men varchar, ws_des_pro inout varchar, ws_des_nom inout varchar, ws_per_ant inout varchar, wd_fec_ini inout timestamp(0), wd_fec_fin inout timestamp(0), wn_key_nom inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tot_reg numeric(10) := 0;
begin
ws_des_pro := null;
ws_des_nom := null;
wd_fec_ini := null;
wd_fec_fin := null;
ws_per_ant := ws_key_per;
wn_key_nom := null;
wn_tot_reg := 0;
select count(*) into strict wn_tot_reg
from glcodats
where dat_keymen = ws_key_men
and dat_idecam = 'keypro';
if wn_tot_reg > 0 then
select pro_despro into strict ws_des_pro from nmloproc
where pro_keypro = wn_key_pro
and pro_keypro in ( select dat_valore from glcodats
where dat_keymen = ws_key_men
and dat_idecam = 'keypro' );
else
select pro_despro into strict ws_des_pro  from nmloproc
where pro_keypro = wn_key_pro;
end if;
select count(*) into strict wn_tot_reg from nmloperi
where per_keyper = ws_key_per
and per_keypro = wn_key_pro
and nullif(per_fecact::text, '') is null;
if wn_tot_reg > 0 then
wn_key_nom := null;
select per_keynom, per_fecini, per_fecfin
into strict wn_key_nom,wd_fec_ini,wd_fec_fin
from nmloperi
where per_keypro = wn_key_pro
and per_keyper = ws_key_per;
select count(*) into strict wn_tot_reg from glcodats
where dat_keymen = ws_key_men
and dat_idecam = 'keynom';
if (wn_tot_reg > 0) then
select nom_destip into strict ws_des_nom  from nmlonomi
where nom_keynom = wn_key_nom
and nom_keynom in ( select dat_valore from glcodats
where dat_keymen = ws_key_men
and dat_idecam = 'keynom' );
else
select nom_destip into strict ws_des_nom  from nmlonomi
where nom_keynom = wn_key_nom;
end if;
else
ws_per_ant := '?';
end if;
if nullif(ws_des_pro::text, '') is null then
ws_des_pro := '?';
end if;
if nullif(ws_des_nom::text, '') is null then
ws_des_nom := '?';
end if;
if nullif(ws_key_per::text, '') is null then
ws_per_ant := ws_key_per;
end if;
if nullif(wn_key_nom::text, '') is null then
wn_key_nom := -1;
end if;end;
$body$
language plpgsql
;
