create or replace procedure labprod."sp_nminem01"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_nom_ran varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_ant_pro numeric(5);
ws_ant_per varchar(7);
ws_ant_dep varchar(16);
wn_ant_emp numeric(10);
ws_ant_con varchar(3);
ws_ant_fol varchar(10);
wn_row_ide numeric(10);
ws_key_cia varchar(5);
ws_key_cam varchar(20);
ws_des_eti varchar(40);
ws_des_etq varchar(8);
ws_dsp_cam varchar(1);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_dsp_007 numeric(5);
wn_dsp_008 numeric(5);
wn_dsp_009 numeric(5);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
wn_num_tem numeric(5);
ws_des_cor varchar(100);
wn_key_emp numeric(10);
ws_key_con varchar(16);
wn_can_tid decimal(18,6);
wn_imp_ort decimal(18,6);
wd_fec_mov timestamp(0);
ws_key_dep varchar(16);
ws_key_pue varchar(16);
wn_key_pro numeric(5);
ws_key_per varchar(8);
ws_des_con varchar(40);
ws_nom_emp varchar(60);
ws_des_pro varchar(20);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_num_fol varchar(16);
ws_nom_usu varchar(40);
wd_fec_act timestamp(0);
ws_hor_act varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(8);
ws_etq_005 varchar(8);
ws_etq_006 varchar(8);
ws_etq_007 varchar(8);
ws_etq_008 varchar(8);
ws_etq_009 varchar(8);
ws_etq_010 varchar(8);
ws_etq_011 varchar(8);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_012 varchar(8);
ws_des_dep varchar(40);
ws_des_lis varchar(60);
wn_con_reg numeric(5);
wn_lim_ite numeric(5);
ws_ca1_aux varchar(10);
c_deslis record;
c_etiqueta record;
c_nmlstinc record;
c_nomusu record;
c_descon record;
c_nomemp record;
c_desdep record;
c_despro record;
c_descia record;
begin
call labprod.sp_glfechor (wd_fec_act, ws_hor_act);
wn_ant_pro:=-32760;
ws_ant_per:='______________';
ws_ant_dep:='________________________________';
wn_ant_emp:=-999999999;
ws_ant_con:='______';
ws_ant_fol:='____________________';
wn_num_reg:=0;
wn_pct_act:=1;
wn_con_reg:=0;
wn_lim_ite:=100;
begin select  count(* ) alias1
into strict wn_tot_reg from labprod.nmcoinci
where inc_keyinc in (
select cry_dec001 from labprod.glwkcrys
where cry_nomrep = ws_nom_ran
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu
and nullif(cry_dec001::text, '') is not null );
exception
when no_data_found then
null;
end;
insert into labprod.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from labprod.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO ..';
begin select cor_razsoc
into strict ws_des_cor from labprod.glcocorp;
exception
when no_data_found then
null;
end;
ws_des_lis:='Reporte de Incidencias';
for c_deslis in ( select lis_deslis from labprod.glcolist
where lis_keylis = ws_nom_rep ) loop
ws_des_lis :=c_deslis.lis_deslis;/* dmap converted statement start */
ws_des_lis:= rtrim(ltrim(ws_des_lis)::text);/* dmap converted statement end */
end loop;
ws_etq_001:='.......';
ws_etq_002:='.......';
ws_etq_003:='.......';
ws_etq_004:='.......';
ws_etq_005:='.......';
ws_etq_006:='.......';
ws_etq_007:='.......';
ws_etq_008:='.......';
ws_etq_009:='.......';
ws_etq_010:='.......';
ws_etq_011:='.......';
ws_etq_012:='.......';
for c_etiqueta in ( select cam_keycam, cam_descor, cam_descam from labprod.glcocamp
where cam_keytab in ('nmcoinci','nmcoempl','nmloconc') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
ws_des_eti :=c_etiqueta.cam_descam;
if (ws_key_cam='inc_cantid' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='inc_import' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='inc_fecmov' ) then
ws_etq_005:=ws_des_etq;
else
if (ws_key_cam='inc_keydep' ) then
ws_etq_006:=ws_des_etq;
else
if (ws_key_cam='inc_keypue' ) then
ws_etq_007:=ws_des_etq;
else
if (ws_key_cam='inc_keypro' ) then
ws_etq_008:=ws_des_etq;
else
if (ws_key_cam='inc_keyper' ) then
ws_etq_009:=ws_des_etq;
else
if (ws_key_cam='emp_nomemp' ) then
ws_etq_010:=ws_des_etq;
else
if (ws_key_cam='con_descon' ) then
ws_etq_011:=ws_des_etq;
else
if (ws_key_cam='inc_keyemp' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='inc_keycon' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='inc_numfol' ) then
ws_etq_012:=ws_des_etq;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end loop;
wn_dsp_001:=0;
wn_dsp_002:=0;
wn_dsp_003:=0;
wn_dsp_004:=0;
wn_dsp_005:=0;
wn_dsp_006:=0;
wn_dsp_007:=0;
wn_dsp_008:=0;
wn_dsp_009:=0;
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keypro', ws_key_men,wn_dsp_001);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keyper', ws_key_men,wn_dsp_002);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keyemp', ws_key_men,wn_dsp_003);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keycon', ws_key_men,wn_dsp_004);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_cantid', ws_key_men,wn_dsp_005);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_import', ws_key_men,wn_dsp_006);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_fecmov', ws_key_men,wn_dsp_007);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keydep', ws_key_men,wn_dsp_008);
call labprod.sp_glnewdsp ('nmcoinci', 'inc_keypue', ws_key_men,wn_dsp_009);
wn_ant_emp:=-0000;
ws_ant_con:='______';
wn_ant_pro:=-0000;
ws_ant_dep:=0;
wn_num_reg:=1;
wn_pct_act:=(wn_tot_reg/10.0);
for c_nmlstinc in ( select inc_keydep, inc_keyemp, inc_keycon, inc_keypro, inc_fecmov, inc_cantid, inc_import, inc_keypue, inc_keyper, inc_numfol
from labprod.nmcoinci
where inc_keyinc in (
select cry_dec001 from labprod.glwkcrys
where cry_nomrep = ws_nom_ran
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu
and nullif(cry_dec001::text, '') is not null )
order by  inc_keypro, inc_keyper, inc_keydep, inc_numfol, inc_keyemp ) loop
ws_key_dep :=c_nmlstinc.inc_keydep;
wn_key_emp :=c_nmlstinc.inc_keyemp;
ws_key_con :=c_nmlstinc.inc_keycon;
wn_key_pro :=c_nmlstinc.inc_keypro;
wd_fec_mov :=c_nmlstinc.inc_fecmov;
wn_can_tid :=c_nmlstinc.inc_cantid;
wn_imp_ort :=c_nmlstinc.inc_import;
ws_key_pue :=c_nmlstinc.inc_keypue;
ws_key_per :=c_nmlstinc.inc_keyper;
ws_num_fol :=c_nmlstinc.inc_numfol;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update labprod.glcoresu set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
wn_pct_act:=(wn_pct_act+1);
wn_con_reg:=(wn_con_reg+1);
end if;
if (nullif(ws_num_fol::text, '') is null ) then
ws_nom_usu:='USUARIO NO EXISTE ....';
else
if (ws_num_fol != ws_ant_fol ) then
ws_nom_usu:='Usuario no existe.';
for c_nomusu in ( select usu_nomusu from labprod.glcousua
where usu_keyusu = ws_num_fol ) loop
ws_nom_usu :=c_nomusu.usu_nomusu;/* dmap converted statement start */
ws_nom_usu:= rtrim(ltrim(ws_nom_usu)::text);/* dmap converted statement end */
end loop;
ws_ant_fol:=ws_num_fol;
end if;
end if;
if (nullif(ws_key_con::text, '') is null ) then
ws_des_con:='Concepto No Existe..';
else
if (ws_key_con != ws_ant_con ) then
ws_des_con:='Concepto No existe ..';
for c_descon in ( select con_descon from labprod.nmloconc
where con_keycon = ws_key_con ) loop
ws_des_con :=c_descon.con_descon;/* dmap converted statement start */
ws_des_con:= rtrim(ltrim(ws_des_con)::text);/* dmap converted statement end */
end loop;
ws_ant_con:=ws_key_con;
end if;
end if;
if (nullif(wn_key_emp::text, '') is null ) then
ws_ca1_aux:=null;
ws_nom_emp:='Empleado No Existe..';
else
if (wn_key_emp != wn_ant_emp ) then
ws_ca1_aux:=null;
ws_nom_emp:='Empleado No Existe..';
for c_nomemp in ( select emp_ca1aux, emp_nomemp from labprod.nmcoempl
where emp_keyemp = wn_key_emp ) loop
ws_ca1_aux :=c_nomemp.emp_ca1aux;
ws_nom_emp :=c_nomemp.emp_nomemp;/* dmap converted statement start */
ws_ca1_aux:= rtrim(ltrim(ws_ca1_aux)::text);/* dmap converted statement end *//* dmap converted statement start */
ws_nom_emp:= rtrim(ltrim(ws_nom_emp)::text);/* dmap converted statement end */
end loop;
wn_ant_emp:=wn_key_emp;
end if;
end if;
if (nullif(ws_key_dep::text, '') is null ) then
ws_des_dep:='Departamento No Existe.';
else
if (ws_key_dep != ws_ant_dep ) then
ws_des_dep:='Departamento no Existe.';
for c_desdep in ( select dep_desdep from labprod.nmcodeps
where dep_keydep = ws_key_dep ) loop
ws_des_dep :=c_desdep.dep_desdep;/* dmap converted statement start */
ws_des_dep:= rtrim(ltrim(ws_des_dep)::text);/* dmap converted statement end */
end loop;
ws_ant_dep:=ws_key_dep;
end if;
end if;
if (nullif(wn_key_pro::text, '') is null ) then
ws_des_pro:='Proceso No Existe.';
else
if (wn_key_pro != wn_ant_pro ) then
ws_des_pro:='Proceso No Existe.';
ws_key_cia:='..';
ws_des_cor:='CORPORATIVO NO REGISTRADO ...';
for c_despro in ( select pro_despro, pro_keycia from labprod.nmloproc
where pro_keypro = wn_key_pro ) loop
ws_des_pro :=c_despro.pro_despro;
ws_key_cia :=c_despro.pro_keycia;/* dmap converted statement start */
ws_key_cia:= rtrim(ltrim(ws_key_cia)::text);/* dmap converted statement end */
end loop;
for c_descia in ( select cia_descia from labprod.nmlocias
where cia_keycia = ws_key_cia ) loop
ws_des_cor :=oracle.substr(c_descia.cia_descia,60);/* dmap converted statement start */
ws_des_cor:= rtrim(ltrim(ws_des_cor)::text);/* dmap converted statement end */
end loop;
wn_ant_pro:=wn_key_pro;
end if;
end if;
if (nullif(ws_key_per::text, '') is null ) then
wd_fec_ini:=null;
wd_fec_fin:=null;
else
if (ws_key_per != ws_ant_per ) then
wd_fec_ini:=null;
wd_fec_fin:=null;
ws_ant_per:=ws_key_per;
begin select per_fecini, per_fecfin
into strict wd_fec_ini, wd_fec_fin from labprod.nmloperi
where per_keyper = ws_key_per
and per_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
end if;
end if;
if (wn_dsp_001=1 ) then
wn_key_pro:=null;
ws_des_pro:=null;
end if;
if (wn_dsp_002=1 ) then
ws_key_per:=null;
wd_fec_ini:=null;
wd_fec_fin:=null;
end if;
if (wn_dsp_003=1 ) then
wn_key_emp:=null;
ws_nom_emp:=null;
end if;
if (wn_dsp_004=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_005=1 ) then
wn_can_tid:=null;
end if;
if (wn_dsp_006=1 ) then
wn_imp_ort:=null;
end if;
if (wn_dsp_007=1 ) then
wd_fec_mov:=null;
end if;
if (wn_dsp_008=1 ) then
ws_key_dep:=null;
ws_des_dep:=null;
end if;
if (wn_dsp_009=1 ) then
ws_key_pue:=null;
end if;
insert into labprod.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec006,cry_chr012,cry_dec001,cry_dec002,cry_dat001,cry_chr013,cry_chr014,cry_dec007,cry_chr031,cry_chr003,cry_chr004,cry_chr008,cry_dat002,cry_dat003,cry_dat004,cry_chr026,cry_chr027,cry_chr028,cry_chr017,cry_chr018,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr005,cry_chr002,cry_chr015,cry_chr006,cry_chr029,cry_chr016)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_key_con,wn_can_tid,wn_imp_ort,wd_fec_mov,ws_key_dep,ws_key_pue,wn_key_pro,ws_key_per,ws_des_con,ws_nom_emp,ws_des_pro,wd_fec_ini,wd_fec_fin,wd_fec_act,ws_hor_act,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_des_dep,ws_des_lis,ws_num_fol,ws_nom_usu,ws_etq_012,ws_ca1_aux); /* commit; */
end loop;
update labprod.glcoresu set res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
