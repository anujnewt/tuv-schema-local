create or replace procedure labconf."sp_nmlstmo4"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,wn_key_pro numeric,ws_key_per varchar,wn_tip_rep numeric,ws_nom_rp1 varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_cia varchar(5);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_ant_emp numeric(10);
ws_ant_con varchar(3);
wn_can_tid decimal(18,6);
wn_can_ti2 decimal(18,6);
wn_imp_ort decimal(18,6);
wn_imp_or2 decimal(18,6);
ws_des_con varchar(40);
ws_des_co2 varchar(40);
ws_des_cor varchar(60);
ws_des_lis varchar(40);
ws_key_cam varchar(18);
ws_des_lar varchar(40);
ws_des_etq varchar(40);
ws_etq_001 varchar(40);
ws_etq_002 varchar(40);
ws_etq_003 varchar(40);
ws_etq_004 varchar(40);
ws_etq_005 varchar(40);
ws_etq_006 varchar(40);
wd_fec_act timestamp(0);
ws_hor_act varchar(8);
ws_key_con varchar(3);
ws_key_co2 varchar(3);
ws_nom_emp varchar(60);
wn_con_reg numeric(5);
wn_lim_ite numeric(5);
wn_key_emp numeric(10);
ws_cod_imp varchar(2);
c_etiqueta record;
c_nmlstcic record;
begin
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu; /* commit; */
call labconf.sp_glgetdsp ('nmwkmovt', 'mov_cantid', ws_key_men,wn_dsp_001);
call labconf.sp_glgetdsp ('nmwkmovt', 'mov_import', ws_key_men,wn_dsp_002);
call labconf.sp_glfechor (wd_fec_act, ws_hor_act);
ws_key_cia:='..';
wn_ant_emp:=-9999;
ws_ant_con:='...';
ws_des_lis:='No existe nombre del Reporte';
begin select lis_deslis
into strict ws_des_lis from labconf.glcolist
where lis_keylis = ws_nom_rp1;
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
for c_etiqueta in ( select cam_keycam, cam_descor, cam_descam from labconf.glcocamp
where cam_keytab in ('nmwkmovt','nmcoempl','nmloconc')
and cam_keycam in ('mov_keyemp','mov_keycon','mov_cantid','mov_import','emp_nomemp','con_descon') ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
ws_des_lar :=c_etiqueta.cam_descam;
if (ws_key_cam='mov_keyemp' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='emp_nomemp' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='mov_keycon' ) then
ws_etq_003:=ws_des_lar;
else
if (ws_key_cam='con_descon' ) then
ws_etq_004:=ws_des_lar;
else
if (ws_key_cam='mov_cantid' ) then
ws_etq_005:= oracle.substr(ws_des_lar,1,20);
else
if (ws_key_cam='mov_import' ) then
ws_etq_006:= oracle.substr(ws_des_lar,1,20);
end if;
end if;
end if;
end if;
end if;
end if;
end loop;
begin select oracle.substr(cia_descia, 1,60)
into strict ws_des_cor from labconf.nmlocias
where cia_keycia in (
select pro_keycia from labconf.nmloproc
where pro_keypro = wn_key_pro);
exception
when no_data_found then
null;
end;
for c_nmlstcic in ( select mov_keyemp, mov_keycon, mov_cantid, mov_import, mov_codimp
from labconf.nmwkmovt
where mov_keypro = wn_key_pro
and mov_keyper = ws_key_per
order by  mov_keyemp, mov_keycon ) loop
wn_key_emp :=c_nmlstcic.mov_keyemp;
ws_key_con :=c_nmlstcic.mov_keycon;
wn_can_tid :=c_nmlstcic.mov_cantid;
wn_imp_ort :=c_nmlstcic.mov_import;
ws_cod_imp :=c_nmlstcic.mov_codimp;
if (nullif(wn_key_emp::text, '') is null ) then
ws_nom_emp:='Empleado No Existe ...';
else
if (wn_ant_emp != wn_key_emp ) then
ws_nom_emp:= null;
wn_ant_emp:=wn_key_emp;
begin select emp_nomemp
into strict ws_nom_emp from labconf.nmcoempl
where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
end if;
end if;
if (nullif(ws_key_con::text, '') is null ) then
ws_des_con:='Concepto No Existe ...';
else
if (ws_ant_con != ws_key_con ) then
ws_des_con:= null;
ws_ant_con:=ws_key_con;
begin select con_descon
into strict ws_des_con from labconf.nmloconc
where con_keycon = ws_key_con;
exception
when no_data_found then
null;
end;
end if;
end if;
if (ws_cod_imp='02' ) then
wn_imp_ort:=(wn_imp_ort*-1);
end if;
if (wn_tip_rep=1 ) then
if ((ws_cod_imp='03') or (ws_cod_imp='04') ) then
ws_key_co2:=ws_key_con;
ws_des_co2:=ws_des_con;
wn_can_ti2:=wn_can_tid;
wn_imp_or2:=wn_imp_ort;
ws_key_con:=null;
ws_des_con:=null;
wn_imp_ort:=null;
wn_can_tid:=null;
end if;
end if;
if (wn_dsp_001=1 ) then
wn_can_tid:=null;
end if;
if (wn_dsp_002=1 ) then
wn_imp_ort:=null;
end if;
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_chr003,cry_dec006,cry_chr002,cry_dec001,cry_dec002,cry_chr006,cry_chr007,cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_dat001,cry_chr024,cry_chr025,cry_chr004,cry_dec003,cry_dec004,cry_chr005)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,oracle.substr(ws_des_cor,1,60),ws_key_con,ws_des_con,wn_key_emp,ws_nom_emp,wn_can_tid,wn_imp_ort,ws_etq_003,ws_etq_004,ws_etq_001,ws_etq_002,ws_etq_005,ws_etq_006,wd_fec_act,ws_hor_act,ws_key_co2,ws_des_co2,wn_can_ti2,wn_imp_or2,ws_des_lis); /* commit; */
ws_key_co2:=null;
ws_des_co2:=null;
wn_can_ti2:=null;
wn_imp_or2:=null;
end loop;end;
$body$
language plpgsql
;
