create or replace procedure labconf."sp_nmlstcic"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_lis_per varchar,ws_lis_pro varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_mov_emp numeric(10);
ws_mov_con varchar(3);
wn_mov_nom numeric(5);
ws_mov_per varchar(7);
wn_mov_pro numeric(5);
ws_cod_imp varchar(2);
ws_mov_cia varchar(5);
ws_des_pro varchar(20);
ws_des_nom varchar(40);
ws_des_con varchar(40);
ws_des_cor varchar(100);
ws_des_cia varchar(100);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
ws_des_lis varchar(50);
ws_key_cia varchar(5);
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
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
ws_dia_act timestamp(0);
wn_con_tar numeric(10);
wn_tot_emp numeric(10);
wn_tot_can decimal(18,2);
wn_tot_imp decimal(18,2);
c_etiqueta record;
c_nmlstcic record;
begin
begin
select  count(* ) alias1
into strict wn_tot_reg from labconf.nmloperi
where per_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and per_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null );
exception
when no_data_found then
null;
end;
call labconf.sp_glfechor (ws_fec_act, ws_hor_act);
wn_tot_reg:=-1;
ws_dia_act:=ws_fec_act;
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
/* commit; */
ws_des_lis:='No existe nombre del Reporte';
begin select lis_deslis
into strict ws_des_lis from labconf.glcolist
where lis_keylis = 'nmcifcon';
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
for c_etiqueta in ( select cam_keycam, cam_descor, cam_descam from labconf.glcocamp
where cam_keytab in ('nmwkmovt','nmlonomi') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
ws_des_etq1 :=c_etiqueta.cam_descam;
if (ws_key_cam='mov_keypro' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='mov_keyper' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='mov_keycon' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='mov_cantid' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='mov_import' ) then
ws_etq_005:=ws_des_etq;
else
if (ws_key_cam='mov_keynom' ) then
ws_etq_006:=ws_des_etq;
else
if (ws_key_cam='nom_destip' ) then
ws_etq_007:=ws_des_etq;
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
call sp_glgetdsp ('nmwkmovt', 'mov_keypro', ws_key_men,wn_dsp_001);
call sp_glgetdsp ('nmwkmovt', 'mov_keyper', ws_key_men,wn_dsp_002);
call sp_glgetdsp ('nmwkmovt', 'mov_keycon', ws_key_men,wn_dsp_003);
call sp_glgetdsp ('nmwkmovt', 'mov_cantid', ws_key_men,wn_dsp_004);
call sp_glgetdsp ('nmwkmovt', 'mov_import', ws_key_men,wn_dsp_005);
call sp_glgetdsp ('nmwkmovt', 'mov_keynom', ws_key_men,wn_dsp_006);
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
begin select  count( distinct mov_keyemp ) alias1
into strict wn_mov_emp from labconf.nmwkmovt
where mov_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and mov_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null );
exception
when no_data_found then
null;
end;
for c_nmlstcic in ( select mov_keypro, mov_keyper, mov_codimp, mov_keycon,  sum(mov_cantid ) alias5,  sum(mov_import ) alias6,  count(* ) alias7 from labconf.nmwkmovt
where mov_keypro in (
select ran_keypro from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu)
and mov_keyper in (
select ran_keyper from labconf.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu)
group by mov_keypro,mov_keyper,mov_codimp,mov_keycon
order by  mov_keypro,mov_keyper,mov_codimp,mov_keycon ) loop
wn_mov_pro :=c_nmlstcic.mov_keypro;
ws_mov_per :=c_nmlstcic.mov_keyper;
ws_cod_imp :=c_nmlstcic.mov_codimp;
ws_mov_con :=c_nmlstcic.mov_keycon;
wn_tot_can :=c_nmlstcic.alias5;
wn_tot_imp :=c_nmlstcic.alias6;
wn_con_tar :=c_nmlstcic.alias7;
if (wn_pri_mer=0 ) then
ws_des_cor:='CORPORATIVO NO REGISTRADO';
ws_key_cia:='*';
begin select pro_keycia
into strict ws_key_cia from labconf.nmloproc
where pro_keypro = wn_mov_pro;
exception
when no_data_found then
null;
end;
begin select cia_descia
into strict ws_des_cor from labconf.nmlocias
where cia_keycia = ws_key_cia;
exception
when no_data_found then
null;
end;
ws_des_cia:=ws_des_cor;
wn_pri_mer:=(wn_pri_mer+1);
end if;
if (nullif(wn_ant_pro::text, '') is null ) then
ws_des_cor:='Compania No existe..';
ws_mov_cia:='..';
ws_des_pro:='No existe Proceso..';
else
if (wn_ant_pro != wn_mov_pro ) then
ws_des_pro:='No Existe Proceso';
ws_mov_cia:='..';
wn_ant_pro:=wn_mov_pro;
begin select pro_despro, pro_keycia
into strict ws_des_pro, ws_mov_cia from labconf.nmloproc
where pro_keypro = wn_mov_pro;
exception
when no_data_found then
null;
end;
ws_des_cia:='Companoa No existe..';
ws_des_cor:='Companoa No existe..';
begin select cia_descia
into strict ws_des_cor from labconf.nmlocias
where cia_keycia = ws_mov_cia;
exception
when no_data_found then
null;
end;
begin select  count( distinct mov_keyemp ) alias1
into strict wn_tot_emp from labconf.nmwkmovt
where mov_keypro = wn_mov_pro
and mov_keyper = ws_mov_per;
exception
when no_data_found then
null;
end;
end if;
end if;
if (nullif(ws_ant_con::text, '') is null ) then
ws_des_con:='No Existe Concepto ..';
else
if (ws_ant_con != ws_mov_con ) then
ws_des_con:='No Existe Concepto ..';
begin select con_descon
into strict ws_des_con from nmloconc
where con_keycon = ws_mov_con;
exception
when no_data_found then
null;
end;
ws_ant_con:=ws_mov_con;
end if;
end if;
if (ws_ant_cod != ws_cod_imp ) then
ws_ant_cod:=ws_cod_imp;
end if;
if (nullif(ws_ant_per::text, '') is null ) then
call sp_glfechor (wd_fec_ini, ws_hor_act);
wd_fec_fin:=wd_fec_ini;
else
call sp_glfechor (wd_fec_ini, ws_hor_act);
wd_fec_fin:=wd_fec_ini;
begin select per_fecini, per_fecfin, per_keynom
into strict wd_fec_ini, wd_fec_fin, wn_mov_nom from labconf.nmloperi
where per_keyper = ws_mov_per
and per_keypro = wn_mov_pro;
exception
when no_data_found then
null;
end;
begin select  count( distinct mov_keyemp ) alias1
into strict wn_tot_emp from labconf.nmwkmovt
where mov_keypro = wn_mov_pro
and mov_keyper = ws_mov_per;
exception
when no_data_found then
null;
end;
ws_ant_per:=ws_mov_per;
end if;
if (nullif(wn_ant_nom::text, '') is null ) then
ws_des_nom:='No Existe Nomina ..';
else
if (wn_ant_nom != wn_mov_nom ) then
ws_des_nom:='No Existe Nomina..';
begin select nom_destip
into strict ws_des_nom from labconf.nmlonomi
where nom_keynom = wn_mov_nom;
exception
when no_data_found then
null;
end;
wn_ant_nom:=wn_mov_nom;
end if;
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
if ((nullif(wn_tot_can::text, '') is null) or (nullif(wn_tot_can::text, '') is null) ) then
wn_tot_can:=0;
end if;
if ((nullif(wn_tot_imp::text, '') is null) or (nullif(wn_tot_imp::text, '') is null) ) then
wn_tot_can:=0;
end if;
if ((wn_tot_can != 0) or (wn_tot_imp != 0) and (nullif(wn_tot_can::text, '') is not null ) or (nullif(wn_tot_imp::text, '') is not null ) ) then
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr003,cry_chr004,cry_chr017,cry_chr018,cry_chr019,cry_chr010,cry_chr011,cry_chr022,cry_chr024,cry_chr025,cry_chr005,cry_dec001,cry_dec002,cry_dec006,cry_chr026,cry_dec008,cry_dec009,cry_dat001,cry_dat002,cry_dat003,cry_chr027,cry_chr002,cry_chr028,cry_chr009,cry_dec010,cry_chr006,cry_chr007,cry_chr008,cry_dec007)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,oracle.substr(ws_des_cor,1,60),ws_des_lis,ws_des_nom,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_etq_006,ws_hor_act,ws_ant_con,ws_des_con,wn_tot_can,wn_tot_imp,wn_mov_pro,ws_mov_per,wn_mov_nom,wn_con_tar,wd_fec_ini,wd_fec_fin,ws_dia_act,ws_ant_cod,oracle.substr(ws_des_cia,1,60),ws_mov_cia,ws_etq_007,wn_tot_emp,ws_lis_pro,ws_lis_per,ws_des_pro,wn_mov_emp); /* commit; */
end if;
end loop;end;
$body$
language plpgsql
;
