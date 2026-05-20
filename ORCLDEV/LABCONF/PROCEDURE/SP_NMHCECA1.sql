create or replace procedure labconf."sp_nmhceca1"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_lis_per varchar,ws_lis_pro varchar,ws_lis_dep varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_his_dep numeric(5);
wn_sum_pro numeric(10);
wn_sum_per numeric(10);
wn_his_emp numeric(10);
ws_his_con varchar(3);
ws_his_per varchar(7);
wn_his_pro numeric(5);
ws_cod_imp varchar(2);
ws_his_cia varchar(2);
ws_des_pro varchar(20);
ws_des_nom varchar(20);
ws_des_not varchar(40);
ws_des_con varchar(40);
ws_des_cia varchar(60);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_des_lis varchar(50);
ws_key_cia varchar(5);
ws_des_dep varchar(40);
ws_key_cam varchar(10);
ws_des_etq varchar(10);
ws_des_etq1 varchar(40);
ws_etq_001 varchar(10);
ws_etq_002 varchar(10);
ws_etq_003 varchar(10);
ws_etq_004 varchar(40);
ws_etq_005 varchar(40);
ws_etq_006 varchar(10);
ws_etq_007 varchar(40);
ws_etq_008 varchar(16);
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_ant_pro numeric(5);
ws_ant_per varchar(7);
ws_ant_con varchar(3);
wn_ant_nom numeric(5);
ws_ant_cod varchar(2);
wn_pri_mer numeric(10);
wn_ant_emp numeric(10);
ws_ant_dep varchar(16);
ws_his_dep varchar(16);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
ws_hor_act varchar(8);
ws_dia_act  timestamp(0);
wn_con_tar numeric(10);
wn_tot_emp numeric(10);
wn_tot_can decimal(18,2);
wn_tot_imp decimal(18,2);
wn_tot_tra numeric(10);
wn_his_nom numeric(5);
c_etiqueta record;
c_etiqueta2 record;
c_des_nom record;
c_desplieg record;
c_nmlsthis record;
begin
call labconf.sp_glfechor (ws_dia_act, ws_hor_act);
wn_tot_reg:=0;
insert into labconf.glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini, res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
ws_des_lis:='No existe nombre del Reporte';
begin select lis_deslis
into strict ws_des_lis from labconf.glcolist
where lis_keylis = ws_nom_rep;
exception
when no_data_found then
null;
end;
ws_etq_001:='----------';
ws_etq_002:='----------';
ws_etq_003:='----------';
ws_etq_004:='----------';
ws_etq_005:='----------';
ws_etq_006:='----------';
ws_etq_007:='----------';
ws_etq_008:='----------';
wn_his_dep:=0;
wn_dsp_001:=0;
wn_dsp_002:=0;
wn_dsp_003:=0;
wn_dsp_004:=0;
wn_dsp_005:=0;
wn_dsp_006:=0;
ws_ant_con:='______';
wn_ant_nom:=-9999;
ws_ant_per:='______';
wn_ant_pro:=-999;
ws_ant_cod:='____';
ws_ant_dep:='________';
ws_his_cia:='..';
wn_num_reg:=0;
wn_con_tar:=0;
wn_tot_can:=0;
wn_tot_imp:=0;
wn_tot_tra:=0;
wn_pri_mer:=0;
wn_tot_tra:=0;
for c_etiqueta in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab = 'nmlohism' ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if (ws_key_cam='his_keypro' ) then
ws_etq_001:=ws_des_etq;
end if;
if (ws_key_cam='his_keyper' ) then
ws_etq_002:=ws_des_etq;
end if;
if (ws_key_cam='his_keycon' ) then
ws_etq_003:=ws_des_etq;
end if;
if (ws_key_cam='his_ca1aux' ) then
ws_etq_008:=ws_des_etq;
end if;
if (ws_key_cam='his_cantid' ) then
ws_etq_004:=ws_des_etq;
end if;
if (ws_key_cam='his_import' ) then
ws_etq_005:=ws_des_etq;
end if;
end loop;
for c_etiqueta2 in ( select cam_keycam, cam_descam from labconf.glcocamp
where cam_keytab = 'nmloconc' ) loop
ws_key_cam :=c_etiqueta2.cam_keycam;
ws_des_etq1 :=c_etiqueta2.cam_descam;
if (ws_key_cam='con_descon' ) then
ws_etq_007:=ws_des_etq1;
end if;
end loop;
for c_des_nom in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab = 'nmlonomi' ) loop
ws_key_cam :=c_des_nom.cam_keycam;
ws_des_etq :=c_des_nom.cam_descor;
if (ws_key_cam='nom_keynom' ) then
ws_etq_006:=ws_des_etq;
end if;
end loop;
for c_desplieg in ( select rec_keycam, rec_despli from labconf.glcoreca
where rec_keytab = 'nmlohism'
and rec_keymen = ws_key_men ) loop
ws_key_cam :=c_desplieg.rec_keycam;
ws_des_etq1 :=c_desplieg.rec_despli;
if (ws_key_cam='ms_his_pro' and ws_dsp_cam='N') then
wn_dsp_001:=1;
end if;
if (ws_key_cam='ws_his_per' and ws_dsp_cam='N') then
wn_dsp_002:=1;
end if;
if (ws_key_cam='wn_his_con' and ws_dsp_cam='N') then
wn_dsp_003:=1;
end if;
if (ws_key_cam='wn_tot_can' and ws_dsp_cam='N') then
wn_dsp_004:=1;
end if;
if (ws_key_cam='wn_tot_imp' and ws_dsp_cam='N') then
wn_dsp_005:=1;
end if;
end loop;
for c_nmlsthis in ( select his_keypro, his_keyper, his_ca1aux, his_codimp, his_keycon,  sum(his_cantid ) alias6,  sum(his_import ) alias7,  count(* ) alias8
from labconf.nmlohism
where his_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_ca1aux in (
select ran_keydep from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null )
group by his_ca1aux, his_keypro, his_keyper, his_codimp, his_keycon
order by  his_ca1aux, his_keypro, his_keyper, his_codimp, his_keycon ) loop
wn_his_pro :=c_nmlsthis.his_keypro;
ws_his_per :=c_nmlsthis.his_keyper;
ws_his_dep :=c_nmlsthis.his_ca1aux;
ws_cod_imp :=c_nmlsthis.his_codimp;
ws_his_con :=c_nmlsthis.his_keycon;
wn_tot_can :=c_nmlsthis.alias6;
wn_tot_imp :=c_nmlsthis.alias7;
wn_con_tar :=c_nmlsthis.alias8;
if (nullif(ws_his_dep::text, '') is null and ws_ant_dep=1) then
wn_his_dep:=1;
begin select  count( distinct his_keyemp ) alias1
into strict wn_his_emp from labconf.nmlohism
where his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and nullif(his_ca1aux::text, '') is null;
exception
when no_data_found then
null;
end;
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_pro from labconf.nmlohism
where his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_keypro = wn_his_pro
and nullif(his_ca1aux::text, '') is null;
exception
when no_data_found then
null;
end;
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_per from labconf.nmlohism
where his_keyper = ws_his_per
and his_keypro = wn_his_pro
and nullif(his_ca1aux::text, '') is null;
exception
when no_data_found then
null;
end;
else
if (ws_his_dep != ws_ant_dep ) then
begin select  count( distinct his_keyemp ) alias1
into strict wn_his_emp from labconf.nmlohism
where his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_pro from labconf.nmlohism
where his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_keypro = wn_his_pro
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_per from labconf.nmlohism
where his_keyper = ws_his_per
and his_keypro = wn_his_pro
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
else
if (wn_his_pro != wn_ant_pro ) then
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_pro from labconf.nmlohism
where his_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keydep::text, '') is not null )
and his_keypro = wn_his_pro
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_per from labconf.nmlohism
where his_keyper = ws_his_per
and his_keypro = wn_his_pro
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
else
if (ws_his_per != ws_ant_per ) then
begin select  count( distinct his_keyemp ) alias1
into strict wn_sum_per from labconf.nmlohism
where his_keyper = ws_his_per
and his_keypro = wn_his_pro
and his_ca1aux = ws_his_dep;
exception
when no_data_found then
null;
end;
end if;
end if;
end if;
end if;
if (nullif(ws_ant_dep::text, '') is null ) then
ws_des_dep:='No Existe Departamento';
else
if (ws_ant_dep != ws_his_dep ) then
ws_des_dep:='No Existe';
call sp_nomdes (ws_his_dep, 1,ws_des_dep);
ws_ant_dep:=ws_his_dep;
end if;
end if;
if (nullif(wn_ant_pro::text, '') is null ) then
ws_des_cia:='Compania No existe...';
ws_his_cia:='..';
ws_des_pro:='No Existe Proceso...';
else
if (wn_ant_pro != wn_his_pro ) then
ws_des_pro:='No Existe Proceso...';
ws_his_cia:='..';
begin select pro_despro, pro_keycia
into strict ws_des_pro, ws_his_cia from labconf.nmloproc
where pro_keypro = wn_his_pro;
exception
when no_data_found then
null;
end;
ws_des_cia:='Compania No existe...';
begin select cia_descia
into strict ws_des_cia from labconf.nmlocias
where cia_keycia = ws_his_cia;
exception
when no_data_found then
null;
end;
wn_ant_pro:=wn_his_pro;
end if;
end if;
if (nullif(ws_ant_con::text, '') is null ) then
ws_des_con:='No Existe Concepto...';
else
if (ws_ant_con != ws_his_con ) then
ws_des_con:='No Existe Concepto...';
begin select con_descon
into strict ws_des_con from labconf.nmloconc
where con_keycon = ws_his_con;
exception
when no_data_found then
null;
end;
ws_ant_con:=ws_his_con;
end if;
end if;
if (ws_ant_cod != ws_cod_imp ) then
ws_ant_cod:=ws_cod_imp;
end if;
if (nullif(ws_ant_per::text, '') is null ) then
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
else
if (ws_ant_per != ws_his_per ) then
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
begin select per_fecini, per_fecfin, per_keynom
into strict wd_fec_ini, wd_fec_fin, wn_his_nom from labconf.nmloperi
where  per_keyper = ws_his_per
and per_keypro = wn_his_pro;
exception
when no_data_found then
null;
end;
ws_ant_per:=ws_his_per;
end if;
end if;
if (nullif(wn_ant_nom::text, '') is null ) then
ws_des_nom:='No Existe Nomina.';
else
if (wn_ant_nom != wn_his_nom ) then
ws_des_nom:='No Existe Nomina...';
begin select nom_destip
into strict ws_des_not from labconf.nmlonomi
where nom_keynom = wn_his_nom;
exception
when no_data_found then
null;
end;
wn_ant_nom:=wn_his_nom;
ws_des_nom:= oracle.substr(ws_des_not,1,20);
end if;
end if;
if (wn_dsp_001=1 ) then
wn_his_pro:=null;
end if;
if (wn_dsp_002=1 ) then
ws_his_per:=null;
end if;
if (wn_dsp_003=1 ) then
ws_his_con:=null;
end if;
if (wn_dsp_004=1 ) then
wn_tot_can:=null;
end if;
if (wn_dsp_005=1 ) then
wn_tot_imp:=null;
end if;
if (wn_dsp_006=1 ) then
ws_his_dep:=null;
end if;
if (nullif(wn_tot_can::text, '') is null ) then
wn_tot_can:=0;
end if;
if (nullif(wn_tot_imp::text, '') is null ) then
wn_tot_imp:=0;
end if;
if ((wn_tot_can != 0) or (wn_tot_imp != 0) ) then
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr008,cry_chr004,cry_chr017,cry_chr018,cry_chr019,cry_chr009,cry_chr010,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr011,cry_dec010,cry_chr006,cry_chr007,cry_chr003,cry_dec007,cry_chr014,cry_chr015,cry_dec011,cry_dec012)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cia,ws_des_pro,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_007,ws_etq_004,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_his_pro,ws_his_per,wn_his_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,ws_lis_per,ws_his_cia,ws_etq_005,wn_his_emp,ws_lis_pro,ws_des_dep,ws_des_lis,wn_his_emp,ws_ant_dep,ws_etq_008,wn_sum_pro,wn_sum_per); /* commit; */
end if;
end loop;
ws_hor_act:=ws_hor_act;
update labconf.glcoresu set  res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act, res_status ='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = ws_dia_act
and res_horreg = ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
