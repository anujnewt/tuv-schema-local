create or replace procedure labconf."sp_nmlstvec"  ( ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de versiones contables
wn_key_ver numeric(5);
ws_cta_car varchar(20);
ws_ref_cta varchar(30);
ws_tip_exc varchar(1);
ws_key_con varchar(3);
ws_cta_abo varchar(20);
-- variables para el reporte de avance
wn_tot_reg numeric(10):=0;
wn_num_reg numeric(10):=0;
wn_pct_act numeric(5):=0;
wn_pct_reg decimal(6,2);
ws_hor_act glwkcrys.cry_chr045%type;
ws_des_cor glwkcrys.cry_chr001%type;
ws_des_lis glwkcrys.cry_chr007%type;
ws_dia_act glwkcrys.cry_dat004%type;
-- variables para la carga de las descripciones de las etiquetas
ws_key_cam varchar(20);
ws_dsp_cam varchar(1);
-- variables de despliegue
wn_dsp_001 numeric(5) := 0;
wn_dsp_002 numeric(5) := 0;
wn_dsp_003 numeric(5) := 0;
wn_dsp_004 numeric(5) := 0;
wn_dsp_005 numeric(5) := 0;
wn_dsp_006 numeric(5) := 0;
--variables para las etiquetas del diccionario de datos
ws_ver_sio glwkcrys.cry_chr011%type;
ws_car_gos glwkcrys.cry_chr018%type;
ws_ref_ere glwkcrys.cry_chr019%type;
ws_exc_epc glwkcrys.cry_chr020%type;
ws_con_cep glwkcrys.cry_chr022%type;
ws_abo_nos glwkcrys.cry_chr023%type;
c_desplieg record;
c_nmlstvec record;
begin
call sp_glfechor (ws_dia_act,ws_hor_act);
-- realiza el conteo de registros a procesar
select count(*) into strict wn_tot_reg from nmloverc
where ver_keyver in ( select ran_keypro from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null )
and ver_tipexc in ( select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu );
-- inserta registro para monitoreo de resultados                --
insert into glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_dia_act, ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report                 --
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
-- extrae el nombre de la compa?coorporativa
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor	from glcocorp;
-- extrae el nombre del reporte
ws_des_lis := sp_glgetrep(ws_nom_rep,'No existe nombre del Reporte ...',50);
--extrae las etiquetas del diccionario de datos
ws_ver_sio := sp_glgetdsc('nmloverc','ver_keyver','........',null);
ws_car_gos := sp_glgetdsc('nmloverc','ver_ctacar','........',null);
ws_ref_ere := sp_glgetdsc('nmloverc','ver_refcta','........',null);
ws_exc_epc := sp_glgetdsc('nmloverc','ver_tipexc','........',null);
ws_con_cep := sp_glgetdsc('nmloverc','ver_keycon','........',null);
ws_abo_nos := sp_glgetdsc('nmloverc','ver_ctaabo','........',null);
-- extrae las restricciones de despliegue                       --
for c_desplieg in ( select rec_keycam, rec_despli from glcoreca
where rec_keytab = 'nmloverc' and
rec_keymen = ws_key_men ) loop
ws_key_cam := c_desplieg.rec_keycam;
ws_dsp_cam := c_desplieg.rec_despli;
if ( ws_key_cam = 'ver_keyver') and ( ws_dsp_cam = 'N') then
wn_dsp_001 := 1;
end if;
if ( ws_key_cam = 'ver_ctacar') and ( ws_dsp_cam = 'N') then
wn_dsp_002 := 1;
end if;
if ( ws_key_cam = 'ver_refcta') and ( ws_dsp_cam = 'N') then
wn_dsp_003 := 1;
end if;
if ( ws_key_cam = 'ver_tipexc') and ( ws_dsp_cam = 'N') then
wn_dsp_004 := 1;
end if;
if ( ws_key_cam = 'ver_keycon') and ( ws_dsp_cam = 'N') then
wn_dsp_005 := 1;
end if;
if ( ws_key_cam = 'ver_ctaabo') and ( ws_dsp_cam = 'N') then
wn_dsp_006 := 1;
end if;
end loop;
-- inicializa variables de trabajo para realizar cortes y monitoreo
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=wn_tot_reg / 10.0;
-- define cursor principal-----------------------------------------
/* commit; */
for c_nmlstvec in ( select ver_keyver, ver_ctacar, ver_refcta,
ver_tipexc, ver_keycon, ver_ctaabo
from nmloverc
where ver_keyver in ( select ran_keypro from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keypro::text, '') is not null )
and ver_tipexc in ( select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keycon::text, '') is not null )
order by  ver_keyver,ver_tipexc) loop
wn_key_ver := c_nmlstvec.ver_keyver;
ws_cta_car := c_nmlstvec.ver_ctacar;
ws_ref_cta := c_nmlstvec.ver_refcta;
ws_tip_exc := c_nmlstvec.ver_tipexc;
ws_key_con := c_nmlstvec.ver_keycon;
ws_cta_abo := c_nmlstvec.ver_ctaabo;
-- actualiza registro de monitoreo
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
update glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep and
res_idepcc = ws_ide_pcc and
res_keyusu = wn_key_usu and
res_fecini = ws_dia_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
end if;
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_ver := null;
end if;
if wn_dsp_002 = 1 then
ws_cta_car := null;
end if;
if wn_dsp_003 = 1 then
ws_ref_cta := null;
end if;
if wn_dsp_004 = 1 then
ws_tip_exc := null;
end if;
if wn_dsp_005 = 1 then
ws_key_con := null;
end if;
if wn_dsp_006 = 1 then
ws_cta_abo := null;
end if;
-- inserta en la tabla de trabajo del crystal report
insert into glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_dec006,
cry_chr008, cry_chr004, cry_chr017, cry_chr018, cry_chr009,
cry_dat001, cry_dec007, cry_chr002, cry_chr011, cry_chr020,
cry_chr021, cry_chr022, cry_chr023, cry_chr024, cry_chr025)
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_ver,
ws_cta_car, ws_ref_cta, ws_tip_exc, ws_key_con, ws_cta_abo,
ws_dia_act, wn_tot_reg, ws_des_lis, ws_ver_sio, ws_car_gos,
ws_ref_ere, ws_exc_epc, ws_con_cep, ws_abo_nos, ws_hor_act);
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion    --
-- del proceso.
call sp_glfechor (ws_dia_act,ws_hor_act);
update glcoresu set res_numreg = wn_num_reg,
res_fecfin = ws_dia_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep and
res_idepcc = ws_ide_pcc and
res_keyusu = wn_key_usu and
res_fecini = ws_dia_act and
res_horreg = ws_hor_reg;
/* commit; */
end;
$body$
language plpgsql
;
