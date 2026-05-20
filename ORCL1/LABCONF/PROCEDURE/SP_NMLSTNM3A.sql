create or replace procedure labconf."sp_nmlstnm3a"  (ws_nom_rep varchar,ws_des_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,wn_key_pro numeric,wn_tip_nom numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_con varchar(3);
wn_can_mov decimal(16,2);
wn_imp_mov decimal(16,2);
ws_cod_imp varchar(2);
ws_key_loc varchar(16);
wn_key_emp numeric(10);
ws_nom_emp varchar(60);
ws_key_dep varchar(16);
ws_key_pue varchar(16);
ws_reg_rfc varchar(13);
wn_sal_dia decimal(12,6);
wn_sal_int decimal(12,6);
wd_fec_ing timestamp(0);
ws_tip_emp varchar(6);
ws_key_ims varchar(5);
ws_rfc_ims varchar(16);
ws_rfc_uno varchar(8);
ws_rfc_dos varchar(8);
ws_rfc_c01 varchar(8);
ws_rfc_c02 varchar(8);
ws_rfc_cia varchar(16);
ws_reg_ims varchar(12);
ws_reg_im1 varchar(6);
ws_reg_im2 varchar(6);
ws_con_his varchar(3);
ws_dep_his varchar(16);
ws_pue_his varchar(16);
ws_loc_his varchar(16);
ws_opc_003 varchar(16);
ws_opc_004 varchar(16);
ws_opc_005 varchar(16);
ws_opc_006 varchar(16);
ws_opc_007 varchar(16);
ws_des_nom varchar(40);
ws_des_pro varchar(20);
ws_des_con varchar(30);
ws_des_cor varchar(60);
ws_des_pue varchar(60);
ws_des_dep varchar(40);
ws_des_loc varchar(40);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_des_lis varchar(40);
ws_des_li1 varchar(50);
ws_des_aux varchar(10);
ws_key_cia varchar(5);
ws_des_tip varchar(40);
ws_key_tab varchar(4);
ws_key_cam varchar(20);
ws_des_etq varchar(8);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(8);
ws_etq_005 varchar(8);
ws_etq_006 varchar(8);
ws_etq_007 varchar(8);
ws_etq_008 varchar(8);
ws_etq_009 varchar(8);
ws_etq_010 varchar(8);
ws_etq_011 varchar(8);
ws_etq_012 varchar(8);
ws_etq_013 varchar(8);
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
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
wn_num_sec numeric(10);
i numeric(10);
j numeric(10);
k numeric(10);
wn_emp_ant numeric(10);
c_etiqueta record;
c_nmlstnom record;
begin
call labconf.sp_glfechor (ws_fec_act, ws_hor_act);
wn_tot_reg:=-1;
wd_fec_ini:=null;
wd_fec_fin:=null;
insert into labconf.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO';
ws_key_cia:=null;
begin select pro_keycia
into strict ws_key_cia from labconf.nmloproc
where pro_keypro=wn_key_pro;
exception
when no_data_found then
null;
end;
if (ws_key_cia!=' ' and nullif(ws_key_cia::text, '') is not null ) then
begin select oracle.substr(cia_descia,1,60), cia_rfccia
into strict ws_des_cor, ws_rfc_cia from labconf.nmlocias
where cia_keycia=ws_key_cia;
exception
when no_data_found then
null;
end;
ws_rfc_c01:= oracle.substr(ws_rfc_cia,1,8);
ws_rfc_c02:= oracle.substr(ws_rfc_cia,9,7);
end if;
ws_key_tab:= null;
begin select pam_folini
into strict ws_key_tab from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI01';
exception
when no_data_found then
null;
end;
ws_con_his:= null;
begin select pam_folini
into strict ws_con_his from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI02';
exception
when no_data_found then
null;
end;
ws_opc_003:= null;
begin select pam_folini
into strict ws_opc_003 from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI03';
exception
when no_data_found then
null;
end;
ws_opc_004:= null;
begin select pam_folini
into strict ws_opc_004 from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI04';
exception
when no_data_found then
null;
end;
ws_opc_005:= null;
begin select pam_folini
into strict ws_opc_005 from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI05';
exception
when no_data_found then
null;
end;
ws_opc_006:= null;
begin select pam_folini
into strict ws_opc_006 from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI06';
exception
when no_data_found then
null;
end;
ws_opc_007:= null;
begin select pam_folini
into strict ws_opc_007 from labconf.glcopams
where pam_keypar = (
select pam_folini from labconf.glcopams
where pam_keypar='00'
and pam_cvesec='repnom')
and pam_cvesec='OPCI07';
exception
when no_data_found then
null;
end;
ws_etq_001:='........';
ws_etq_002:='........';
ws_etq_003:='........';
ws_etq_004:='........';
ws_etq_005:='........';
ws_etq_006:='R.F.C.';
ws_etq_007:='NOMBRE';
ws_etq_008:='SAL. DIA';
ws_etq_009:='SAL. INT';
ws_etq_010:='........';
ws_etq_011:='........';
ws_etq_012:='........';
ws_etq_013:='Reg.IMSS';
for c_etiqueta in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab in ('nmlohism','nmcoempl','nmloimss') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if (ws_key_cam='his_keyemp' ) then
ws_etq_001:=ws_des_etq;
end if;
if (ws_key_cam='his_keydep' ) then
ws_etq_002:=ws_des_etq;
end if;
if (ws_key_cam='his_keypue' ) then
ws_etq_003:=ws_des_etq;
end if;
if (ws_key_cam='his_keynom' ) then
ws_etq_004:=ws_des_etq;
end if;
if (ws_key_cam='his_keyper' ) then
ws_etq_005:=ws_des_etq;
end if;
if (ws_key_cam='emp_regrfc' ) then
ws_etq_006:=ws_des_etq;
end if;
if (ws_key_cam='emp_nomemp' ) then
ws_etq_007:=ws_des_etq;
end if;
if (ws_key_cam='emp_sadia' ) then
ws_etq_008:=ws_des_etq;
end if;
if (ws_key_cam='emp_salint' ) then
ws_etq_009:=ws_des_etq;
end if;
if (ws_key_cam='his_keypro' ) then
ws_etq_010:=ws_des_etq;
end if;
if (ws_key_cam='emp_tipemp' ) then
ws_etq_011:=ws_des_etq;
end if;
if (ws_key_cam='his_ca2aux' ) then
ws_etq_012:=ws_des_etq;
end if;
if (ws_key_cam='ims_rfcims' ) then
ws_etq_013:=ws_des_etq;
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
call labconf.sp_glnewdsp ('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
call labconf.sp_glnewdsp ('nmlohism', 'his_keydep', ws_key_men,wn_dsp_002);
call labconf.sp_glnewdsp ('nmlohism', 'his_keypue', ws_key_men,wn_dsp_003);
call labconf.sp_glnewdsp ('nmlohism', 'his_keycon', ws_key_men,wn_dsp_004);
call labconf.sp_glnewdsp ('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
call labconf.sp_glnewdsp ('nmlohism', 'his_keynom', ws_key_men,wn_dsp_006);
call labconf.sp_glnewdsp ('nmlohism', 'his_cantid', ws_key_men,wn_dsp_007);
call labconf.sp_glnewdsp ('nmlohism', 'his_import', ws_key_men,wn_dsp_008);
call labconf.sp_glnewdsp ('nmlohism', 'emp_tipemp', ws_key_men,wn_dsp_009);
call labconf.sp_glnewdsp ('nmlohism', 'emp_keyloc', ws_key_men,wn_dsp_010);
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10);
wn_emp_ant:=-999999999;
ws_des_nom:='NOMINA NO EXISTE ..';
begin select nom_destip
into strict ws_des_nom from labconf.nmlonomi
where nom_keynom=wn_tip_nom;
exception
when no_data_found then
null;
end;
ws_des_nom:= oracle.substr(ws_des_nom,1,20);
ws_des_pro:='PROCESO NO EXISTE..';
begin select pro_despro
into strict ws_des_pro from labconf.nmloproc
where pro_keypro=wn_key_pro;
exception
when no_data_found then
null;
end;
ws_des_li1:='No existe nombre del Reporte';
begin select lis_deslis
into strict ws_des_li1 from labconf.glcolist
where lis_keylis=ws_des_rep;
exception
when no_data_found then
null;
end;
ws_des_lis:= oracle.substr(ws_des_li1,1,40);
ws_des_aux:= oracle.substr(ws_des_li1,41,9);
ws_key_dep:= 'HHHHHHHHH';
for c_nmlstnom in ( select his_keyemp, his_keycon,  sum(his_cantid ) alias3,  sum(his_import ) alias4, his_codimp
from labconf.nmlohism
where his_keypro=wn_key_pro
and his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keyper::text, '') is not null )
and ((his_codimp in ('01','02')) or (his_keycon in (ws_opc_003,ws_opc_004,ws_opc_005,ws_opc_006,ws_opc_007)))
group by his_keyemp,his_keycon,his_cantid,his_import,his_codimp
order by  his_keyemp,his_codimp,his_keycon ) loop
wn_key_emp :=c_nmlstnom.his_keyemp;
ws_key_con :=c_nmlstnom.his_keycon;
wn_can_mov :=c_nmlstnom.alias3;
wn_imp_mov :=c_nmlstnom.alias4;
ws_cod_imp :=c_nmlstnom.his_codimp;
wn_num_reg:=(wn_num_reg+1);
if (nullif(wn_key_emp::text, '') is null ) then
ws_nom_emp:='EMPLEADO NO EXISTE ..';
ws_reg_rfc:='NO EXISTE ..';
wn_sal_dia:=null;
wn_sal_int:=null;
ws_key_dep:='NO EXISTE';
ws_key_pue:='NO EXISTE';
else
if (wn_emp_ant!=wn_key_emp ) then
i:=0;
j:=0;
k:=1;
begin select emp_nomemp, emp_regrfc, emp_saldia, emp_salint, emp_keydep, emp_keypue, emp_tipemp, emp_keyims, emp_keyloc, emp_regims
into strict ws_nom_emp, ws_reg_rfc, wn_sal_dia, wn_sal_int, ws_key_dep, ws_key_pue, ws_tip_emp, ws_key_ims, ws_key_loc, ws_reg_ims from labconf.nmcoempl
where emp_keyemp=wn_key_emp;
exception
when no_data_found then
null;
end;
ws_dep_his:=null;
ws_pue_his:=null;
ws_loc_his:=null;
ws_reg_im1:= oracle.substr(ws_reg_ims,1,6);
ws_reg_im2:= oracle.substr(ws_reg_ims,7,5);
if (nullif(ws_con_his::text, '') is not null  ) then
begin select his_keydep, his_keypue, his_ca2aux
into strict ws_dep_his, ws_pue_his, ws_loc_his from labconf.nmlohism
where his_keyemp=wn_key_emp
and his_keypro=wn_key_pro
and his_keycon=ws_con_his;
exception
when no_data_found then
null;
end;
if (nullif(ws_dep_his::text, '') is not null  and nullif(ws_dep_his::text, '') is not null) then
ws_key_dep:=ws_dep_his;
ws_key_pue:=ws_pue_his;
ws_key_loc:=ws_loc_his;
end if;
end if;
ws_des_dep:='DEPARTAMENTO NO EXISTE';
begin select dep_desdep
into strict ws_des_dep from labconf.nmcodeps
where dep_keydep=ws_key_dep;
exception
when no_data_found then
null;
end;
ws_des_pue:='PUESTO NO EXISTE';
begin select pue_despue
into strict ws_des_pue from labconf.nmcopues
where pue_keypue=ws_key_pue;
exception
when no_data_found then
null;
end;
ws_des_loc:='LOCALIDAD NO EXISTE';
begin select loc_desloc
into strict ws_des_loc from labconf.nmlolocp
where loc_keyloc=ws_key_loc;
exception
when no_data_found then
null;
end;
ws_des_loc:= oracle.substr(ws_des_loc,1,16);
wn_emp_ant:=wn_key_emp;
ws_des_tip:='NO EXISTE';
begin select pam_nompar
into strict ws_des_tip from labconf.glcopams
where pam_keypar=ws_key_tab
and pam_cvesec=ws_tip_emp;
exception
when no_data_found then
null;
end;
ws_rfc_ims:= null;
begin select ims_rfcims
into strict ws_rfc_ims from labconf.nmloimss
where ims_keyims=ws_key_ims;
exception
when no_data_found then
null;
end;
ws_rfc_uno:= oracle.substr(ws_rfc_ims,1,8);
ws_rfc_dos:= oracle.substr(ws_rfc_ims,9,7);
if (wn_dsp_001=1 ) then
wn_key_emp:=null;
ws_nom_emp:=null;
ws_reg_rfc:=null;
wn_sal_dia:=null;
wn_sal_int:=null;
end if;
if (wn_dsp_002=1 ) then
ws_key_dep:=null;
ws_des_dep:=null;
end if;
if (wn_dsp_003=1 ) then
ws_key_pue:=null;
ws_des_pue:=null;
end if;
if (wn_dsp_009=1 ) then
ws_tip_emp:=null;
ws_des_tip:=null;
end if;
if (wn_dsp_010=1 ) then
ws_key_loc:=null;
ws_des_loc:=null;
end if;
end if;
end if;
ws_des_con:='CONCEPTO NO EXISTE..';
begin select con_descor
into strict ws_des_con from labconf.nmloconc
where con_keycon=ws_key_con;
exception
when no_data_found then
null;
end;
if (ws_cod_imp='01' ) then
if (wn_dsp_004=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_005=1 ) then
wd_fec_ini:=null;
wd_fec_fin:=null;
end if;
if (wn_dsp_006=1 ) then
ws_des_nom:=null;
end if;
if (wn_dsp_007=1 ) then
wn_can_mov:=null;
end if;
if (wn_dsp_008=1 ) then
wn_imp_mov:=null;
end if;
i:=(i+1);
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,i,ws_des_cor,wn_tip_nom,ws_des_nom,null,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,null,null,null,null,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA',wn_imp_mov,0); /* commit; */
end if;
if (ws_cod_imp='02' ) then
if (wn_dsp_004=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_005=1 ) then
wd_fec_ini:=null;
wd_fec_fin:=null;
end if;
if (wn_dsp_006=1 ) then
ws_des_nom:=null;
end if;
if (wn_dsp_007=1 ) then
wn_can_mov:=null;
end if;
if (wn_dsp_008=1 ) then
wn_imp_mov:=null;
end if;
j:=(j+1);
if (j>i ) then
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,j,ws_des_cor,wn_tip_nom,ws_des_nom,null,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,null,null,null,null,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'NOMINA',0,wn_imp_mov); /* commit; */
else
update labconf.glwkcrys set cry_chr029=ws_key_con,cry_chr007=ws_des_con,cry_dec003=wn_can_mov,cry_dec004=wn_imp_mov,cry_dec016=wn_imp_mov
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu
and cry_numsec=j
and cry_dec007=wn_key_emp
and cry_chr037='NOMINA'; /* commit; */
end if;
end if;
if (ws_cod_imp='03' ) then
if (wn_dsp_004=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_005=1 ) then
wd_fec_ini:=null;
wd_fec_fin:=null;
end if;
if (wn_dsp_006=1 ) then
ws_des_nom:=null;
end if;
if (wn_dsp_007=1 ) then
wn_can_mov:=null;
end if;
if (wn_dsp_008=1 ) then
wn_imp_mov:=null;
end if;
if (k=1 ) then
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,-1,ws_des_cor,wn_tip_nom,ws_des_nom,null,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,null,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,null,null,null,null,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0); /* commit; */
end if;
if (k=2 ) then
update labconf.glwkcrys set cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003 = null,cry_chr007=ws_des_con
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu
and cry_numsec=-1
and cry_dec007=wn_key_emp
and cry_chr037='AUXILIAR'; /* commit; */
end if;
if (k=3 ) then
update labconf.glwkcrys set cry_chr011=ws_key_con,cry_dec015=wn_imp_mov,cry_chr003=ws_des_con
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu
and cry_numsec=-1
and cry_dec007=wn_key_emp
and cry_chr037='AUXILIAR'; /* commit; */
end if;
if (k=4 ) then
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001,cry_dec006,cry_chr009,cry_chr017,cry_dat001,cry_dat002,cry_dec007,cry_chr002,cry_chr012,cry_chr013,cry_chr004,cry_chr014,cry_chr005,cry_dec011,cry_dec012,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_dat003,cry_chr016,cry_chr029,cry_chr007,cry_dec003,cry_dec004,cry_chr015,cry_chr030,cry_dec008,cry_chr008,cry_chr033,cry_chr031,cry_chr010,cry_chr032,cry_chr034,cry_chr035,cry_chr036,cry_chr039,cry_chr044,cry_chr045,cry_chr042,cry_chr043,cry_chr037,cry_dec014,cry_dec016)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,0,ws_des_cor,wn_tip_nom,ws_des_nom,null,wd_fec_ini,wd_fec_fin,wn_key_emp,ws_nom_emp,ws_reg_rfc,ws_key_dep,ws_des_dep,ws_key_pue,ws_des_pue,wn_sal_dia,wn_sal_int,ws_key_con,ws_des_con,null,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_hor_act,ws_fec_act,ws_des_loc,null,null,null,null,ws_key_loc,ws_etq_010,wn_key_pro,ws_des_pro,ws_etq_012,ws_tip_emp,ws_des_tip,ws_etq_011,ws_etq_013,ws_rfc_uno,ws_rfc_dos,ws_key_ims,ws_rfc_c01,ws_rfc_c02,ws_reg_im1,ws_reg_im2,'AUXILIAR',0,0); /* commit; */
end if;
if (k=5 ) then
update labconf.glwkcrys set cry_chr029=ws_key_con,cry_dec004=wn_imp_mov,cry_dec003 = null,cry_chr007=ws_des_con
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu
and cry_numsec=0
and cry_dec007=wn_key_emp
and cry_chr037='AUXILIAR'; /* commit; */
end if;
k:=(k+1);
end if;
end loop;
call labconf.sp_glfechor (ws_fec_act, ws_hor_act);
update labconf.glcoresu set res_numreg=wn_num_reg,res_fecfin=ws_fec_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro=ws_nom_rep
and res_idepcc=ws_ide_pcc
and res_keyusu=wn_key_usu
and res_fecini=ws_fec_act
and res_horreg=ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
