create or replace procedure labconf."sp_nmhismoc"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,ws_etq_rep varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_con varchar(3);
wn_can_mov decimal(16,2);
wn_imp_mov decimal(16,2);
ws_key_per varchar(7);
wn_key_pro numeric(10);
ws_des_pro varchar(20);
wn_key_emp numeric(10);
wn_emp_ant numeric(10);
ws_nom_emp varchar(60);
ws_des_lis varchar(40);
ws_var_xxx varchar(50);
ws_des_con varchar(40);
ws_des_cor varchar(60);
ws_con_ant varchar(3);
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
ws_dsp_cam varchar(1);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
ws_key_cia varchar(5);
ws_cod_imp varchar(2);
ws_cod_ant varchar(2);
c_descor record;
c_etiqueta record;
c_nmhismoc record;
begin
call labconf.sp_glfechor (ws_fec_act, ws_hor_act);
delete from labconf.glwkcrys
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu;
--gsa
-- extrae el nombre de la compania --
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for  c_descor in (select pro_keycia	from labconf.nmloproc
where pro_keypro  in (select his_keypro from labconf.nmwkhism
where  his_idepcc = ws_ide_pcc)) loop
ws_key_cia:=c_descor.pro_keycia;
--if ws_key_cia != '' then
begin select cia_descia into strict ws_des_cor
from labconf.nmlocias    where cia_keycia = ws_key_cia;
exception
when no_data_found then
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
--null;
end;
--end if;
end loop;
--/gsa
ws_etq_001:='....';
ws_etq_002:='....';
ws_etq_003:='....';
ws_etq_004:='....';
ws_etq_005:='....';
ws_etq_007:='....';
for c_etiqueta in ( select cam_keycam, cam_descor from labconf.glcocamp
where cam_keytab='nmlohism' ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if ws_key_cam='his_keycon' then
ws_etq_001:=ws_des_etq;
elsif ws_key_cam='his_cantid' then
ws_etq_002:=ws_des_etq;
elsif ws_key_cam='his_import' then
ws_etq_003:=ws_des_etq;
elsif ws_key_cam='his_keyper' then
ws_etq_004:=ws_des_etq;
elsif ws_key_cam='his_keypro' then
ws_etq_005:=ws_des_etq;
elsif ws_key_cam='his_keyemp' then
ws_etq_007:=ws_des_etq;
end if;
end loop;
ws_etq_006:='DESCRIP';
begin select cam_descor	into strict ws_etq_006 from labconf.glcocamp	where cam_keytab='nmloconc'
and cam_keycam='con_descon';
exception
when no_data_found then
null;
end;
ws_etq_008:='NOMBRE';
begin select cam_descor	into strict ws_etq_008 from labconf.glcocamp	where cam_keytab='nmcoempl'
and cam_keycam='emp_nomemp';
exception
when no_data_found then
null;
end;
wn_dsp_001:=0;
wn_dsp_002:=0;
wn_dsp_003:=0;
wn_dsp_004:=0;
wn_dsp_005:=0;
call labconf.sp_glnewdsp ('nmlohism', 'his_keyemp', ws_key_men,wn_dsp_001);
call labconf.sp_glnewdsp ('nmlohism', 'his_keycon', ws_key_men,wn_dsp_002);
call labconf.sp_glnewdsp ('nmlohism', 'his_cantid', ws_key_men,wn_dsp_003);
call sp_glnewdsp ('nmlohism', 'his_import', ws_key_men,wn_dsp_004);
call sp_glnewdsp ('nmlohism', 'his_keyper', ws_key_men,wn_dsp_005);
ws_con_ant:='______';
ws_cod_ant:='____';
ws_var_xxx:='HISTORICO DE MOVIMIENTOS';
--	select lis_deslis	into ws_var_xxx from glcolist where lis_keylis = ws_etq_rep;
begin select lis_deslis	into strict ws_var_xxx from labconf.glcolist where lis_keylis = ws_etq_rep;
exception
when no_data_found then
null;
end;
ws_des_lis:= oracle.substr(ws_var_xxx,1,40);
wn_emp_ant:=-1;
for c_nmhismoc in ( select his_keycon, his_keyemp, his_import,his_cantid, his_keyper, his_keypro, his_codimp
from labconf.nmwkhism
where his_idepcc=ws_ide_pcc  order by  7,1,2) loop
ws_key_con :=c_nmhismoc.his_keycon;
wn_key_emp :=c_nmhismoc.his_keyemp;
wn_imp_mov :=c_nmhismoc.his_import;
wn_can_mov :=c_nmhismoc.his_cantid;
ws_key_per :=c_nmhismoc.his_keyper;
wn_key_pro :=c_nmhismoc.his_keypro;
ws_cod_imp :=c_nmhismoc.his_codimp;
--<gsa>
if ws_cod_imp <> ws_cod_ant then
ws_cod_ant := ws_cod_imp;
ws_con_ant := '______';
end if;
--</gsa>
ws_des_con:='CONCEPTO NO EXISTE ..';
if (ws_key_con != ws_con_ant ) then
begin select con_descon	into strict ws_des_con from labconf.nmloconc	where con_keycon=ws_key_con;
exception
when no_data_found then
null;
end;
ws_con_ant:=ws_key_con;
end if;
ws_des_pro:='PROCESO NO EXISTE';
begin select pro_despro	into strict ws_des_pro from labconf.nmloproc	where pro_keypro=wn_key_pro;
exception
when no_data_found then
null;
end;
if (wn_emp_ant!=wn_key_emp ) then
wn_emp_ant:=wn_key_emp;
ws_nom_emp := 'Empleado no existe';
begin select emp_nomemp into strict ws_nom_emp from labconf.nmcoempl where emp_keyemp = wn_key_emp;
exception
when no_data_found then
null;
end;
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
wn_can_mov:=null;
end if;
if (wn_dsp_004=1 ) then
wn_imp_mov:=null;
end if;
if (wn_dsp_005=1 ) then
ws_key_per:=null;
end if;
insert into labconf.glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr017,cry_dec007,cry_chr002,cry_chr018,cry_chr006,cry_dec001,cry_dec002,cry_chr019,cry_chr020,cry_chr021,cry_chr022,cry_chr023,cry_chr028,cry_dat003,cry_chr029,cry_chr024,cry_chr025,cry_chr003,cry_dec008,cry_chr008,cry_chr030)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_key_per,wn_key_emp,ws_nom_emp,ws_key_con,ws_des_con,wn_can_mov,wn_imp_mov,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,ws_fec_act,ws_etq_006,ws_etq_007,ws_etq_008,ws_des_lis,wn_key_pro,ws_des_pro,ws_cod_imp);
/* commit; */
end loop;end;
$body$
language plpgsql
;
