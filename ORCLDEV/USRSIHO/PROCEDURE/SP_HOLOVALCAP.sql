create or replace procedure usrsiho."sp_holovalcap"  (ps_nom_rep varchar, ps_ide_pcc varchar, pi_key_usu integer, pd_fecpag timestamp(0), pi_consult smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
pi_num_id integer;
pi_keyfol integer;
pi_keyemp integer;
pi_sumcap integer;
err_num integer;
ps_keydep varchar(10);
--ig-cons-0823 tipo de validacion del contrato
pi_tpo_val integer;
cur_01 record;
begin
pi_num_id := 0;
pi_keyfol := 0;
pi_keyemp := 0;
pi_sumcap := 0;
err_num := 0;
-- crea una tabla temporal -------------------------------------------
-- begin
-- 	on exception in (-310) set err_num  -- error tabla existente.
--
-- 	if err_num = -310 then
-- 		drop table tmp_cap_val;
-- 		create temp table tmp_cap_val (nocapitulos integer);
-- 	end if
--
-- 	end exception with resume
--
-- 	create temp table tmp_cap_val (nocapitulos integer);
-- end
-- -------------------------------------------------------------------
--borra toda la informacion vieja antes de grabar la nueva validacion
--delete from glwkcrys
-- where cry_nomrep = ps_nom_rep
--   and cry_idepcc = ps_ide_pcc
--   and cry_keyusu = pi_key_usu;
-- foreach
for cur_01 in (
select 	det_num_id, det_keyfol, det_keyemp, enc_keydep, con_keytva
-- into 	pi_num_id, pi_keyfol, pi_keyemp, ps_keydep, pi_tpo_val
from 	holoenctra, holodettra, holocont
where 	enc_num_id = det_num_id
and enc_stsrep = '2'
and det_stspag = 'P'
and det_stsreg = 'V'
and det_sindkto in ('ANDA','SITATYR','CONDUCTOR ART')
and (det_tipinc in ('N','LI'))
and  enc_fecpag = pd_fecpag
and con_keyemp = det_keyemp
and con_keyfol = det_keyfol)
loop
pi_num_id  := cur_01.det_num_id;
pi_keyfol  := cur_01.det_keyfol;
pi_keyemp  := cur_01.det_keyemp;
ps_keydep  := cur_01.enc_keydep;
pi_tpo_val := cur_01.con_keytva;
--ig-cons-0823
--se agrega validacion para tipo de validacion de contrato por llamados
if ( pi_tpo_val != 4) then
--checa capitulos pagados en rphs
--jcro cons-0530 (se agrego la tabla holococa)
insert into 	tmp_cap_val(nocapitulos)
select 			count(distinct coc_keycap) capitulos
from 			holocont, holohgdp, holococa
where			con_keyfol = hgd_keyfol
and con_keyemp = hgd_keyemp
and con_keyplz = coc_keyplz
and hgd_keyrph = coc_keyrph
and coc_stspag in ('V','E')
and hgd_keyemp = pi_keyemp
and hgd_keyfol = pi_keyfol
and con_keytco in (2,3,519);
--   select nvl(sum(hgd_numcap),0)
--     from holohgdp, holofrph, holocont
--    where hgd_keyrph = frp_keyrph and
--          hgd_keyemp = con_keyemp and
--	    hgd_keyfol = con_keyfol and
--          frp_keydep = con_keydep and
--	    hgd_keyemp = pi_keyemp and
--          hgd_keyfol = pi_keyfol and
--          frp_keydep = ps_keydep;
--jcro modificacion para agregar la liga con el centro de costos
--select nvl(sum(hgd_numcap),0)
--  from holohgdp
-- where hgd_keyemp = pi_keyemp
--   and hgd_keyfol = pi_keyfol;
--checa capitulos x pagar en rphs
--ig-cons-0823 modificado para tomar en cuenta los retroactivos 06/06/2014
--insert into tmp_cap_val (nocapitulos)
--select 		nvl(sum(gdp_numcap),0)
--from 		hologdpr
--where 		gdp_keyemp = pi_keyemp
--			and gdp_keyfol = pi_keyfol;
--ig-cons-0823 reemplaza la modificaciones anteriores
insert into tmp_cap_val(nocapitulos)
select 	coalesce(sum(gdp_numcap),0)
from  	hologdpr, holodettra
where  	gdp_keyemp = pi_keyemp
and gdp_keyfol = pi_keyfol
and gdp_keyemp = det_keyemp
and gdp_keyfol = det_keyfol
and gdp_keyrph = det_keyrph
and nullif(det_keyaut::text, '') is null;
--checa capitulos reservados en h.t.
insert into tmp_cap_val(nocapitulos)
select 		coalesce(sum((det_capfin - det_capini)+1),0)
from 		holodettra, nmcodeps
where 		det_keydep = dep_keydep
and det_keyemp = pi_keyemp
and det_keyfol = pi_keyfol
and det_stsreg = 'V'
and det_stspag = 'P'
and det_sindkto in ('ANDA','SITATYR','CONDUCTOR ART')
and det_tipinc in ('N','LI')
and nullif(det_keyaut::text, '') is null; --ig-cons-0823 modificado para tomar en cuenta los retroactivos 06/06/2014
--checa capitulos totales del contrato
insert into tmp_cap_val(nocapitulos)
select 		-coalesce(con_numcap,0)
from 		holocont
where 		con_keyemp = pi_keyemp
and con_keyfol = pi_keyfol;
--ig-cons-0823
--agregado para tipo de validacion por llamado
else
--checa capitulos pagados en rphs
insert into tmp_cap_val(nocapitulos)
select 		count(*) llamados
from 		holocont, holohgdp, holococa
where 		hgd_keyemp = pi_keyemp
and	hgd_keyfol = pi_keyfol
and con_keyemp = hgd_keyemp
and con_keyfol = hgd_keyfol
and con_keyplz = coc_keyplz
and hgd_keyrph = coc_keyrph
and coc_stspag in ('V','E')
and con_keytco in (2,3,519);
--checa capitulos x pagar en rphs
insert into tmp_cap_val(nocapitulos)
select 		count(*) llamados
from 		hologdpr, holodettra
where 		gdp_keyemp = pi_keyemp
and gdp_keyfol = pi_keyfol
and gdp_keyemp = det_keyemp
and gdp_keyfol = det_keyfol
and gdp_keyrph = det_keyrph
and nullif(det_keyaut::text, '') is null;
--checa capitulos reservados en h.t.
insert into tmp_cap_val(nocapitulos)
select 		count(*) llamados
from 		holodettra, nmcodeps
where 		det_keydep = dep_keydep
and det_keyemp = pi_keyemp
and det_keyfol = pi_keyfol
and det_stsreg = 'V'
and det_stspag = 'P'
and nullif(det_keyaut::text, '') is null;
--checa capitulos totales del contrato
insert into tmp_cap_val(nocapitulos)
select 		-count(*) llamados
from    	holocont, holococa
where 		con_keyemp = pi_keyemp
and con_keyfol = pi_keyfol
and coc_keycap = con_numcap
and coc_keyplz = con_keyplz;
end if;
--suma los capitulos o llamados en su caso
begin
select coalesce(sum(nocapitulos),0)
into strict pi_sumcap
from tmp_cap_val;
exception when no_data_found then pi_sumcap := 0;
end;
--si el valor es negativo tiene capitulos disponibles
if pi_sumcap > 0 then
if pi_consult = 1 then	-- solo es consulta
insert into glwkcrys(
cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_chr004)
values (
ps_nom_rep,
ps_ide_pcc,
pi_key_usu,
'CAPITULOS EXEDIDOS');
-- exit foreach;
exit;/* dmap converted statement start */
else				-- se graba el detalle del error
insert into glwkcrys(
cry_nomrep,
cry_idepcc,
cry_keyusu,
cry_chr004,
cry_chr002,
cry_numsec,
cry_chr001,
cry_chr014,
cry_dec006,
cry_chr003,
cry_dec007)
select distinct 	ps_nom_rep,
ps_ide_pcc,
pi_key_usu,
concat('Contrato :', det_keyfol)  dato_erroneo,
-- 'El Contrato ya exede por ' || sp_tochar(pi_sumcap) || ' al total de capitulos contratados'  error,
-- 'El Contrato ya exede por ' || to_char(pi_sumcap) || ' al total de capitulos contratados'  error,
concat('El Contrato exede por ', to_char(pi_sumcap) , ' al total de capitulos contratados')  error,
det_keyemp cve_empleado, coalesce(emp_nomemp,'EmpleadoInexistente') nombre,
to_char(det_fecpag,'%d/%b/%Y')  fecha_pago,
case when det_sindkto = 'CONDUCTOR ART' then 104
when det_sindkto = 'SITATYR' then 106
when det_sindkto = 'ANDA' then 110
end det_nomina,det_sindkto descripnom,
enc_num_id hojatrabajo
from 				holoenctra, holodettra, holocont, nmcoempl
where 				enc_num_id = det_num_id
and det_keyfol = con_keyfol
and det_keyemp = emp_keyemp
and det_keyemp = pi_keyemp
and det_keyfol = pi_keyfol
and det_num_id = pi_num_id;/* dmap converted statement end */
end if;
end if;
--delete from tmp_cap_val;
-- end foreach;
end loop;
-- drop table tmp_cap_val;
delete from tmp_cap_val where 1 = 1;end;
$body$
language plpgsql
;
