create or replace procedure labconf."sp_nmreppr2"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_sta_tu1 varchar,ws_sta_tu2 varchar,ws_sta_tu3 varchar,ws_sta_tu4 varchar,wn_key_pro numeric,ws_des_pro varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_num_tem numeric(10);
ws_key_con varchar(3);
ws_des_con varchar(30);
wn_key_emp numeric(10);
ws_nom_emp varchar(60);
ws_fec_reg timestamp(0);
wn_uni_pre decimal(12,2);
wn_imp_pre decimal(12,2);
wn_uni_sal decimal(12,2);
wn_imp_sal decimal(12,2);
wn_pla_zop numeric(10);
wn_por_int decimal(6,4);
wn_num_pag numeric(10);
ws_per_ini varchar(7);
ws_ref_ere varchar(20);
ws_des_cor varchar(60);
ws_des_lis varchar(50);
ws_sta_tus varchar(1);
ws_key_cia varchar(5);
wn_uni_des decimal(12,2);
wn_imp_des decimal(12,2);
wn_uni_amo decimal(12,2);
wn_imp_amo decimal(12,2);
wn_gas_tos decimal(12,2);
wn_cve_aut numeric(10);
wd_fe1_aux timestamp(0);
wd_fe2_aux timestamp(0);
ws_fe2_aux varchar(15);
wd_fec_hab timestamp(0);
wd_fec_aut timestamp(0);
ws_ca1_aux varchar(10);
ws_ca2_aux varchar(10);
ws_ca3_aux varchar(10);
ws_ca4_aux varchar(10);
wd_ult_act timestamp(0);
ws_ult_act varchar(15);
wd_fec_ini timestamp(0);
ws_fec_ini varchar(15);
ws_ctr_eve varchar(16);
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
ws_etq_014 varchar(8);
ws_etq_015 varchar(8);
ws_etq_016 varchar(8);
ws_etq_017 varchar(8);
ws_etq_018 varchar(8);
ws_etq_019 varchar(8);
ws_etq_020 varchar(8);
ws_etq_021 varchar(8);
ws_etq_022 varchar(8);
ws_etq_023 varchar(8);
ws_etq_024 varchar(8);
ws_etq_025 varchar(8);
ws_etq_026 varchar(8);
ws_etq_027 varchar(8);
wn_dsp_001 numeric(5);
wn_dsp_003 numeric(5);
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
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
wd_fec_act timestamp(0);
wn_pro_ant numeric(10);
wn_nom_ant numeric(10);
c_etiqueta record;
c_nmlstpre record;
begin
begin select  count(* ) alias1
into strict wn_tot_reg from labconf.nmlopres
where pre_keypro = wn_key_pro
and pre_keyemp in (
select ran_keyemp from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and ((pre_status = ws_sta_tu1) or (pre_status = ws_sta_tu2) or (pre_status = ws_sta_tu3) or (pre_status = ws_sta_tu4));
exception
when no_data_found then
null;
end;
call sp_glfechor (wd_fec_act, ws_hor_act);
insert into glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_key_cia:='*';
begin select pro_keycia
into strict ws_key_cia from labconf.nmloproc
where pro_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
ws_des_cor:='EMPRESA NO EXISTE ..';
begin select cia_descia
into strict ws_des_cor from labconf.nmlocias
where cia_keycia = ws_key_cia;
exception
when no_data_found then
null;
end;
ws_des_lis:='No existe nombre del Reporte';
begin select lis_deslis
into strict ws_des_lis from labconf.glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
null;
end;
ws_etq_001:='........';
ws_etq_002:='........';
ws_etq_003:='........';
ws_etq_004:='........';
ws_etq_005:='........';
ws_etq_006:='........';
ws_etq_007:='........';
ws_etq_008:='........';
ws_etq_009:='........';
ws_etq_010:='........';
ws_etq_011:='........';
ws_etq_012:='........';
ws_etq_013:='........';
ws_etq_014:='........';
ws_etq_015:='........';
ws_etq_016:='........';
ws_etq_017:='........';
ws_etq_018:='........';
ws_etq_019:='........';
ws_etq_020:='........';
ws_etq_021:='........';
ws_etq_022:='........';
ws_etq_023:='........';
ws_etq_024:='........';
ws_etq_025:='........';
ws_etq_026:='........';
for c_etiqueta in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab in ('nmlopres','nmloconc','nmcoempl') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if (ws_key_cam='pre_keycon' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='con_descon' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='pre_keyemp' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='emp_nomemp' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='pre_fecreg' ) then
ws_etq_005:=ws_des_etq;
else
if (ws_key_cam='pre_unipre' ) then
ws_etq_006:=ws_des_etq;
else
if (ws_key_cam='pre_imppre' ) then
ws_etq_007:=ws_des_etq;
else
if (ws_key_cam='pre_unisal' ) then
ws_etq_008:=ws_des_etq;
else
if (ws_key_cam='pre_impsal' ) then
ws_etq_009:=ws_des_etq;
else
if (ws_key_cam='pre_plazop' ) then
ws_etq_010:=ws_des_etq;
else
if (ws_key_cam='pre_porint' ) then
ws_etq_011:=ws_des_etq;
else
if (ws_key_cam='pre_numpag' ) then
ws_etq_012:=ws_des_etq;
else
if (ws_key_cam='pre_perini' ) then
ws_etq_013:=ws_des_etq;
else
if (ws_key_cam='pre_status' ) then
ws_etq_014:=ws_des_etq;
else
if (ws_key_cam='pre_refere' ) then
ws_etq_015:=ws_des_etq;
else
if (ws_key_cam='pre_unides' ) then
ws_etq_016:=ws_des_etq;
else
if (ws_key_cam='pre_impdes' ) then
ws_etq_017:=ws_des_etq;
else
if (ws_key_cam='pre_uniamo' ) then
ws_etq_018:=ws_des_etq;
else
if (ws_key_cam='pre_impamo' ) then
ws_etq_019:=ws_des_etq;
else
if (ws_key_cam='pre_gastos' ) then
ws_etq_020:=ws_des_etq;
else
if (ws_key_cam='pre_fecini' ) then
ws_etq_021:=ws_des_etq;
else
if (ws_key_cam='pre_fecaut' ) then
ws_etq_022:=ws_des_etq;
else
if (ws_key_cam='pre_cveacut' ) then
ws_etq_023:=ws_des_etq;
else
if (ws_key_cam='pre_fechab' ) then
ws_etq_024:=ws_des_etq;
else
if (ws_key_cam='pre_fe1aux' ) then
ws_etq_025:=ws_des_etq;
else
if (ws_key_cam='pre_fe2aux' ) then
ws_etq_026:=ws_des_etq;
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
end if;
end if;
end loop;
call labconf.sp_glnewdsp ('nmlopres', 'pre_keycon', ws_key_men,wn_dsp_001);
call labconf.sp_glnewdsp ('nmlopres', 'pre_keyemp', ws_key_men,wn_dsp_003);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fecreg', ws_key_men,wn_dsp_005);
call labconf.sp_glnewdsp ('nmlopres', 'pre_unipre', ws_key_men,wn_dsp_006);
call labconf.sp_glnewdsp ('nmlopres', 'pre_imppre', ws_key_men,wn_dsp_007);
call labconf.sp_glnewdsp ('nmlopres', 'pre_unisal', ws_key_men,wn_dsp_008);
call labconf.sp_glnewdsp ('nmlopres', 'per_impsal', ws_key_men,wn_dsp_009);
call labconf.sp_glnewdsp ('nmlopres', 'pre_plazop', ws_key_men,wn_dsp_010);
call labconf.sp_glnewdsp ('nmlopres', 'pre_porint', ws_key_men,wn_dsp_011);
call labconf.sp_glnewdsp ('nmlopres', 'pre_numpag', ws_key_men,wn_dsp_012);
call labconf.sp_glnewdsp ('nmlopres', 'pre_perini', ws_key_men,wn_dsp_013);
call labconf.sp_glnewdsp ('nmlopres', 'pre_status', ws_key_men,wn_dsp_014);
call labconf.sp_glnewdsp ('nmlopres', 'pre_refere', ws_key_men,wn_dsp_015);
call labconf.sp_glnewdsp ('nmlopres', 'pre_unides', ws_key_men,wn_dsp_016);
call labconf.sp_glnewdsp ('nmlopres', 'pre_impdes', ws_key_men,wn_dsp_017);
call labconf.sp_glnewdsp ('nmlopres', 'pre_uniamo', ws_key_men,wn_dsp_018);
call labconf.sp_glnewdsp ('nmlopres', 'pre_impamo', ws_key_men,wn_dsp_019);
call labconf.sp_glnewdsp ('nmlopres', 'pre_gastos', ws_key_men,wn_dsp_020);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fecini', ws_key_men,wn_dsp_021);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fecaut', ws_key_men,wn_dsp_022);
call labconf.sp_glnewdsp ('nmlopres', 'pre_cveaut', ws_key_men,wn_dsp_023);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fechab', ws_key_men,wn_dsp_024);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fe1aux', ws_key_men,wn_dsp_025);
call labconf.sp_glnewdsp ('nmlopres', 'pre_fe2aux', ws_key_men,wn_dsp_026);
wn_pro_ant:=-32760;
wn_nom_ant:=-32760;
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10.0);
for c_nmlstpre in ( select pre_keycon, pre_keyemp, pre_fecreg, pre_unipre, pre_imppre, pre_unisal, pre_impsal, pre_plazop, pre_porint, pre_numpag, pre_perini, pre_status, pre_refere, pre_unides, pre_impdes, pre_uniamo, pre_impamo, pre_gastos, pre_cveaut, pre_fe1aux, pre_fe2aux, pre_fechab, pre_fecaut, pre_ca1aux, pre_ca2aux, pre_ca3aux, pre_ca4aux, pre_ultact, pre_fecini, pre_ctreve
from labconf.nmlopres
where pre_keypro = wn_key_pro
and pre_keyemp in (
select ran_keyemp from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and ((pre_status = ws_sta_tu1) or (pre_status = ws_sta_tu2) or (pre_status = ws_sta_tu3) or (pre_status = ws_sta_tu4))
order by  pre_keycon,pre_keyemp ) loop
ws_key_con :=c_nmlstpre.pre_keycon;
wn_key_emp :=c_nmlstpre.pre_keyemp;
ws_fec_reg :=c_nmlstpre.pre_fecreg;
wn_uni_pre :=c_nmlstpre.pre_unipre;
wn_imp_pre :=c_nmlstpre.pre_imppre;
wn_uni_sal :=c_nmlstpre.pre_unisal;
wn_imp_sal :=c_nmlstpre.pre_impsal;
wn_pla_zop :=c_nmlstpre.pre_plazop;
wn_por_int :=c_nmlstpre.pre_porint;
wn_num_pag :=c_nmlstpre.pre_numpag;
ws_per_ini :=c_nmlstpre.pre_perini;
ws_sta_tus :=c_nmlstpre.pre_status;
ws_ref_ere :=c_nmlstpre.pre_refere;
wn_uni_des :=c_nmlstpre.pre_unides;
wn_imp_des :=c_nmlstpre.pre_impdes;
wn_uni_amo :=c_nmlstpre.pre_uniamo;
wn_imp_amo :=c_nmlstpre.pre_impamo;
wn_gas_tos :=c_nmlstpre.pre_gastos;
wn_cve_aut :=c_nmlstpre.pre_cveaut;
wd_fe1_aux :=c_nmlstpre.pre_fe1aux;
wd_fe2_aux :=c_nmlstpre.pre_fe2aux;
wd_fec_hab :=c_nmlstpre.pre_fechab;
wd_fec_aut :=c_nmlstpre.pre_fecaut;
ws_ca1_aux :=c_nmlstpre.pre_ca1aux;
ws_ca2_aux :=c_nmlstpre.pre_ca2aux;
ws_ca3_aux :=c_nmlstpre.pre_ca3aux;
ws_ca4_aux :=c_nmlstpre.pre_ca4aux;
wd_ult_act :=c_nmlstpre.pre_ultact;
wd_fec_ini :=c_nmlstpre.pre_fecini;
ws_ctr_eve :=c_nmlstpre.pre_ctreve;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update labconf.glcoresu
set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
end if;
ws_des_con:='CONCEPTO NO EXISTE';
begin select con_descon
into strict ws_des_con from labconf.nmloconc
where con_keycon = ws_key_con;
exception
when no_data_found then
null;
end;
ws_nom_emp:='EMPLEADO NO EXISTE';
begin select emp_nomemp
into strict ws_nom_emp from labconf.nmcoempl
where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
ws_nom_emp:= oracle.substr(ws_nom_emp,1,40);
if (wn_dsp_001=1 ) then
ws_key_con:=null;
ws_des_con:=null;
end if;
if (wn_dsp_003=1 ) then
wn_key_emp:=null;
ws_nom_emp:=null;
end if;
ws_fec_ini:= to_char(wd_fec_ini, 'mm/dd/yyyy');/* dmap converted statement start */
ws_fec_ini:=oracle. concat(substr(ws_fec_ini,1,2), oracle.substr(ws_fec_ini,4,2) , oracle.substr(ws_fec_ini,7,4)) ;/* dmap converted statement end */
ws_fe2_aux:= to_char(wd_fec_ini, 'mm/dd/yyyy');/* dmap converted statement start */
ws_fe2_aux:=oracle. concat(substr(ws_fe2_aux,1,2), oracle.substr(ws_fe2_aux,4,2) , oracle.substr(ws_fe2_aux,7,4)) ;/* dmap converted statement end */
ws_ult_act:= to_char(wd_fec_ini, 'mm/dd/yyyy');/* dmap converted statement start */
ws_ult_act:=oracle. concat(substr(ws_ult_act,1,2), oracle.substr(ws_ult_act,4,2) , oracle.substr(ws_ult_act,7,4)) ;/* dmap converted statement end */
if (wn_dsp_005=1 ) then
ws_fec_reg:=null;
end if;
if (wn_dsp_006=1 ) then
wn_uni_pre:=null;
end if;
if (wn_dsp_007=1 ) then
wn_imp_pre:=null;
end if;
if (wn_dsp_008=1 ) then
wn_uni_sal:=null;
end if;
if (wn_dsp_009=1 ) then
wn_imp_sal:=null;
end if;
if (wn_dsp_010=1 ) then
wn_pla_zop:=null;
end if;
if (wn_dsp_011=1 ) then
wn_por_int:=null;
end if;
if (wn_dsp_012=1 ) then
wn_num_pag:=null;
end if;
if (wn_dsp_013=1 ) then
ws_per_ini:=null;
end if;
if (wn_dsp_014=1 ) then
ws_sta_tus:=null;
end if;
if (wn_dsp_015=1 ) then
ws_ref_ere:=null;
end if;
if (wn_dsp_016=1 ) then
wn_uni_des:=null;
end if;
if (wn_dsp_017=1 ) then
wn_imp_des:=null;
end if;
if (wn_dsp_018=1 ) then
wn_uni_amo:=null;
end if;
if (wn_dsp_019=1 ) then
wn_imp_amo:=null;
end if;
if (wn_dsp_020=1 ) then
wn_gas_tos:=null;
end if;
if (wn_dsp_021=1 ) then
ws_fec_ini:=null;
end if;
if (wn_dsp_022=1 ) then
wd_fec_aut:=null;
end if;
if (wn_dsp_023=1 ) then
wn_cve_aut:=null;
end if;
if (wn_dsp_024=1 ) then
wd_fec_hab:=null;
end if;
if (wn_dsp_025=1 ) then
wd_fe1_aux:=null;
end if;
if (wn_dsp_026=1 ) then
ws_fe2_aux:=null;
end if;
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_chr003,cry_dec006,cry_chr004,cry_dat001,cry_dec001,cry_dec012,cry_dec013,cry_dec014,cry_dec007,cry_dec015,cry_dec008,cry_chr018,cry_chr019,cry_chr008,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr026,cry_chr027,cry_chr028,cry_chr029,cry_chr030,cry_chr031,cry_chr032,cry_chr033,cry_chr034,cry_chr035,cry_chr037,cry_chr038,cry_chr039,cry_chr040,cry_chr043,cry_chr041,cry_chr042,cry_chr044,cry_chr045,cry_chr025,cry_chr009,cry_dat002,cry_chr036,cry_chr002,cry_dec009,cry_chr010,cry_dec021,cry_dec022,cry_dec023,cry_dec024,cry_dec016,cry_dec010,cry_dat005,cry_chr011,cry_dat004,cry_dat003,cry_chr013,cry_chr014,cry_chr015,cry_chr016,cry_chr012,cry_chr007,cry_chr006)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_key_con,ws_des_con,wn_key_emp,ws_nom_emp,ws_fec_reg,wn_uni_pre,wn_imp_pre,wn_uni_sal,wn_imp_sal,wn_pla_zop,wn_por_int,wn_num_pag,ws_per_ini,ws_sta_tus,ws_ref_ere,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_etq_012,ws_etq_013,ws_etq_014,ws_etq_015,ws_etq_016,ws_etq_017,ws_etq_018,ws_etq_019,ws_etq_020,ws_etq_021,ws_etq_022,ws_etq_023,ws_etq_024,ws_etq_025,ws_etq_026,wd_fec_act,ws_hor_act,ws_des_lis,wn_key_pro,ws_des_pro,wn_uni_des,wn_imp_des,wn_uni_amo,wn_imp_amo,wn_gas_tos,wn_cve_aut,wd_fe1_aux,ws_fe2_aux,wd_fec_hab,wd_fec_aut,ws_ca1_aux,ws_ca2_aux,ws_ca3_aux,ws_ca4_aux,ws_ult_act,ws_fec_ini,ws_ctr_eve); /* commit; */
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
