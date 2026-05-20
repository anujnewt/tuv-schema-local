create or replace procedure labconf."sp_nmfalinc"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_fec_ha1 varchar,ws_fec_ha2 varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp numeric(10);
ws_fec_ini timestamp(0);
ws_fec_exp timestamp(0);
wn_dia_inc numeric(5);
ws_con_inc varchar(1);
ws_num_inc varchar(14);
ws_tip_ims varchar(2);
ws_tip_emp varchar(6);
wn_dia_noa numeric(5);
ws_emi_inc varchar(20);
ws_key_ims varchar(5);
ws_ant_ims varchar(5);
ws_des_ims varchar(40);
ws_des_lis varchar(50);
ws_var_xxx varchar(50);
ws_rec_aid varchar(1);
ws_cir_inc varchar(2);
ws_pro_rie varchar(1);
ws_tip_rie varchar(1);
ws_tip_dic varchar(1);
wn_por_val decimal(6,2);
wn_fol_st1 numeric(10);
wn_fol_st2 numeric(10);
wn_fol_st3 numeric(10);
wn_fol_st4 numeric(10);
ws_des_tan varchar(40);
ws_des_tab varchar(40);
ws_des_cor varchar(60);
ws_tab_ant numeric(5);
wn_row_ide numeric(10);
ws_key_cam varchar(10);
ws_des_etq varchar(10);
ws_eti_q01 varchar(10);
ws_eti_q02 varchar(10);
ws_eti_q03 varchar(10);
ws_eti_q04 varchar(10);
ws_eti_q05 varchar(10);
ws_eti_q06 varchar(10);
ws_eti_q07 varchar(10);
ws_eti_q08 varchar(10);
ws_eti_q09 varchar(10);
ws_eti_q010 varchar(10);
ws_eti_q011 varchar(10);
ws_eti_q012 varchar(10);
ws_eti_q013 varchar(10);
ws_eti_q014 varchar(10);
ws_eti_q015 varchar(10);
ws_eti_q016 varchar(10);
ws_eti_q017 varchar(10);
ws_eti_q018 varchar(10);
ws_eti_q019 varchar(10);
ws_eti_q020 varchar(10);
ws_eti_q021 varchar(10);
ws_dsp_cam varchar(20);
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
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_dia_act timestamp(0);
wn_ant_emp numeric(10);
ws_des_emp varchar(60);
wn_num_tem numeric(10);
ws_fec_te1 varchar(10);
ws_fec_te2 varchar(10);
c_etiquetas record;
c_nmfallinc record;
begin
if (ws_fec_ha1='01/01/1700' ) then
ws_fec_te1:='01/01/1900';
ws_fec_te2:='12/31/2099';
else
ws_fec_te1:=ws_fec_ha1;
ws_fec_te2:=ws_fec_ha2;
end if;
begin select  count(* ) alias1
into strict wn_tot_reg from nmcofalt
where fal_keyims in (
select ran_keyper from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null )
and fal_keyemp in (
select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and fal_tipims in (
select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and fal_fecini between ws_fec_te1 and ws_fec_te2;
exception
when no_data_found then
null;
end;
call sp_glfechor (ws_dia_act, ws_hor_act);
insert into glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO';
begin select cor_razsoc
into strict ws_des_cor from glcocorp;
exception
when no_data_found then
null;
end;
ws_var_xxx:='No Existe Nombre del Reporte ..';
begin select lis_deslis
into strict ws_var_xxx from glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
null;
end;
ws_des_lis:= oracle.substr(ws_var_xxx,1,40);
for c_etiquetas in ( select cam_keycam, cam_descor from glcocamp
where cam_keytab = 'nmcofalt' ) loop
ws_key_cam :=c_etiquetas.cam_keycam;
ws_des_etq :=c_etiquetas.cam_descor;
if (ws_key_cam='fal_keyemp' ) then
ws_eti_q01:=ws_des_etq;
else
if (ws_key_cam='fal_fecini' ) then
ws_eti_q02:=ws_des_etq;
else
if (ws_key_cam='fal_fecexp' ) then
ws_eti_q03:=ws_des_etq;
else
if (ws_key_cam='fal_diainc' ) then
ws_eti_q04:=ws_des_etq;
else
if (ws_key_cam='fal_coninc' ) then
ws_eti_q05:=ws_des_etq;
else
if (ws_key_cam='fal_numinc' ) then
ws_eti_q06:=ws_des_etq;
else
if (ws_key_cam='fal_tipims' ) then
ws_eti_q07:=ws_des_etq;
else
if (ws_key_cam='fal_tipemp' ) then
ws_eti_q08:=ws_des_etq;
else
if (ws_key_cam='fal_dianoa' ) then
ws_eti_q09:=ws_des_etq;
else
if (ws_key_cam='fal_emiinc' ) then
ws_eti_q010:=ws_des_etq;
else
if (ws_key_cam='fal_keyims' ) then
ws_eti_q011:=ws_des_etq;
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
call sp_glnewdsp ('nmcofalt', 'fal_keyemp', ws_key_men,wn_dsp_001);
call sp_glnewdsp ('nmcofalt', 'fal_fecini', ws_key_men,wn_dsp_002);
call sp_glnewdsp ('nmcofalt', 'fal_fecexp', ws_key_men,wn_dsp_003);
call sp_glnewdsp ('nmcofalt', 'fal_diainc', ws_key_men,wn_dsp_004);
call sp_glnewdsp ('nmcofalt', 'fal_coninc', ws_key_men,wn_dsp_005);
call sp_glnewdsp ('nmcofalt', 'fal_numinc', ws_key_men,wn_dsp_006);
call sp_glnewdsp ('nmcofalt', 'fal_tipims', ws_key_men,wn_dsp_007);
call sp_glnewdsp ('nmcofalt', 'fal_tipemp', ws_key_men,wn_dsp_008);
call sp_glnewdsp ('nmcofalt', 'fal_dianoa', ws_key_men,wn_dsp_009);
call sp_glnewdsp ('nmcofalt', 'fal_emiinc', ws_key_men,wn_dsp_010);
call sp_glnewdsp ('nmcofalt', 'fal_keyims', ws_key_men,wn_dsp_011);
call sp_glnewdsp ('nmcofalt', 'fal_recinc', ws_key_men,wn_dsp_012);
call sp_glnewdsp ('nmcofalt', 'fal_cirinc', ws_key_men,wn_dsp_013);
call sp_glnewdsp ('nmcofalt', 'fal_prorie', ws_key_men,wn_dsp_014);
call sp_glnewdsp ('nmcofalt', 'fal_tiprie', ws_key_men,wn_dsp_015);
call sp_glnewdsp ('nmcofalt', 'fal_tipdic', ws_key_men,wn_dsp_016);
call sp_glnewdsp ('nmcofalt', 'fal_porval', ws_key_men,wn_dsp_017);
call sp_glnewdsp ('nmcofalt', 'fal_falst1', ws_key_men,wn_dsp_018);
call sp_glnewdsp ('nmcofalt', 'fal_folst2', ws_key_men,wn_dsp_019);
call sp_glnewdsp ('nmcofalt', 'fal_folst3', ws_key_men,wn_dsp_020);
call sp_glnewdsp ('nmcofalt', 'fal_folst4', ws_key_men,wn_dsp_021);
ws_tab_ant:=1;
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10.0);
wn_ant_emp:=-9999;
ws_ant_ims:='-999';
for c_nmfallinc in ( select fal_keyemp, fal_fecini, fal_fecexp, fal_diainc, fal_coninc, fal_numinc, fal_tipims, fal_tipemp, fal_dianoa, fal_emiinc, fal_keyims, fal_recinc, fal_cirinc, fal_prorie, fal_tiprie, fal_tipdic, fal_porval, fal_folst1, fal_folst2, fal_folst3, fal_folst4 from nmcofalt
where fal_keyims in (
select ran_keyper from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null )
and fal_keyemp in (
select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and fal_tipims in (
select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and fal_fecini between ws_fec_te1 and ws_fec_te2 ) loop
wn_key_emp :=c_nmfallinc.fal_keyemp;
ws_fec_ini :=c_nmfallinc.fal_fecini;
ws_fec_exp :=c_nmfallinc.fal_fecexp;
wn_dia_inc :=c_nmfallinc.fal_diainc;
ws_con_inc :=c_nmfallinc.fal_coninc;
ws_num_inc :=c_nmfallinc.fal_numinc;
ws_tip_ims :=c_nmfallinc.fal_tipims;
ws_tip_emp :=c_nmfallinc.fal_tipemp;
wn_dia_noa :=c_nmfallinc.fal_dianoa;
ws_emi_inc :=c_nmfallinc.fal_emiinc;
ws_key_ims :=c_nmfallinc.fal_keyims;
ws_rec_aid :=c_nmfallinc.fal_recinc;
ws_cir_inc :=c_nmfallinc.fal_cirinc;
ws_pro_rie :=c_nmfallinc.fal_prorie;
ws_tip_rie :=c_nmfallinc.fal_tiprie;
ws_tip_dic :=c_nmfallinc.fal_tipdic;
wn_por_val :=c_nmfallinc.fal_porval;
wn_fol_st1 :=c_nmfallinc.fal_folst1;
wn_fol_st2 :=c_nmfallinc.fal_folst2;
wn_fol_st3 :=c_nmfallinc.fal_folst3;
wn_fol_st4 :=c_nmfallinc.fal_folst4;
if (wn_ant_emp != wn_key_emp  ) then
ws_des_emp:='No Existe Nombre  ...';
begin select emp_nomemp
into strict ws_des_emp from nmcoempl
where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
wn_ant_emp:=wn_key_emp;
end if;
if (ws_ant_ims != ws_key_ims ) then
ws_des_ims:='No Existe Descripcion  ...';
begin select ims_razsoc
into strict ws_des_ims from nmloimss
where ims_keyims = ws_key_ims;
exception
when no_data_found then
null;
end;
ws_ant_ims:=ws_key_ims;
end if;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update glcoresu set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu; /* commit; */
wn_pct_act:=(wn_pct_act+1);
end if;
if (wn_dsp_001=1 ) then
wn_key_emp:=0;
end if;
if (wn_dsp_002=1 ) then
ws_fec_ini:=null;
end if;
if (wn_dsp_003=1 ) then
ws_fec_exp:=null;
end if;
if (wn_dsp_004=1 ) then
wn_dia_inc:=null;
end if;
if (wn_dsp_005=1 ) then
ws_con_inc:=null;
end if;
if (wn_dsp_006=1 ) then
ws_num_inc:=null;
end if;
if (wn_dsp_007=1 ) then
ws_tip_ims:=null;
end if;
if (wn_dsp_008=1 ) then
ws_tip_emp:=null;
end if;
if (wn_dsp_009=1 ) then
wn_dia_noa:=null;
end if;
if (wn_dsp_010=1 ) then
ws_emi_inc:=null;
end if;
if (wn_dsp_011=1 ) then
ws_key_ims:=null;
end if;
if (wn_dsp_012=1 ) then
ws_key_ims:=null;
end if;
if (wn_dsp_013=1 ) then
ws_rec_aid:=null;
end if;
if (wn_dsp_014=1 ) then
ws_cir_inc:=null;
end if;
if (wn_dsp_015=1 ) then
ws_pro_rie:=null;
end if;
if (wn_dsp_016=1 ) then
ws_tip_rie:=null;
end if;
if (wn_dsp_017=1 ) then
ws_tip_dic:=null;
end if;
if (wn_dsp_018=1 ) then
wn_por_val:=null;
end if;
if (wn_dsp_019=1 ) then
wn_fol_st1:=null;
end if;
if (wn_dsp_020=1 ) then
wn_fol_st2:=null;
end if;
if (wn_dsp_021=1 ) then
wn_fol_st3:=null;
end if;
insert into glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_dec006,cry_dat001,cry_dat002,cry_dec007,cry_chr017,cry_chr012,cry_chr018,cry_chr019,cry_dec008,cry_chr008,cry_chr020,cry_chr004,cry_chr033,cry_chr034,cry_chr035,cry_chr036,cry_chr037,cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dat003,cry_dec009,cry_chr002,cry_chr003,cry_chr021,cry_chr022,cry_chr023,cry_chr024,cry_chr025,cry_chr026,cry_chr027,cry_chr028,cry_chr029,cry_chr030,cry_chr031,cry_chr032)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,wn_key_emp,ws_fec_ini,ws_fec_exp,wn_dia_inc,ws_con_inc,ws_num_inc,ws_tip_ims,ws_tip_emp,wn_dia_noa,ws_emi_inc,ws_key_ims,ws_des_ims,ws_rec_aid,ws_cir_inc,ws_pro_rie,ws_tip_rie,ws_tip_dic,wn_por_val,wn_fol_st1,wn_fol_st2,wn_fol_st3,wn_fol_st4,ws_dia_act,wn_tot_reg,ws_des_emp,ws_des_lis,ws_eti_q01,ws_eti_q02,ws_eti_q03,ws_eti_q04,ws_eti_q05,ws_eti_q06,ws_eti_q07,ws_eti_q08,ws_eti_q09,ws_eti_q010,ws_eti_q011,ws_hor_act); /* commit; */
end loop;
call sp_glfechor (ws_dia_act, ws_hor_act);
update glcoresu set res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu; /* commit; */
end;
$body$
language plpgsql
;
