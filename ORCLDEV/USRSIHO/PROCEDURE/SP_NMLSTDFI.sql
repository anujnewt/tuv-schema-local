create or replace procedure usrsiho."sp_nmlstdfi"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp numeric(10);
ws_key_con varchar(40);
wn_key_pro numeric(10);
ws_key_dep varchar(16);
ws_dfi_pue varchar(8);
wd_dfi_fec timestamp(0);
wn_dfi_can decimal(12,2);
wn_dfi_imp decimal(12,2);
ws_per_eje varchar(7);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_nom_emp varchar(60);
ws_nom_dep varchar(40);
ws_des_con varchar(40);
ws_des_pro varchar(40);
ws_key_cia varchar(2);
wn_pri_mer numeric(10);
ws_des_cor varchar(60);
ws_des_lis varchar(50);
ws_des_etq varchar(10);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(8);
ws_etq_005 varchar(8);
ws_etq_006 varchar(8);
ws_etq_007 varchar(8);
ws_etq_008 varchar(20);
ws_etq_009 varchar(20);
ws_etq_010 varchar(20);
ws_etq_011 varchar(8);
ws_etq_012 varchar(20);
ws_key_cam varchar(20);
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_ant_emp numeric(10);
ws_ant_con varchar(3);
wn_ant_pro numeric(10);
ws_ant_dep varchar(16);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_dia_act timestamp(0);
wn_num_tem numeric(10);
ws_des_eti varchar(40);
c_etiqueta record;
c_nmlstdfi record;
begin
begin select  count(* ) alias1
into strict wn_tot_reg from usrsiho.nmlodfij
where dfi_keydep in (
select ran_keydep from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and dfi_keyemp in (
select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and dfi_keycon in (
select ran_keycon from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and dfi_keypro in (
select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null );
exception
when no_data_found then
null;
end;
call usrsiho.sp_glfechor (ws_dia_act, ws_hor_act);
insert into usrsiho.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO ..';
begin select cor_descor
into strict ws_des_cor from usrsiho.glcocorp;
exception
when no_data_found then
null;
end;
ws_des_lis:='No existe Nombre del Reporte';
begin select lis_deslis
into strict ws_des_lis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
null;
end;
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
for c_etiqueta in ( select cam_keycam, cam_descor, cam_descam from usrsiho.glcocamp
where cam_keytab in ('nmlodfij','nmloproc','nmloperi','nmloconc','nmcoempl')
and cam_keycam in ('dfi_keyemp','dfi_keycon','dfi_keypro','dfi_cantid','dfi_import','dfi_fecmov','dfi_keydep','dfi_keypue','con_descon','emp_nomemp','pro_pereje') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
ws_des_eti :=c_etiqueta.cam_descam;
if (ws_key_cam='dfi_keyemp' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='dfi_keycon' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='dfi_keypro' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='dfi_cantid' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='dfi_import' ) then
ws_etq_005:=ws_des_etq;
else
if (ws_key_cam='dfi_fecmov' ) then
ws_etq_006:=ws_des_etq;
else
if (ws_key_cam='dfi_keydep' ) then
ws_etq_007:=ws_des_etq;
ws_etq_012:= oracle.substr(ws_des_eti,1,20);
else
if (ws_key_cam='dfi_keypue' ) then
ws_etq_008:= oracle.substr(ws_des_eti,1,20);
else
if (ws_key_cam='con_descon' ) then
ws_etq_009:= oracle.substr(ws_des_eti,1,20);
else
if (ws_key_cam='emp_nomemp' ) then
ws_etq_010:= oracle.substr(ws_des_eti,1,20);
else
if (ws_key_cam='pro_pereje' ) then
ws_etq_011:=ws_des_etq;
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
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_cantid', ws_key_men,wn_dsp_001);
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_import', ws_key_men,wn_dsp_002);
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_fecmov', ws_key_men,wn_dsp_003);
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_keypro', ws_key_men,wn_dsp_004);
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_keypue', ws_key_men,wn_dsp_005);
call usrsiho.sp_glnewdsp ('nmlodfij', 'dfi_cantid', ws_key_men,wn_dsp_001);
wn_ant_emp:=-0000;
ws_ant_con:='______';
wn_ant_pro:=-0000;
ws_ant_dep:=0;
wn_num_reg:=1;
wn_pct_act:=(wn_tot_reg/10.0);
wn_pri_mer:=0;
for c_nmlstdfi in ( select dfi_keydep, dfi_keyemp, dfi_keycon, dfi_keypro, dfi_fecmov, dfi_cantid, dfi_import, dfi_keypue from usrsiho.nmlodfij
where dfi_keyemp in (
select ran_keyemp from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and dfi_keycon in (
select ran_keycon from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and dfi_keypro in (
select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
order by  dfi_keydep,dfi_keyemp,dfi_keycon,dfi_keypro ) loop
ws_key_dep :=c_nmlstdfi.dfi_keydep;
wn_key_emp :=c_nmlstdfi.dfi_keyemp;
ws_key_con :=c_nmlstdfi.dfi_keycon;
wn_key_pro :=c_nmlstdfi.dfi_keypro;
wd_dfi_fec :=c_nmlstdfi.dfi_fecmov;
wn_dfi_can :=c_nmlstdfi.dfi_cantid;
wn_dfi_imp :=c_nmlstdfi.dfi_import;
ws_dfi_pue :=c_nmlstdfi.dfi_keypue;
if (wn_pri_mer=0 ) then
ws_des_cor:='CORPORATIVO NO REGISTRADO';
ws_key_cia:='*';
begin select pro_keycia, cia_descia
into strict ws_key_cia, ws_des_cor from usrsiho.nmloproc,usrsiho.nmlocias
where pro_keypro = wn_key_pro
and pro_keycia = cia_keycia;
exception
when no_data_found then
null;
end;
wn_pri_mer:=(wn_pri_mer+1);
end if;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update usrsiho.glcoresu set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = ws_dia_act
and res_horreg = ws_hor_reg; /* commit; */
wn_pct_act:=(wn_pct_act+1);
end if;
if (nullif(ws_key_dep::text, '') is null ) then
ws_nom_dep:='Departamento No Existe.';
else
ws_nom_dep:='Departamento no Existe.';
begin select dep_desdep
into strict ws_nom_dep from usrsiho.nmcodeps
where dep_keydep = ws_key_dep;
exception
when no_data_found then
null;
end;
ws_ant_dep:=ws_key_dep;
end if;
if (nullif(wn_key_emp::text, '') is null ) then
ws_nom_emp:='Empleado No Existe..';
else
ws_nom_emp:='Empleado No Existe..';
begin select emp_nomemp
into strict ws_nom_emp from usrsiho.nmcoempl
where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
wn_ant_emp:=wn_key_emp;
ws_nom_emp:= oracle.substr(ws_nom_emp,1,40);
end if;
if (nullif(ws_key_con::text, '') is null ) then
ws_des_con:='Concepto No Existe..';
else
ws_des_con:='Concepto No existe ..';
begin select con_descon
into strict ws_des_con from usrsiho.nmloconc
where con_keycon = ws_key_con;
exception
when no_data_found then
null;
end;
ws_ant_con:=ws_key_con;
end if;
if (nullif(wn_key_pro::text, '') is null ) then
ws_per_eje:=-00;
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
else
ws_per_eje:=-00;
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
begin select pro_pereje, pro_despro
into strict ws_per_eje, ws_des_pro from usrsiho.nmloproc
where pro_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
begin select per_fecini, per_fecfin
into strict wd_fec_ini, wd_fec_fin from usrsiho.nmloproc,usrsiho.nmloperi
where per_keypro = wn_key_pro
and pro_pereje = per_keyper
and pro_keypro = per_keypro;
exception
when no_data_found then
null;
end;
wn_ant_pro:=wn_key_pro;
end if;
if (wn_dsp_001=1 ) then
wd_dfi_fec:=null;
end if;
if (wn_dsp_002=1 ) then
wn_dfi_can:=null;
end if;
if (wn_dsp_003=1 ) then
wn_dfi_imp:=null;
end if;
if (wn_dsp_004=1 ) then
wn_key_pro:=null;
end if;
if (wn_dsp_005=1 ) then
ws_dfi_pue:=null;
end if;
insert into usrsiho.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr002,cry_dec006,cry_chr012,cry_dec007,cry_dat001,cry_dec001,cry_dec002,cry_chr013,cry_chr014,cry_chr015,cry_dat002,cry_dat003,cry_chr003,cry_chr004,cry_chr005,cry_chr006,cry_chr030,cry_chr031,cry_chr032,cry_chr033,cry_chr034,cry_chr035,cry_chr036,cry_chr008,cry_chr009,cry_chr010,cry_chr040,cry_chr011,cry_chr021,cry_dat004)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_des_lis,wn_key_emp,ws_key_con,wn_key_pro,wd_dfi_fec,wn_dfi_can,wn_dfi_imp,ws_key_dep,ws_dfi_pue,ws_per_eje,wd_fec_ini,wd_fec_fin,ws_nom_emp,ws_des_con,ws_des_pro,ws_nom_dep,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_etq_007,ws_etq_008,ws_etq_009,ws_etq_010,ws_etq_011,ws_etq_012,ws_hor_act,ws_dia_act); /* commit; */
end loop;
call usrsiho.sp_glfechor (ws_dia_act, ws_hor_act);
update usrsiho.glcoresu set res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = ws_dia_act
and res_horreg = ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
