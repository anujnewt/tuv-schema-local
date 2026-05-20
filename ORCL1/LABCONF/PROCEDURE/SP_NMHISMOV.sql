create or replace procedure labconf."sp_nmhismov"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, ws_etq_rep varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de historico de movimientos.
ws_cod_imp varchar(2);
wn_key_pro numeric(10);
ws_des_pro varchar(20);
-- variables para las restricciones de despliegue.
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
-- variables para el reporte de avance y auxiliares.
wn_tot_reg numeric(10) := -1;
wn_num_reg numeric(10) := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)  := 1;
ws_key_cia varchar(5)    := '..';
wn_emp_ant numeric(10) := 999999999;
wn_can_mov glwkcrys.cry_dec001%type;
wn_imp_mov glwkcrys.cry_dec002%type;
wn_key_emp glwkcrys.cry_dec007%type;
ws_des_con glwkcrys.cry_chr003%type;
ws_des_cor glwkcrys.cry_chr001%type := 'CORPORATIVO NO REGISTRADO ...';
ws_des_lis glwkcrys.cry_chr004%type := sp_glgetrep(ws_nom_rep, 'No existe nombre del Reporte', 40);
ws_etq_001 glwkcrys.cry_chr019%type := sp_glgetdsc('nmlohism', 'his_keycon', '........', null);
ws_etq_002 glwkcrys.cry_chr020%type := sp_glgetdsc('nmlohism', 'his_cantid', '........', null);
ws_etq_003 glwkcrys.cry_chr021%type := sp_glgetdsc('nmlohism', 'his_import', '........', null);
ws_etq_004 glwkcrys.cry_chr022%type := sp_glgetdsc('nmlohism', 'his_keyper', '........', null);
ws_etq_005 glwkcrys.cry_chr023%type := sp_glgetdsc('nmlohism', 'his_keypro', '........', null);
ws_etq_006 glwkcrys.cry_chr026%type := sp_glgetdsc('nmloconc', 'con_descon', 'DESCRIP.', null);
ws_fec_act glwkcrys.cry_dat003%type;
ws_hor_act glwkcrys.cry_chr028%type;
ws_key_con glwkcrys.cry_chr018%type;
ws_key_per glwkcrys.cry_chr017%type;
ws_nom_emp glwkcrys.cry_chr002%type;
i          numeric(10);
j          numeric(10);
k          numeric(10);
wn_con_reg numeric(10) := 0;
wn_lim_ite numeric(10) := 100;
c_descor record;
c_descia record;
c_nmhismov record;
c_datemp record;
c_descon record;
c_despro record;
begin
-- variables para las restricciones de despliegue.
call labconf.sp_glgetdsp ('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
call labconf.sp_glgetdsp ('nmlohism', 'his_keycon', ws_key_men,wn_dsp_002);
call labconf.sp_glgetdsp ('nmlohism', 'his_cantid', ws_key_men,wn_dsp_003);
call labconf.sp_glgetdsp ('nmlohism', 'his_import', ws_key_men,wn_dsp_004);
call labconf.sp_glgetdsp ('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
call labconf.sp_glfechor (ws_fec_act,ws_hor_act);
-- inserta registro para monitoreo de resultados.
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
/* commit; */
-- extrae el nombre de la compania corporativa.
for c_descor in (select pro_keycia
from labconf.nmloproc
where pro_keypro in (
select his_keypro from labconf.nmwkhism
where  his_idepcc = ws_ide_pcc)) loop
ws_key_cia := c_descor.pro_keycia;
end loop;
for c_descia in (select oracle.substr(cia_descia,1,60) cia_descia
from labconf.nmlocias
where cia_keycia = ws_key_cia) loop
ws_des_cor := c_descia.cia_descia;
end loop;
-- inicializa variables de trabajo                                                         --
wn_emp_ant := 999999999;
-- cursor principal.
for c_nmhismov in (
select his_keyemp, his_keycon, his_cantid,
his_import, his_keyper, his_codimp, his_keypro
from labconf.nmwkhism
where his_idepcc =  ws_ide_pcc
order by  his_keyemp, his_codimp, his_keycon, his_keyper) loop
wn_key_emp := c_nmhismov.his_keyemp;
ws_key_con := c_nmhismov.his_keycon;
wn_can_mov := c_nmhismov.his_cantid;
wn_imp_mov := c_nmhismov.his_import;
ws_key_per := c_nmhismov.his_keyper;
ws_cod_imp := c_nmhismov.his_codimp;
wn_key_pro := c_nmhismov.his_keypro;
-- extrae los datos del empleado.
if nullif(wn_key_emp::text, '') is null then
ws_nom_emp := 'EMPLEADO NO EXISTE ...';
else
if wn_emp_ant <> wn_key_emp then
i := 0;
j := 0;
k := 0;
for c_datemp in (select emp_nomemp
from labconf.nmcoempl
where emp_keyemp = wn_key_emp) loop
ws_nom_emp := c_datemp.emp_nomemp;
end loop;
wn_emp_ant := wn_key_emp;
-- aplica restricciones
if wn_dsp_001 = 1 then
wn_key_emp := null;
ws_nom_emp := null;
end if;
end if;
end if;
-- extrae la descripcion del concepto.
ws_des_con := 'CONCEPTO NO EXISTE ...';
for c_descon in (select con_descor
from labconf.nmloconc
where con_keycon = ws_key_con) loop
ws_des_con := c_descon.con_descor;
end loop;
-- extrae la descripcion de los procesos
ws_des_pro := 'PROCESO NO EXISTE...';
for c_despro in (
select pro_despro from labconf.nmloproc
where pro_keypro = wn_key_pro)loop
ws_des_pro:=c_despro.pro_despro;
end loop;
-- condicion para extraer las percepciones.
if ws_cod_imp = '01' then
-- aplica restricciones de despliegue de campos.
if wn_dsp_002 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_003 = 1 then
wn_can_mov := null;
end if;
if wn_dsp_004 = 1 then
wn_imp_mov := null;
end if;
if wn_dsp_005 = 1 then
ws_key_per := null;
end if;
-- incrementa en 1 el contador i.
i := i + 1;
-- inserta en la tabla de trabajo de crystal report.
insert into labconf.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001,
cry_chr017, cry_dec007, cry_chr002, cry_chr018, cry_chr006,
cry_dec001, cry_dec002, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr028, cry_dat003, cry_chr029,
cry_chr007, cry_dec003, cry_dec004, cry_dec008, cry_chr008,
cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
cry_chr025, cry_chr026, cry_chr004)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, i         , ws_des_cor,
ws_key_per, wn_key_emp, ws_nom_emp, ws_key_con, ws_des_con,
wn_can_mov, wn_imp_mov, ws_etq_001, ws_etq_002, ws_etq_003,
ws_etq_004, ws_etq_005, ws_hor_act, ws_fec_act, null      ,
null      , null      , null      , wn_key_pro,	ws_des_pro,
null      , null      , null      , null      , null      ,
null      ,ws_etq_006 , ws_des_lis);
/* commit; */
end if;
if ws_cod_imp = '02' then
-- aplica restricciones de despliegue de campos                                     --
if wn_dsp_002 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_003 = 1 then
wn_can_mov := null;
end if;
if wn_dsp_004 = 1 then
wn_imp_mov := null;
end if;
if wn_dsp_005 = 1 then
ws_key_per := null;
end if;
-- realiza update o insert dependiendo de el control i y j.
j := j + 1;
if j > i then
insert into labconf.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr017,
cry_dec007, cry_chr002, cry_chr018, cry_chr006, cry_dec001, cry_dec002,
cry_chr019, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr028,
cry_dat003, cry_chr029, cry_chr007, cry_dec003, cry_dec004, cry_dec008,
cry_chr008, cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
cry_chr025, cry_chr026, cry_chr004)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, j         , ws_des_cor, null      ,
wn_key_emp, ws_nom_emp, null      , null      , null      , null      ,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005, ws_hor_act,
ws_fec_act, ws_key_con, ws_des_con, wn_can_mov, wn_imp_mov, wn_key_pro,
ws_des_pro, null      ,  null     , null      , null      , ws_key_per,
null      , ws_etq_006,  ws_des_lis);
else
update labconf.glwkcrys
set cry_chr029 = ws_key_con,
cry_chr007 = ws_des_con,
cry_dec003 = wn_can_mov,
cry_dec004 = wn_imp_mov,
cry_chr024 = ws_key_per
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu and
cry_numsec = j          and
cry_dec007 = wn_key_emp;
end if;
/* commit; */
end if;
if ws_cod_imp = '03' then
-- aplica restricciones de despliegue de campos                                     --
if wn_dsp_002 = 1 then
ws_key_con := null;
ws_des_con := null;
end if;
if wn_dsp_003 = 1 then
wn_can_mov := null;
end if;
if wn_dsp_004 = 1 then
wn_imp_mov := null;
end if;
if wn_dsp_005 = 1 then
ws_key_per := null;
end if;
-- realiza update o insert dependiendo de el control j y k.
k := k + 1;
if k > j then
insert into labconf.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr017,
cry_dec007, cry_chr002, cry_chr018, cry_chr006, cry_dec001, cry_dec002,
cry_chr019, cry_chr020, cry_chr021, cry_chr022, cry_chr023, cry_chr028,
cry_dat003, cry_chr029, cry_chr007, cry_dec003, cry_dec004, cry_dec008,
cry_chr008, cry_chr030, cry_chr003, cry_dec005, cry_dec011, cry_chr024,
cry_chr025, cry_chr026, cry_chr004)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, k          , ws_des_cor, null      ,
wn_key_emp, ws_nom_emp, null      , null       , null      , null      ,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004 , ws_etq_005, ws_hor_act,
ws_fec_act, null      , null      , null       , null      , wn_key_pro,
ws_des_pro, ws_key_con, ws_des_con, wn_can_mov , wn_imp_mov, null      ,
ws_key_per, ws_etq_006, ws_des_lis);
else
update labconf.glwkcrys
set cry_chr030 = ws_key_con,
cry_chr003 = ws_des_con,
cry_dec005 = wn_can_mov,
cry_dec011 = wn_imp_mov,
cry_chr025 = ws_key_per
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu and
cry_numsec = k          and
cry_dec007 = wn_key_emp;
end if;
/* commit; */
end if;
end loop;
/* commit; */
end;
$body$
language plpgsql
;
