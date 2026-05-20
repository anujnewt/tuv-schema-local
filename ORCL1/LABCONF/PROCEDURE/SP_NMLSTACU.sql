create or replace procedure labconf."sp_nmlstacu"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar, wn_ani_oac numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp numeric(10);
ws_key_con varchar(3);
wn_uni_uno decimal(14,2);
wn_uni_dos decimal(14,2);
wn_uni_tre decimal(14,2);
wn_uni_cua decimal(14,2);
wn_uni_cin decimal(14,2);
wn_uni_sei decimal(14,2);
wn_uni_sie decimal(14,2);
wn_uni_och decimal(14,2);
wn_uni_nue decimal(14,2);
wn_uni_die decimal(14,2);
wn_uni_onc decimal(14,2);
wn_uni_doc decimal(14,2);
wn_uni_013 decimal(14,2);
wn_uni_cat decimal(14,2);
wn_uni_qui decimal(14,2);
wn_imp_uno decimal(14,2);
wn_imp_dos decimal(14,2);
wn_imp_tre decimal(14,2);
wn_imp_cua decimal(14,2);
wn_imp_cin decimal(14,2);
wn_imp_sei decimal(14,2);
wn_imp_sie decimal(14,2);
wn_imp_och decimal(14,2);
wn_imp_nue decimal(14,2);
wn_imp_die decimal(14,2);
wn_imp_onc decimal(14,2);
wn_imp_doc decimal(14,2);
wn_imp_013 decimal(14,2);
wn_imp_cat decimal(14,2);
wn_imp_qui decimal(14,2);
ws_des_lis varchar(50);
ws_des_cor varchar(60);
ws_des_con varchar(40);
ws_nom_emp varchar(60);
wn_emp_ant numeric(10);
ws_con_ant varchar(3);
ws_key_cam varchar(20);
ws_des_etq varchar(8);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(8);
ws_etq_005 varchar(8);
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
wn_dsp_010 numeric(5);
wn_dsp_011 numeric(5);
wn_dsp_012 numeric(5);
wn_dsp_013 numeric(5);
wn_dsp_014 numeric(5);
wn_dsp_015 numeric(5);
wn_dsp_016 numeric(5);
wn_dsp_017 numeric(5);
wn_dsp_018 numeric(5);
wn_dsp_019 numeric(5);
wn_dsp_020 numeric(5);
wn_dsp_021 numeric(5);
wn_dsp_022 numeric(5);
wn_dsp_023 numeric(5);
wn_dsp_024 numeric(5);
wn_dsp_025 numeric(5);
wn_dsp_026 numeric(5);
wn_dsp_027 numeric(5);
wn_dsp_028 numeric(5);
wn_dsp_029 numeric(5);
wn_dsp_030 numeric(5);
wn_dsp_031 numeric(5);
wn_dsp_032 numeric(5);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
wd_fec_act timestamp(0);
wn_num_tem numeric(10);
wn_key_pro numeric(10);
ws_des_pro varchar(20);
wn_pro_ant numeric(10);
c_etiqueta record;
c_nmlstacu record;
begin
begin select  count(* ) alias1
into strict wn_tot_reg from labconf.nmloacum
where acu_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and acu_keyemp in (
select ran_keyemp from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_keycon in (
select ran_keycon from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and acu_anioac = wn_ani_oac;
exception
when no_data_found then
null;
end;
call labconf.sp_glfechor (wd_fec_act, ws_hor_act);
insert into labconf.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO ..';
begin select cor_razsoc
into strict ws_des_cor from labconf.glcocorp;
exception
when no_data_found then
null;
end;
ws_des_lis:='No existe Nombre del Reporte ...';
begin select lis_deslis
into strict ws_des_lis from labconf.glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
null;
end;
ws_etq_001:='Empleado';
ws_etq_003:='Nombre';
ws_etq_002:='Concepto';
ws_etq_005:='Proceso';
for c_etiqueta in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab in ('nmloacum','nmcoempl','nmloconc')
and cam_keycam in ('acu_keyemp','acu_keycon','acu_keypro','emp_nomemp','con_descon') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if (ws_key_cam='acu_keyemp' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='acu_keycon' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='emp_nomemp' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='con_descon' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='acu_keypro' ) then
ws_etq_005:=ws_des_etq;
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
wn_dsp_010:=0;
wn_dsp_011:=0;
wn_dsp_012:=0;
wn_dsp_013:=0;
wn_dsp_014:=0;
wn_dsp_015:=0;
wn_dsp_016:=0;
wn_dsp_017:=0;
wn_dsp_018:=0;
wn_dsp_019:=0;
wn_dsp_020:=0;
wn_dsp_021:=0;
wn_dsp_022:=0;
wn_dsp_023:=0;
wn_dsp_024:=0;
wn_dsp_025:=0;
wn_dsp_026:=0;
wn_dsp_027:=0;
wn_dsp_028:=0;
wn_dsp_029:=0;
wn_dsp_030:=0;
wn_dsp_031:=0;
wn_dsp_032:=0;
call labconf.sp_glnewdsp ('nmloacum',  'acu_keyemp' , ws_key_men,wn_dsp_001);
call labconf.sp_glnewdsp ('nmloacum',  'acu_keycon' , ws_key_men,wn_dsp_002);
call labconf.sp_glnewdsp ('nmloacum',  'acu_uniuno' , ws_key_men,wn_dsp_003);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unidos' , ws_key_men,wn_dsp_004);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unitre' , ws_key_men,wn_dsp_005);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unicua' , ws_key_men,wn_dsp_006);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unicin' , ws_key_men,wn_dsp_007);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unisei' , ws_key_men,wn_dsp_008);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unisie' , ws_key_men,wn_dsp_009);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unioch' , ws_key_men,wn_dsp_010);
call labconf.sp_glnewdsp ('nmloacum',  'acu_uninue' , ws_key_men,wn_dsp_011);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unidie' , ws_key_men,wn_dsp_012);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unionc' , ws_key_men,wn_dsp_013);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unidoc' , ws_key_men,wn_dsp_014);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unitre' , ws_key_men,wn_dsp_015);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unicua' , ws_key_men,wn_dsp_016);
call labconf.sp_glnewdsp ('nmloacum',  'acu_unicat' , ws_key_men,wn_dsp_017);
call labconf.sp_glnewdsp ('nmloacum',  'acu_uniqui' , ws_key_men,wn_dsp_018);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impuno' , ws_key_men,wn_dsp_019);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impdos' , ws_key_men,wn_dsp_020);
call labconf.sp_glnewdsp ('nmloacum',  'acu_imptre' , ws_key_men,wn_dsp_021);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impcua' , ws_key_men,wn_dsp_022);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impcin' , ws_key_men,wn_dsp_023);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impsei' , ws_key_men,wn_dsp_024);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impoch' , ws_key_men,wn_dsp_025);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impnue' , ws_key_men,wn_dsp_026);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impdie' , ws_key_men,wn_dsp_027);
call labconf.sp_glnewdsp ('nmloacum',  'acu_imponc' , ws_key_men,wn_dsp_028);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impdoc' , ws_key_men,wn_dsp_029);
call labconf.sp_glnewdsp ('nmloacum',  'acu_imptre' , ws_key_men,wn_dsp_030);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impcat' , ws_key_men,wn_dsp_031);
call labconf.sp_glnewdsp ('nmloacum',  'acu_impqui' , ws_key_men,wn_dsp_032);
ws_con_ant:='______';
wn_emp_ant:=-999999999;
wn_pro_ant:=-999999999;
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10.0);
for c_nmlstacu in ( select acu_keyemp, acu_keycon, acu_uniuno, acu_unidos, acu_unitre, acu_unicua, acu_unicin, acu_unisei, acu_unisie, acu_unioch, acu_uninue, acu_unidie, acu_unionc, acu_unidoc, acu_unitrc, acu_unicat, acu_uniqui, acu_impuno, acu_impdos, acu_imptre, acu_impcua, acu_impcin, acu_impsei, acu_impsie, acu_impoch, acu_impnue, acu_impdie, acu_imponc, acu_impdoc, acu_imptrc, acu_impcat, acu_impqui, acu_keypro
from labconf.nmloacum, labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and acu_keypro = ran_keypro
and acu_keyemp = ran_keyemp
and acu_keycon = ran_keycon
and acu_anioac = wn_ani_oac
and nullif(ran_keypro::text, '') is not null
and nullif(ran_keyemp::text, '') is not null
and nullif(ran_keycon::text, '') is not null
and ran_keyper = wn_ani_oac
order by  acu_keypro,acu_keyemp,acu_keycon ) loop
wn_key_emp :=c_nmlstacu.acu_keyemp;
ws_key_con :=c_nmlstacu.acu_keycon;
wn_uni_uno :=c_nmlstacu.acu_uniuno;
wn_uni_dos :=c_nmlstacu.acu_unidos;
wn_uni_tre :=c_nmlstacu.acu_unitre;
wn_uni_cua :=c_nmlstacu.acu_unicua;
wn_uni_cin :=c_nmlstacu.acu_unicin;
wn_uni_sei :=c_nmlstacu.acu_unisei;
wn_uni_sie :=c_nmlstacu.acu_unisie;
wn_uni_och :=c_nmlstacu.acu_unioch;
wn_uni_nue :=c_nmlstacu.acu_uninue;
wn_uni_die :=c_nmlstacu.acu_unidie;
wn_uni_onc :=c_nmlstacu.acu_unionc;
wn_uni_doc :=c_nmlstacu.acu_unidoc;
wn_uni_013 :=c_nmlstacu.acu_unitrc;
wn_uni_cat :=c_nmlstacu.acu_unicat;
wn_uni_qui :=c_nmlstacu.acu_uniqui;
wn_imp_uno :=c_nmlstacu.acu_impuno;
wn_imp_dos :=c_nmlstacu.acu_impdos;
wn_imp_tre :=c_nmlstacu.acu_imptre;
wn_imp_cua :=c_nmlstacu.acu_impcua;
wn_imp_cin :=c_nmlstacu.acu_impcin;
wn_imp_sei :=c_nmlstacu.acu_impsei;
wn_imp_sie :=c_nmlstacu.acu_impsie;
wn_imp_och :=c_nmlstacu.acu_impoch;
wn_imp_nue :=c_nmlstacu.acu_impnue;
wn_imp_die :=c_nmlstacu.acu_impdie;
wn_imp_onc :=c_nmlstacu.acu_imponc;
wn_imp_doc :=c_nmlstacu.acu_impdoc;
wn_imp_013 :=c_nmlstacu.acu_imptrc;
wn_imp_cat :=c_nmlstacu.acu_impcat;
wn_imp_qui :=c_nmlstacu.acu_impqui;
wn_key_pro :=c_nmlstacu.acu_keypro;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update labconf.glcoresu set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
wn_pct_act:=(wn_pct_act+1);
end if;
if (nullif(wn_key_pro::text, '') is null ) then
ws_des_pro:='PROCESO NO EXISTE';
else
if (wn_key_pro != wn_pro_ant ) then
begin select pro_despro
into strict ws_des_pro from labconf.nmloproc
where pro_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
begin select cia_descia
into strict ws_des_cor from labconf.nmloproc, labconf.nmlocias
where pro_keypro = wn_key_pro
and pro_keycia = cia_keycia;
exception
when no_data_found then
null;
end;
wn_pro_ant:=wn_key_pro;
end if;
end if;
if (nullif(wn_key_emp::text, '') is null ) then
ws_nom_emp:='EMPLEADO NO EXISTE';
else
if (wn_key_emp != wn_emp_ant ) then
begin select emp_nomemp
into strict ws_nom_emp from labconf.nmcoempl
where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
wn_emp_ant:=wn_key_emp;
end if;
end if;
if (nullif(ws_key_con::text, '') is null ) then
ws_des_con:='CONCEPTO NO EXISTE';
else
if (ws_key_con != ws_con_ant ) then
begin select con_descon
into strict ws_des_con from labconf.nmloconc
where con_keycon = ws_key_con;
exception
when no_data_found then
null;
end;
ws_con_ant:=ws_key_con;
end if;
end if;
if (wn_dsp_001=1 ) then
wn_key_emp:=null;
ws_nom_emp:=null;
end if;
if (wn_dsp_002=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_003=1 ) then
wn_uni_uno:=null;
end if;
if (wn_dsp_004=1 ) then
wn_uni_dos:=null;
end if;
if (wn_dsp_005=1 ) then
wn_uni_tre:=null;
end if;
if (wn_dsp_006=1 ) then
wn_uni_cua:=null;
end if;
if (wn_dsp_007=1 ) then
wn_uni_cin:=null;
end if;
if (wn_dsp_008=1 ) then
wn_uni_sei:=null;
end if;
if (wn_dsp_009=1 ) then
wn_uni_sie:=null;
end if;
if (wn_dsp_010=1 ) then
wn_uni_och:=null;
end if;
if (wn_dsp_011=1 ) then
wn_uni_nue:=null;
end if;
if (wn_dsp_012=1 ) then
wn_uni_die:=null;
end if;
if (wn_dsp_013=1 ) then
wn_uni_onc:=null;
end if;
if (wn_dsp_014=1 ) then
wn_uni_doc:=null;
end if;
if (wn_dsp_015=1 ) then
wn_uni_013:=null;
end if;
if (wn_dsp_016=1 ) then
wn_uni_cat:=null;
end if;
if (wn_dsp_017=1 ) then
wn_uni_qui:=null;
end if;
if (wn_dsp_018=1 ) then
wn_imp_uno:=null;
end if;
if (wn_dsp_019=1 ) then
wn_imp_dos:=null;
end if;
if (wn_dsp_020=1 ) then
wn_imp_tre:=null;
end if;
if (wn_dsp_021=1 ) then
wn_imp_cua:=null;
end if;
if (wn_dsp_022=1 ) then
wn_imp_cin:=null;
end if;
if (wn_dsp_023=1 ) then
wn_imp_sei:=null;
end if;
if (wn_dsp_024=1 ) then
wn_imp_sie:=null;
end if;
if (wn_dsp_025=1 ) then
wn_imp_och:=null;
end if;
if (wn_dsp_026=1 ) then
wn_imp_nue:=null;
end if;
if (wn_dsp_027=1 ) then
wn_imp_die:=null;
end if;
if (wn_dsp_028=1 ) then
wn_imp_onc:=null;
end if;
if (wn_dsp_029=1 ) then
wn_imp_doc:=null;
end if;
if (wn_dsp_030=1 ) then
wn_imp_013:=null;
end if;
if (wn_dsp_031=1 ) then
wn_imp_cat:=null;
end if;
if (wn_dsp_032=1 ) then
wn_imp_qui:=null;
end if;
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec013,cry_chr012,cry_chr003,cry_chr002,cry_dec001,cry_dec002,cry_dec003,cry_dec004,cry_dec005,cry_dec011,cry_dec012,cry_chr004,cry_dec014,cry_dec015,cry_chr005,cry_chr006,cry_chr007,cry_dec025,cry_chr009,cry_chr010,cry_chr011,cry_dec024,cry_chr013,cry_chr014,cry_chr015,cry_chr016,cry_dec016,cry_dec017,cry_dec018,cry_dec019,cry_dec020,cry_dec021,cry_dec022,cry_dec023,cry_chr017,cry_chr018,cry_chr019,cry_chr020,cry_chr021,cry_chr036,cry_dat001,cry_dec006,cry_chr008,cry_dec007)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_key_con,ws_des_con,ws_nom_emp,wn_uni_uno,wn_uni_dos,wn_uni_tre,wn_uni_cua,wn_uni_cin,wn_uni_sei,wn_uni_sie,wn_uni_och,wn_uni_nue,wn_uni_die,wn_uni_onc,wn_uni_doc,wn_uni_013,wn_uni_cat,wn_uni_qui,wn_imp_uno,wn_imp_dos,wn_imp_tre,wn_imp_cua,wn_imp_cin,wn_imp_sei,wn_imp_sie,wn_imp_och,wn_imp_nue,wn_imp_die,wn_imp_onc,wn_imp_doc,wn_imp_013,wn_imp_cat,wn_imp_qui,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,wd_fec_act,wn_key_pro,ws_des_pro,wn_ani_oac); /* commit; */
end loop;
call labconf.sp_glfechor (wd_fec_act, ws_hor_act);
update labconf.glcoresu set res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
