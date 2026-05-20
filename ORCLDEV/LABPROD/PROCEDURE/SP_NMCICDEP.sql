create or replace procedure labprod."sp_nmcicdep"  (ws_nom_rep varchar,ws_ide_pcc varchar,ws_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_lis_per varchar,ws_dep_pri varchar,ws_key_est varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_mov_emp numeric(10);
ws_mov_con varchar(3);
wn_mov_nom numeric(5);
ws_mov_per varchar(7);
wn_mov_pro numeric(5);
ws_cod_imp varchar(2);
ws_mov_cia varchar(2);
ws_cod_niv varchar(80);
ws_cod_pri varchar(80);
ws_key_dep varchar(16);
ws_des_pro varchar(20);
ws_des_dep varchar(40);
ws_des_nom varchar(20);
ws_des_con varchar(40);
ws_des_cor varchar(60);
ws_des_cia varchar(60);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_lis_pro varchar(50);
ws_lis_pr2 varchar(16);
ws_lis_pr3 varchar(16);
ws_lis_nom varchar(40);
ws_des_lis varchar(50);
ws_key_cia varchar(5);
ws_key_cam varchar(10);
ws_des_etq varchar(10);
ws_etq_001 varchar(10);
ws_etq_002 varchar(10);
ws_etq_003 varchar(10);
ws_etq_004 varchar(40);
ws_etq_005 varchar(40);
ws_etq_006 varchar(10);
ws_etq_007 varchar(40);
ws_etq_008 varchar(40);
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_dsp_007 numeric(5);
wn_ant_pro numeric(5);
ws_ant_per varchar(7);
ws_ant_con varchar(3);
wn_ant_nom numeric(5);
ws_ant_cod varchar(2);
wn_pri_mer numeric(10);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
ws_hor_act varchar(8);
ws_dia_act timestamp(0);
wn_con_tar numeric(10);
wn_tot_emp numeric(10);
wn_tot_can decimal(18,2);
wn_tot_imp decimal(18,2);
wn_tot_tra numeric(10);
c_etiqueta record;
c_des_nom record;
c_desplieg record;
c_orgcon record;
c_nmlstcic record;
begin
delete from labprod.glwkcrys
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=ws_key_usu; /* commit; */
ws_des_lis:='No existe Nombre del Reporte ...';
select lis_deslis
into strict ws_des_lis from labprod.glcolist
where lis_keylis=ws_nom_rep;
ws_etq_001:='......';
ws_etq_002:='......';
ws_etq_003:='......';
ws_etq_004:='......';
ws_etq_005:='......';
ws_etq_006:='......';
ws_etq_007:='......';
ws_etq_008:='......';
for c_etiqueta in ( select cam_keycam, cam_descor from labprod.glcocamp
where cam_keytab='nmwkmovt' ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if ws_key_cam='mov_keypro' then
ws_etq_001:=ws_des_etq;
elsif ws_key_cam='mov_keyper' then
ws_etq_002:=ws_des_etq;
elsif ws_key_cam='mov_keycon' then
ws_etq_003:=ws_des_etq;
elsif ws_key_cam='mov_cantid' then
ws_etq_004:=ws_des_etq;
elsif ws_key_cam='mov_import' then
ws_etq_005:=ws_des_etq;
elsif ws_key_cam='mov_keydep' then
ws_etq_008:=ws_des_etq;
end if;
end loop;
for c_des_nom in ( select cam_keycam, cam_descor from labprod.glcocamp
where cam_keytab='nmlonomi' ) loop
ws_key_cam :=c_des_nom.cam_keycam;
ws_des_etq :=c_des_nom.cam_descor;
if ws_key_cam='nom_keynom' then
ws_etq_006:=ws_des_etq;
elsif ws_key_cam='nom_destip' then
ws_etq_007:=ws_des_etq;
end if;
end loop;
wn_dsp_001:=0;
wn_dsp_002:=0;
wn_dsp_003:=0;
wn_dsp_004:=0;
wn_dsp_005:=0;
wn_dsp_006:=0;
wn_dsp_007:=0;
for c_desplieg in ( select rec_keycam, rec_despli from labprod.glcoreca
where rec_keytab='nmwkmovt'
and rec_keymen=ws_key_men ) loop
ws_key_cam :=c_desplieg.rec_keycam;
ws_dsp_cam :=c_desplieg.rec_despli;
if (ws_key_cam='mov_keypro' and ws_dsp_cam='N') then
wn_dsp_001:=1;
end if;
if (ws_key_cam='mov_keyper' and ws_dsp_cam='N') then
wn_dsp_002:=1;
end if;
if (ws_key_cam='mov_keycon' and ws_dsp_cam='N') then
wn_dsp_003:=1;
end if;
if (ws_key_cam='mov_cantid' and ws_dsp_cam='N') then
wn_dsp_004:=1;
end if;
if (ws_key_cam='mov_import' and ws_dsp_cam='N') then
wn_dsp_005:=1;
end if;
if (ws_key_cam='mov_keydep' and ws_dsp_cam='N') then
wn_dsp_007:=1;
end if;
end loop;
ws_ant_con:='______';
wn_ant_nom:=-9999;
ws_ant_per:='______';
wn_ant_pro:=-9999;
ws_ant_cod:='____';
ws_mov_cia:='..';
wn_num_reg:=0;
wn_con_tar:=0;
wn_tot_can:=0;
wn_tot_imp:=0;
wn_pri_mer:=0;
wn_tot_tra:=0;
ws_cod_niv:= null;
ws_des_dep:=0;
ws_lis_pro:= null;
wn_tot_emp:=0;
wn_mov_emp:=0;
call labprod.sp_glfechor (ws_dia_act, ws_hor_act);
select red_codniv
into strict ws_cod_pri from labprod.eocorede
where red_hijdep=ws_dep_pri
and red_keyest=ws_key_est;
for c_orgcon in ( select dep_keydep, red_codniv from labprod.nmcodeps, labprod.eocorede
where dep_tipdep='1'
and red_codniv like ws_cod_pri
and red_hijdep=dep_keydep ) loop
ws_key_dep :=c_orgcon.dep_keydep;
ws_cod_niv :=c_orgcon.red_codniv;
select dep_desdep
into strict ws_des_dep from labprod.nmcodeps
where dep_keydep=ws_key_dep;
select  count( distinct mov_keyemp ) alias1
into strict wn_mov_emp from labprod.nmwkmovt, labprod.eocorede
where red_hijdep=mov_keydep
and red_codniv like ws_cod_niv
and mov_keyper in (
select ran_keyper from labprod.glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=ws_key_usu
and nullif(ran_keyper::text, '') is not null );
for c_nmlstcic in ( select mov_keycon,  sum(mov_cantid ) alias2,  sum(mov_import ) alias3, mov_keypro, mov_keyper, mov_codimp,  count(* ) alias7
from labprod.nmwkmovt, labprod.eocorede
where mov_keydep=red_hijdep
and red_codniv like ws_cod_niv
and mov_keyper in (
select ran_keyper from labprod.glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=ws_key_usu
and nullif(ran_keyper::text, '') is not null )
group by mov_keypro,mov_keyper,mov_codimp,mov_keycon
order by  mov_keypro,mov_keyper,mov_codimp,mov_keycon ) loop
ws_mov_con :=c_nmlstcic.mov_keycon;
wn_tot_can :=c_nmlstcic.alias2;
wn_tot_imp :=c_nmlstcic.alias3;
wn_mov_pro :=c_nmlstcic.mov_keypro;
ws_mov_per :=c_nmlstcic.mov_keyper;
ws_cod_imp :=c_nmlstcic.mov_codimp;
wn_con_tar :=c_nmlstcic.alias7;
if (wn_pri_mer=0 ) then
ws_des_cor:='CORPORATIVO NO REGISTRADO';
select cia_descia
into strict ws_des_cor from labprod.nmlocias
where cia_keycia = (
select pro_keycia from labprod.nmloproc
where pro_keypro=wn_mov_pro);
wn_pri_mer:=(wn_pri_mer+1);
end if;
if (wn_ant_pro!=wn_mov_pro and ws_ant_per!=ws_mov_per) then
wn_num_reg:=(wn_num_reg+1);
update labprod.glcoresu set res_numreg=wn_num_reg
where res_idepro=ws_nom_rep
and res_idepcc=ws_key_usu
and res_keyusu=ws_key_usu
and res_fecini=ws_dia_act
and res_horreg=ws_hor_reg; /* commit; */
end if;
if (nullif(wn_ant_pro::text, '') is null ) then
ws_des_cia:='Compania no existe ..';
ws_mov_cia:='..';
ws_des_pro:='No existe proceso ..';
else
if (wn_ant_pro!=wn_mov_pro ) then
ws_des_pro:='No Existe Proceso ..';
ws_mov_cia:='..';
select pro_despro, pro_keycia
into strict ws_des_pro, ws_mov_cia from labprod.nmloproc
where pro_keypro=wn_mov_pro;
ws_des_cia:='Compania no existe ..';
select cia_descia
into strict ws_des_cia from labprod.nmlocias
where cia_keycia=ws_mov_cia;
select ran_keycen, ran_keypue, ran_keydep
into strict ws_lis_pro, ws_lis_pr2, ws_lis_pr3 from labprod.glwkrang
where ran_keypro=wn_mov_pro
and ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=ws_key_usu;/* dmap converted statement start */
ws_lis_pro:= concat( rtrim(ltrim(ws_lis_pro)::text), rtrim(ltrim(ws_lis_pr2)::text) , rtrim(ltrim(ws_lis_pr3)::text)) ;/* dmap converted statement end */
ws_lis_pro:= oracle.substr(ws_lis_pro,1,40);
select  count( distinct mov_keyemp ) alias1
into strict wn_tot_emp from labprod.nmwkmovt, labprod.eocorede
where mov_keypro=wn_mov_pro
and mov_keyper=ws_mov_per
and mov_keydep=red_hijdep
and red_codniv like ws_cod_niv;
wn_ant_pro:=wn_mov_pro;
end if;
end if;
if (nullif(ws_ant_con::text, '') is null ) then
ws_des_con:='No existe Concepto ..';
else
ws_des_con:='No Existe Concepto ..';
select con_descon
into strict ws_des_con from labprod.nmloconc
where con_keycon=ws_mov_con;
ws_ant_con:=ws_mov_con;
end if;
if (ws_ant_cod!=ws_cod_imp ) then
ws_ant_cod:=ws_cod_imp;
end if;
if (nullif(ws_ant_per::text, '') is null ) then
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
else
if (ws_ant_per!=ws_mov_per ) then
wd_fec_ini:=ws_dia_act;
wd_fec_fin:=ws_dia_act;
select per_fecini, per_fecfin, per_keynom
into strict wd_fec_ini, wd_fec_fin, wn_mov_nom from labprod.nmloperi
where per_keyper=ws_mov_per
and per_keypro=wn_mov_pro;
select  count( distinct mov_keyemp ) alias1
into strict wn_tot_emp from labprod.nmwkmovt, labprod.eocorede
where mov_keypro=wn_mov_pro
and mov_keyper=ws_mov_per
and mov_keydep=red_hijdep
and red_codniv like ws_cod_niv;
end if;
end if;
if (nullif(wn_ant_nom::text, '') is null ) then
ws_des_nom:='No Existe Nomina ..';
else
ws_des_nom:='No Existe Nomina ..';
select nom_destip
into strict ws_des_nom from labprod.nmlonomi
where nom_keynom=wn_mov_nom;
select distinct ran_keycat
into strict ws_lis_nom from labprod.glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=ws_key_usu;
end if;
if (wn_dsp_001=1 ) then
wn_mov_pro:=null;
end if;
if (wn_dsp_002=1 ) then
ws_mov_per:=null;
end if;
if (wn_dsp_003=1 ) then
ws_mov_con:=null;
end if;
if (wn_dsp_004=1 ) then
wn_tot_can:=null;
end if;
if (wn_dsp_005=1 ) then
wn_tot_imp:=null;
end if;
if (wn_dsp_007=1 ) then
ws_key_dep:=null;
ws_des_dep:=null;
end if;
insert into labprod.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr003,cry_chr015,cry_chr017,cry_chr018,cry_chr019,cry_chr010,cry_chr011,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr009,cry_dec010,cry_chr006,cry_chr007,cry_chr008,cry_chr012,cry_dec007,cry_chr016,cry_chr004,cry_chr029)
values (ws_nom_rep,ws_ide_pcc,ws_key_usu,ws_des_cor,ws_des_lis,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_mov_pro,ws_mov_per,wn_mov_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,ws_des_cia,ws_mov_cia,ws_etq_007,wn_tot_emp,ws_lis_pro,ws_lis_per,ws_des_pro,ws_lis_nom,wn_mov_emp,ws_key_dep,ws_des_dep,ws_etq_008); /* commit; */
end loop;
end loop;
call labprod.sp_glfechor (ws_dia_act, ws_hor_act);
update labprod.glcoresu set res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro=ws_nom_rep
and res_idepcc=ws_ide_pcc
and res_keyusu=ws_key_usu
and res_fecini=ws_dia_act
and res_horreg=ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
