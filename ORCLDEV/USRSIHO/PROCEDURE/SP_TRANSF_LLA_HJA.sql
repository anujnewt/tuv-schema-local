create or replace procedure usrsiho."sp_transf_lla_hja"  (pi_lla_num_id numeric, pd_fecha timestamp(0), ps_usuario varchar, wi_val_ret01 inout numeric, ws_val_ret02 inout varchar) as $body$
-- return "informix".sp_transf_lla_hja_tab pipelined
declare
-- pgv moved types start
-- pgv moved types end
--ig-cons-0823 comentado
--define ps_det_sindkto char(15);
--termina comentado
--ig-cons-0823 substituye
pi_det_sindkto numeric(10);
--termina substituye
pi_tipo_folio numeric(10);
pi_ord_sindkto numeric(10);
pi_interno_hon numeric(10); --ig-cons-0823
pi_enc_num_id integer;
ps_cadena_reg varchar(50);
pi_enc_num_id_aux numeric(10);
ps_num_id varchar(10);
ps_desori varchar(100);
rec record;
begin
--let ps_det_sindkto = ''; ig-cons-0823 comentado
pi_det_sindkto 	:= 0;
pi_tipo_folio   := 0;
pi_ord_sindkto  := 0;
pi_enc_num_id   := 0;
ps_cadena_reg:= null;
pi_enc_num_id_aux := 0;
ps_num_id:= null;
ps_desori:= null;
--busca la descripcion cuando es un llamado sin centro de costos
begin
select esa_desori
into strict ps_desori
from usrsiho.encsolact
where esa_numsol = (select enc_solscc from usrsiho.holoenclla where enc_num_id = pi_lla_num_id);
exception
when no_data_found then
ps_desori:= null;
end;
--comenta ig-cons-0823
-- foreach
-- 	select distinct det_sindkto,case when det_keyfol is null then 1 else 0 end,
-- 		 case when det_sindkto = 'ANDA' then 1 when det_sindkto = 'SITATYR' then 2 else 3 end
-- 	into ps_det_sindkto,pi_tipo_folio,pi_ord_sindkto
-- 	from holodetlla
-- 	where det_num_id = pi_lla_num_id and
-- 		trim(det_sindkto) <> 'OTRO' and
-- 		det_stslla = 'V'
-- 	 order by  2,3
--termina comenta ig-cons-0823
perform dbms_output.put_line('inicio');
--inserta ig-cons-0823
--para separacion de honoristas internos, para sitatyr y conductores artisticos
for rec
in (select  distinct	det_keytco,
case when nullif(det_keyfol::text, '') is null then 1 else 0 end as val_case01,
case when det_keytco = 2 then 1 when det_keytco = 3 then 2 else 3 end as val_case02,
case when det_keytco = 2 then 1
when det_keytco = 3 then (case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end)
when det_keytco = 519 then (case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end)
else
1
end  as val_case03
from 	usrsiho.holodetlla, usrsiho.nmcoempl, usrsiho.holoalem
where det_num_id = pi_lla_num_id and
emp_keyemp = det_keyemp and
ale_keyemp = emp_keyemp and
trim(both det_sindkto) <> 'OTRO' and
det_stslla = 'V'
order by  2,3,4) loop
perform dbms_output.put_line('ciclo');
--termina inserta ig-cons-0823
--inserta encabezado de la hoja de trabajo
pi_det_sindkto := rec.det_keytco;
pi_tipo_folio := rec.val_case01;
pi_ord_sindkto := rec.val_case02;
pi_interno_hon := rec.val_case03;
insert into usrsiho.holoenctra(enc_keydep, enc_fecgra, enc_keytpr, enc_nomprd, enc_feccap, enc_keypro,
enc_usuori, enc_stsrep, enc_gcxxii, enc_numlla, enc_conlla, enc_desscc)
--values encabezado
select
enc_keydep, enc_feclla, enc_keytpr, enc_nomprd, enc_feccap, enc_keypro,
enc_usuori, 0, 'N', enc_num_id, 'S', case when nullif(enc_keydep::text, '') is null or enc_keydep = null then ps_desori else null end
from usrsiho.holoenclla
where	enc_num_id = pi_lla_num_id;
-- --------------------------------------------
-- lectura del secuencial de la hoja de trabajo
-- --------------------------------------------
select currval('holoenctra_seq') into strict pi_enc_num_id;
--values detalle
if pi_tipo_folio = 0 then
--inserta detalle de hoja de trabajo
--ig-cons-0823 comentado
--insert into holodettra
--(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
-- det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
-- det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
-- det_tipinc, det_cosuni, det_numlla)
-- select	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
-- 			det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
-- 			'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
-- 			det_tipinc, det_cosuni, det_num_id
-- from 	holodetlla,nmcopues
-- where 	det_keypue = pue_keypue and
--          det_num_id = pi_lla_num_id and
-- 			det_sindkto = ps_det_sindkto and
-- 			det_keyfol is not null and
-- 			det_stslla = 'V';
--termina comentado
--ig-cons-0823 substituye
insert into usrsiho.holodettra(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
det_tipinc, det_cosuni, det_numlla, det_honint)
select	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, coalesce(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
det_tipinc, det_cosuni, det_num_id, pi_interno_hon
from 	usrsiho.holodetlla,usrsiho.nmcopues, usrsiho.nmcoempl, usrsiho.holoalem
where 	det_keypue = pue_keypue and
det_num_id = pi_lla_num_id and
det_keytco = pi_det_sindkto and
nullif(det_keyfol::text, '') is not null and
det_stslla = 'V' and
emp_keyemp = det_keyemp and
ale_keyemp = emp_keyemp and
case 	when det_keytco = 2 then 1
when det_keytco = 3 then
case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end
when det_keytco = 519 then
case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end
else
1
end = pi_interno_hon;
-- termina substituye
else
--inserta detalle de hoja de trabajo
-- ig-cons-0823 comentado
-- insert into holodettra
-- (det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
-- det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
-- det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
-- det_tipinc, det_cosuni, det_numlla)
-- select	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
-- 			det_nomcor, det_person, det_keypue, nvl(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
-- 			'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
-- 			det_tipinc, det_cosuni, det_num_id
-- from 	holodetlla,nmcopues
-- where 	det_keypue = pue_keypue and
--         	det_num_id = pi_lla_num_id and
-- 			det_sindkto = ps_det_sindkto and
-- 			det_keyfol is null and
-- 			det_stslla = 'V';
-- termina comentado
-- ig-cons-0823 substituye
insert into usrsiho.holodettra(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_stsreg, det_stspag,
det_inanda, det_ultact, det_cdilla, det_usuori, det_fecori, det_usufin, det_fecfin,
det_tipinc, det_cosuni, det_numlla, det_honint)
select	pi_enc_num_id, det_keydep, det_feclla, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, coalesce(pue_ca5aux,'?'), det_noforo, det_hralla, 'V', 'P',
'N', pd_fecha, det_cdilla, det_usuori, pd_fecha, ps_usuario, pd_fecha,
det_tipinc, det_cosuni, det_num_id, pi_interno_hon
from 	usrsiho.holodetlla,usrsiho.nmcopues, usrsiho.nmcoempl, usrsiho.holoalem
where 	det_keypue = pue_keypue and
det_num_id = pi_lla_num_id and
det_keytco = pi_det_sindkto and
nullif(det_keyfol::text, '') is null and
det_stslla = 'V' and
emp_keyemp = det_keyemp and
ale_keyemp = emp_keyemp and
case 	when det_keytco = 2 then 1
when det_keytco = 3 then
case 	when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end
when det_keytco = 519 then
case 	when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 1 else 0 end
else
1
end = pi_interno_hon;
-- termina substituye
end if;
if pi_enc_num_id_aux = 0 then
pi_enc_num_id_aux := pi_enc_num_id;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('valor ', to_char(pi_enc_num_id_aux) ) );/* dmap converted statement end */
ps_num_id := to_char(pi_enc_num_id);/* dmap converted statement start */
ps_cadena_reg := concat( trim(both ps_cadena_reg), trim(both ps_num_id) , ',') ;/* dmap converted statement end */
end loop;
update usrsiho.holoenclla
set    enc_hjatra = pi_enc_num_id_aux,
enc_stslla = 2
where  enc_num_id = pi_lla_num_id;
wi_val_ret01 := pi_enc_num_id_aux;
ws_val_ret02 := ps_cadena_reg;
-- return pi_enc_num_id_aux, ps_cadena_reg with resume;
-- pipe row ("informix".sp_transf_lla_hja_row(pi_enc_num_id_aux,ps_cadena_reg));
end;
$body$
language plpgsql
;
