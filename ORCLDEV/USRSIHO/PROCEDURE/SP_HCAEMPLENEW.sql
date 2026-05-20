create or replace procedure usrsiho."sp_hcaemplenew"  ( ws_key_dep varchar, ws_key_pue varchar, ws_nom_emp varchar, ws_nom_cor varchar, ws_dom_emp varchar, ws_col_emp varchar, ws_cid_emp varchar, ws_pob_emp varchar, ws_mun_emp varchar, ws_ent_emp varchar, ws_cod_emp varchar, ws_tel_emp varchar, ws_reg_rfc varchar, ws_recurp varchar, ws_cve_sex varchar, ws_cve_zon numeric, ws_tip_emp varchar, ws_status numeric, ws_cve_ban varchar, ws_cta_ban varchar, ws_ca3_aux varchar, ws_for_pag varchar, ws_ca2_aux varchar, ws_key_pro numeric, ws_fec_ing timestamp(0), ws_ref_con varchar, ws_mar_per varchar, ws_fec_nac timestamp(0), ws_cr_anda numeric, ws_cal_sin varchar, ws_pais_rs varchar, ws_tel_em2 varchar, ws_origen varchar, ws_keytco numeric, ws_cedula varchar, ws_rel_pag numeric, ws_key_pr2 numeric, ws_key_em2 numeric, ws_are_fis varchar, ws_tel_em3 varchar, ws_dom_em1 varchar, ws_statu1 numeric, ws_bandera varchar, wn_keyemp1 numeric, ws_mar_rfc varchar, ws_ctasin numeric, ws_regims varchar, ws_reginf varchar, ws_mot_baj varchar, ws_fec_baj varchar, ws_key_con varchar, ws_cta_alt varchar, ws_tel_em4 varchar, ws_area_ant varchar, ws_proc_ant varchar, ws_cdgo_ant varchar, ws_da_keydep varchar, ws_da_keypue varchar, ws_da_tipjefe numeric, ws_da_keyjefe numeric, ws_da_tipemp numeric, ws_da_keycon numeric, ws_da_numcon numeric, ws_num_int varchar, ws_num_ext varchar, wn_num_emp inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- -------------------------------------------------------------------------------------------------------------------------------
-- aedo 15/junio/05   se cambiaron las longitudes de las siguientes variables a 40 caracteres
--                    ws_cid_emp
--                    ws_pob_emp
--                    ws_num_int
--                    ws_num_ext
--
-- -------------------------------------------------------------------------------------------------------------------------------
-- eligio juarez m. (eljm) 07/jul/2012  modificacion para la correcta generacion de codigos unicos.
--
-- -------------------------------------------------------------------------------------------------------------------------------
-- returning number;
wn_key_emp numeric;
ws_key_emp varchar(9);
ws_pre_fij varchar(3);
wn_con_sec numeric;
ws_con_sec varchar(9);
ws_cve_gpo varchar(3);
wn_num_bus varchar(9);
wn_busca   smallint;
wn_num_max numeric;
wn_num_sec numeric;
-- wn_num_emp number;
wn_num_ssec numeric;
wn_cod_emp numeric;
wn_buscada smallint;
ws_fec_mod timestamp(0);
begin
-- set debug file to "/tmp/sp_hcaemplenew.txt";
-- trace on;
-- ws_fec_mod := sysdate;
select clock_timestamp()
into strict ws_fec_mod
;
if ws_bandera = 'I' then --insercion
-- si el codigo2 es null calcularl el siguiente
-- en otro caso calcularlo => tomarlo como emp_keyemp
if nullif(ws_key_em2::text, '') is null or ws_key_em2 = 0 then
ws_pre_fij := ' ';
wn_con_sec := 0;
begin
select xco_prefij, gru_consec, gru_cvegpo
into strict ws_pre_fij, wn_con_sec, ws_cve_gpo
from agrupxcod, consagrup
where xco_cvegpo = gru_cvegpo
and xco_keypro = ws_key_pro;
exception when no_data_found then ws_pre_fij:= null; wn_con_sec := 0; ws_cve_gpo:= null;
end;
-- ----------------------------- checo que el prefijo o el numero consecutivo que no esten vacios
if length(trim(both ws_pre_fij)) = 0 or wn_con_sec = 0 then
-- return -1;
wn_num_emp := -1;
end if;
-- ----------------------------- incremento el numero consecutivo
wn_con_sec := wn_con_sec + 1;/* dmap converted statement start */
--  ---------------------------- asigno a una variable string el que sera el nuevo codigo de empleado
ws_con_sec := concat( trim(both ws_pre_fij), lpad(wn_con_sec::text, 7, 0::text)) ;/* dmap converted statement end */
-- ----------------------------------------------
wn_key_emp := ws_con_sec;
-- ---------------- actualizo el numero consecutivo
update consagrup set gru_consec = wn_con_sec
where gru_cvegpo = ws_cve_gpo;
-- ----------------------------- desbloqueo la tabla consagrup
-- unlock table consagrup;
else
-- si encuentra el numero de empleado ya dado de alta => error
select count(emp_keyemp::text)
into strict wn_key_emp
from nmcoempl
where emp_keyemp = ws_key_em2
and emp_keypro = ws_key_pro;
if wn_key_emp > 0 then
-- return -1;
wn_num_emp := -1;
end if;
wn_key_emp := ws_key_em2;
end if;
insert into nmcoempl( emp_keyemp, emp_keydep, emp_keypue, emp_nomemp,
emp_nomcor, emp_domemp, emp_colemp, emp_cidemp,
emp_pobemp, emp_munemp, emp_entemp, emp_codemp,
emp_telemp, emp_regrfc, emp_recurp, emp_cvesex,
emp_cvezon, emp_tipemp, emp_status, emp_cveban,
emp_ctaban, emp_ca3aux, emp_forpag, emp_ca2aux,
emp_keypro, emp_fecing, emp_refcon, emp_salmes,
emp_regims, emp_reginf, emp_cvebaj, emp_fecbaj,
emp_ca1aux, emp_keycen, emp_fecmod )
values ( wn_key_emp, ws_key_dep, ws_key_pue, ws_nom_emp,
ws_nom_cor, ws_dom_emp, ws_col_emp, ws_cid_emp,
ws_pob_emp, ws_mun_emp, ws_ent_emp, ws_cod_emp,
ws_tel_emp, ws_reg_rfc, ws_recurp,  ws_cve_sex,
ws_cve_zon, ws_tip_emp, ws_status,  oracle.substr(ws_cve_ban,1,7),
ws_cta_ban, ws_ca3_aux, ws_for_pag, ws_ca2_aux,
ws_key_pro, ws_fec_ing, ws_ref_con, ws_ctasin,
ws_regims , ws_reginf , ws_mot_baj, to_timestamp(ws_fec_baj,'DD/MM/YYYY'),
ws_key_con, ws_tel_em4, ws_fec_mod );
insert into holoalem( ale_keyemp, ale_marper, ale_fecnac, ale_cranda,
ale_calsin, ale_paisrs, ale_telem2, ale_origen,
ale_keytco, ale_cedula, ale_relpag, ale_keypr2,
ale_keyem2, ale_arefis, ale_telem3, ale_domemp,
ale_status, ale_marrfc, ale_numint, ale_numext )
values ( wn_key_emp, ws_mar_per, ws_fec_nac, ws_cr_anda,
ws_cal_sin, ws_pais_rs, ws_tel_em2, ws_origen,
ws_keytco,  ws_cedula,  ws_rel_pag, ws_key_pr2,
ws_key_em2, ws_are_fis, ws_tel_em3, ws_dom_em1,
ws_statu1,  ws_mar_rfc, ws_num_int, ws_num_ext );
insert into nmloctas( cta_keypro, cta_keyemp, cta_ctaban )
values ( ws_key_pro, wn_key_emp, ws_cta_alt );
insert into nmdtaemp( aem_keyemp, aem_keydep,
aem_keypue, aem_tipem2,
aem_keyem2, aem_tipemp,
aem_keytco, aem_keyfol )
values ( wn_key_emp, ws_da_keydep,
ws_da_keypue, ws_da_tipjefe,
ws_da_keyjefe, ws_da_tipemp,
ws_da_keycon, ws_da_numcon );
wn_num_emp := wn_key_emp;
--      return wn_key_emp;
else   --actualizacion
--dbms_output.put_line('Actualiza');
--wn_keyemp1
update nmcoempl
set emp_keydep = ws_key_dep,  emp_keypue = ws_key_pue,
emp_nomemp = ws_nom_emp,  emp_nomcor = ws_nom_cor,
emp_domemp = ws_dom_emp,  emp_colemp = ws_col_emp,
emp_cidemp = ws_cid_emp,  emp_pobemp = ws_pob_emp,
emp_munemp = ws_mun_emp,  emp_entemp = ws_ent_emp,
emp_codemp = ws_cod_emp,  emp_telemp = ws_tel_emp,
emp_regrfc = ws_reg_rfc,  emp_recurp = ws_recurp,
emp_cvesex = ws_cve_sex,  emp_cvezon = ws_cve_zon,
emp_tipemp = ws_tip_emp,  emp_status = ws_status,
emp_cveban = oracle.substr(ws_cve_ban,1,7),  emp_ctaban = ws_cta_ban,
emp_ca3aux = ws_ca3_aux,  emp_forpag = ws_for_pag,
emp_ca2aux = ws_ca2_aux,  emp_keypro = ws_key_pro,
emp_fecing = ws_fec_ing,  emp_refcon = ws_ref_con,
emp_salmes = ws_ctasin,   emp_regims = ws_regims,
emp_reginf = ws_reginf,   emp_cvebaj = ws_mot_baj,
emp_fecbaj = to_timestamp(ws_fec_baj,'DD/MM/YYYY'),  emp_ca1aux = ws_key_con,
emp_keycen = ws_tel_em4,  emp_fecmod =  ws_fec_mod
where emp_keyemp = wn_keyemp1;
update holoalem
set ale_marper = ws_mar_per, ale_fecnac = ws_fec_nac,
ale_cranda = ws_cr_anda, ale_calsin = ws_cal_sin,
ale_paisrs = ws_pais_rs, ale_telem2 = ws_tel_em2,
ale_origen = ws_origen,  ale_keytco = ws_keytco,
ale_cedula = ws_cedula,  ale_relpag = ws_rel_pag,
ale_keypr2 = ws_key_pr2, ale_keyem2 = ws_key_em2,
ale_arefis = ws_are_fis, ale_telem3 = ws_tel_em3,
ale_domemp = ws_dom_em1, ale_status = ws_statu1,
ale_marrfc = ws_mar_rfc, ale_numint = ws_num_int,
ale_numext = ws_num_ext
where ale_keyemp = wn_keyemp1;
update nmloctas
set cta_keypro = ws_key_pro,
cta_ctaban = ws_cta_alt
where cta_keyemp = wn_keyemp1;
select count(*) into strict wn_buscada
from nmdtaemp
where aem_keyemp = wn_keyemp1;
if wn_buscada = 0 then
insert into nmdtaemp( aem_keyemp, aem_keydep,
aem_keypue, aem_tipem2,
aem_keyem2, aem_tipemp,
aem_keytco, aem_keyfol )
values ( wn_keyemp1, ws_da_keydep,
ws_da_keypue, ws_da_tipjefe,
ws_da_keyjefe, ws_da_tipemp,
ws_da_keycon, ws_da_numcon );
else
update nmdtaemp
set aem_keydep = ws_da_keydep, aem_keypue = ws_da_keypue,
aem_tipem2 = ws_da_tipjefe, aem_keyem2 = ws_da_keyjefe,
aem_tipemp = ws_da_tipemp, aem_keytco = ws_da_keycon,
aem_keyfol = ws_da_numcon
where aem_keyemp = wn_keyemp1;
end if;
wn_num_emp := wn_keyemp1;
--      return wn_keyemp1 ;
end if;
-- --------------------------------------------------------------------------------------
--busca registro en tabla de trayectoria
wn_num_bus := 0;
wn_num_max := 0;
if ws_bandera = 'I' then
wn_num_bus := wn_key_emp;
else
wn_num_bus := wn_keyemp1;
end if;
if length(trim(both wn_num_bus)) = 9 then
select 	count(*)
into strict 		wn_busca
from 		glcocons
where 	oracle.substr(con_keyemp,3) = oracle.substr(wn_num_bus,3);
if ws_cdgo_ant = not null and length(trim(both ws_cdgo_ant)) < 9 then
select 	count(*)
into strict 		wn_busca
from 		glcocons
where 	con_keyemp = ws_cdgo_ant;
end if;
else
wn_num_ssec := wn_num_bus;
select 	count(*)
into strict 		wn_busca
from 		glcocons
where 	con_keyemp = wn_num_ssec;
end if;
if ws_bandera = 'I' then --insercion
if ws_area_ant = null and ws_proc_ant = null and ws_cdgo_ant = null then
if wn_busca = 0 then
select coalesce(max(con_keycvc), 0) + 1 into strict wn_num_max from glcocons;
-- wn_num_max := wn_num_max + 1;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,clock_timestamp());
else
-- return -1;
wn_num_emp := -1;
end if;
else
if wn_busca = 0 then
---------------------------------------------------------------------------------------
--  eljm
begin
select 	con_keycvc
into strict 		wn_num_max
from 		glcocons
where 	con_keyemp = ws_cdgo_ant;
exception when no_data_found then wn_num_max := 1;
end;
-- ejecuta insert
insert into glcocons(con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
values (wn_num_max, wn_num_bus, ws_key_pro, ws_are_fis, ws_fec_mod);
----------------------------------------------------------------------------------------
-- eljm
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
--
-- select 	nvl(max(con_keycvc), 0)
-- into 		wn_num_max
-- from 		glcocons;			-- wn_num_max=55068
--
-- let wn_num_max = wn_num_max + 1;		-- wn_num_max = 55068+1 = 55069
--
-- -- caso 1 ejecuta insert
-- insert into glcocons (con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
--         values (wn_num_max, wn_num_bus, ws_key_pro, ws_are_fis, today);
--
-- -- caso 1 ejecuta insert
-- insert into glcocons (con_keycvc, con_keyemp, con_keypro, con_keyapr, con_fecalt)
--         values (wn_num_max, ws_cdgo_ant, ws_proc_ant, ws_area_ant, today);
--
-- unlock table glcocons;
------------------------------------------------------------------
else
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
if length(trim(both wn_num_bus)) = 9 then
begin
select distinct(con_keycvc)
into strict wn_num_sec
from glcocons
where oracle.substr(con_keyemp,3) = oracle.substr(wn_num_bus,3);
exception when no_data_found then wn_num_sec := 1;
end;
if ws_cdgo_ant = not null and length(trim(both ws_cdgo_ant)) < 9 then
begin
select distinct(con_keycvc)
into strict wn_num_sec
from glcocons
where con_keyemp = ws_cdgo_ant;
exception when no_data_found then wn_num_sec := 1;
end;
end if;
else
wn_num_ssec := wn_num_bus;
begin
select distinct(con_keycvc)
into strict wn_num_sec
from glcocons
where oracle.substr(con_keyemp,3) = wn_num_ssec;
exception when no_data_found then wn_num_sec := 1;
end;
end if;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_sec,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
-- unlock table glcocons;
end if;
end if;
else
if ws_area_ant <> ws_are_fis or ws_proc_ant <> ws_key_pro or ws_cdgo_ant <> wn_num_bus then
if wn_busca = 0 then
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
select coalesce(max(con_keycvc), 0) + 1
into strict wn_num_max
from glcocons;
-- wn_num_max := wn_num_max + 1;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_max,ws_cdgo_ant,ws_proc_ant,ws_area_ant,ws_fec_mod);
-- unlock table glcocons;
else
-- actualizar e insertar si cambia el numero de empleado.
if ws_cdgo_ant = wn_num_bus then
update glcocons set con_keypro = ws_key_pro, con_keyapr = ws_are_fis
where  con_keypro = ws_cdgo_ant
and    con_keyapr = ws_area_ant
and    con_keyemp = ws_cdgo_ant;
else
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
--dbms_output.put_line(wn_num_bus);
if length(trim(both wn_num_bus)) = 9 then
begin
select distinct(con_keycvc)
into strict wn_num_sec
from glcocons
where oracle.substr(con_keyemp,3) = oracle.substr(wn_num_bus,3);
exception when no_data_found then wn_num_sec := 1;
end;
else
wn_num_ssec := wn_num_bus;
begin
select distinct(con_keycvc)
into strict wn_num_sec
from glcocons
where oracle.substr(con_keyemp,3) = wn_num_ssec;
exception when no_data_found then wn_num_sec := 1;
end;
end if;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_sec,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
-- unlock table glcocons;
end if;
end if;
else
if wn_busca = 0 then
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
select coalesce(max(con_keycvc), 0) + 1 into strict wn_num_max from glcocons;
-- wn_num_max := wn_num_max + 1;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
-- unlock table glcocons;
else
select count(*) into strict wn_cod_emp from glcocons
where con_keyemp = wn_num_bus;
if wn_cod_emp = 0 then
-- set lock mode to wait;
-- lock table glcocons in exclusive mode;
select coalesce(max(con_keycvc), 0) + 1 into strict wn_num_max from glcocons;
-- wn_num_max := wn_num_max + 1;
insert into glcocons(con_keycvc,con_keyemp,con_keypro,con_keyapr,con_fecalt)
values (wn_num_max,wn_num_bus,ws_key_pro,ws_are_fis,ws_fec_mod);
-- unlock table glcocons;
end if;
end if;
end if;
end if;
--   return wn_num_emp;
-- trace off;
end;
$body$
language plpgsql
;
