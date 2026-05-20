create or replace  function  labprod.calculoisn_porcentaje_adicional (ws_key_ent varchar,wn_por_adi numeric,ws_key_tab varchar,wn_base numeric, ws_key_cia varchar, wn_anio integer) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_result decimal(8,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
case
when ws_key_ent = '12' then   --guerrero
select case when nullif(pam_folini::text, '') is null then ent_poradi else coalesce(labprod.safe_to_number(pam_folini),0) end into strict wn_result
from labprod.isnentidades
left join labprod.glcopams on pam_keypar = 'IS12' and pam_cvesec = ws_key_cia
where ent_keyent = '12'
and ent_anio = wn_anio;
when nullif(ws_key_tab::text, '') is not null  and ws_key_ent = '13' then  --hidalgo
select tab_elecua into strict wn_result
from labprod.nmlotabn
where tab_keytab = ws_key_tab
and tab_eleuno <= wn_base
and tab_eledos >= wn_base;
when ws_key_ent = '26' then   --sonora
select case when nullif(pam_folini::text, '') is null then ent_poradi else coalesce(labprod.safe_to_number(pam_folini),0) end into strict wn_result
from labprod.isnentidades
left join labprod.glcopams on pam_keypar = 'IS26' and pam_cvesec = ws_key_cia
where ent_keyent = '26'
and ent_anio = wn_anio;
when ws_key_ent = '30' then   --veracruz
select case when nullif(pam_folini::text, '') is null then ent_poradi else coalesce(labprod.safe_to_number(pam_folini),0) end into strict wn_result
from labprod.isnentidades
left join labprod.glcopams on pam_keypar = 'IS30' and pam_cvesec = ws_key_cia
where ent_keyent = '30'
and ent_anio = wn_anio;
when ws_key_ent = '32' then   --zacatecas
select case when nullif(pam_folini::text, '') is null then ent_poradi else coalesce(labprod.safe_to_number(pam_folini),0) end into strict wn_result
from labprod.isnentidades
left join labprod.glcopams on pam_keypar = 'IS32' and pam_cvesec = ws_key_cia
where ent_keyent = '32'
and ent_anio = wn_anio;
else
wn_result := wn_por_adi;
end case;
return wn_result;end;
$body$
language plpgsql
stable;
