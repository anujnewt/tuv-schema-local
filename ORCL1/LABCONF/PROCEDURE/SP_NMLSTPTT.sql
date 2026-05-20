create or replace procedure labconf."sp_nmlstptt"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_pam_key varchar(4);
ws_pam_cve varchar(6);
ws_pam_nom varchar(50);
ws_pam_ini varchar(16);
ws_pam_fin varchar(16);
ws_des_key varchar(40);
ws_des_cve varchar(40);
ws_des_nom varchar(60);
ws_des_ini varchar(40);
ws_des_fin varchar(40);
ws_des_cor varchar(60);
ws_tab_ant varchar(4);
ws_des_lis varchar(50);
ws_key_cam varchar(10);
ws_des_etq varchar(10);
ws_etq_001 varchar(10);
ws_etq_002 varchar(10);
ws_etq_003 varchar(10);
ws_etq_004 varchar(10);
ws_etq_005 varchar(10);
ws_etq_006 varchar(40);
ws_etq_007 varchar(40);
ws_dsp_cam varchar(20);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_dia_act timestamp(0);
wn_num_tem numeric(10);
c_etiqueta record;
c_nmlstptt record;
begin
select  count(* ) alias1
into strict wn_tot_reg from glcopams
where pam_keypar in (
select pam_folini from glcopams
where pam_keypar='00')
and pam_keypar in (
select ran_keypue from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keypue::text, '') is not null );
call sp_glfechor (ws_dia_act, ws_hor_act);
insert into glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_dia_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
delete from glwkcrys
where cry_nomrep=ws_nom_rep
and cry_idepcc=ws_ide_pcc
and cry_keyusu=wn_key_usu; /* commit; */
ws_des_cor:='CORPORATIVO NO REGISTRADO';
select cor_razsoc
into strict ws_des_cor from glcocorp;
ws_des_lis:='No existe nombre del Reporte';
select lis_deslis
into strict ws_des_lis from glcolist
where lis_keylis=ws_nom_rep;
ws_etq_001:='........';
ws_etq_002:='........';
ws_etq_003:='........';
ws_etq_004:='........';
ws_etq_005:='........';
for c_etiqueta in ( select cam_keycam, cam_descor from glcocamp
where cam_keytab='glcopams' ) loop
ws_key_cam :=c_etiqueta.cam_keycam;
ws_des_etq :=c_etiqueta.cam_descor;
if (ws_key_cam='pam_keypar' ) then
ws_etq_001:=ws_des_etq;
else
if (ws_key_cam='pam_cvesec' ) then
ws_etq_002:=ws_des_etq;
else
if (ws_key_cam='pam_nompar' ) then
ws_etq_003:=ws_des_etq;
else
if (ws_key_cam='pam_folini' ) then
ws_etq_004:=ws_des_etq;
else
if (ws_key_cam='pam_folfin' ) then
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
call sp_glnewdsp ('glcopams', 'pam_keypar', ws_key_men,wn_dsp_001);
call sp_glnewdsp ('glcopams', 'pam_cvesec', ws_key_men,wn_dsp_002);
call sp_glnewdsp ('glcopams', 'pam_nompar', ws_key_men,wn_dsp_003);
call sp_glnewdsp ('glcopams', 'pam_folini', ws_key_men,wn_dsp_004);
call sp_glnewdsp ('glcopams', 'pam_folfin', ws_key_men,wn_dsp_005);
ws_tab_ant:='______';
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10.0);
ws_etq_006:='Nada';
for c_nmlstptt in ( select pam_keypar, pam_cvesec, pam_nompar, pam_folini, pam_folfin from glcopams
where pam_keypar in (
select pam_folini from glcopams
where pam_keypar='00')
and pam_keypar in (
select ran_keypue from glwkrang
where ran_nomrep=ws_nom_rep
and ran_idepcc=ws_ide_pcc
and ran_keyusu=wn_key_usu
and nullif(ran_keypue::text, '') is not null )
order by  pam_keypar,pam_cvesec ) loop
ws_pam_key :=c_nmlstptt.pam_keypar;
ws_pam_cve :=c_nmlstptt.pam_cvesec;
ws_pam_nom :=c_nmlstptt.pam_nompar;
ws_pam_ini :=c_nmlstptt.pam_folini;
ws_pam_fin :=c_nmlstptt.pam_folfin;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update glcoresu set res_numreg=wn_num_reg
where res_idepro=ws_nom_rep
and res_idepcc=ws_ide_pcc
and res_fecini=ws_dia_act
and res_keyusu=wn_key_usu
and res_horreg=ws_hor_reg; /* commit; */
end if;
if (nullif(ws_pam_key::text, '') is null ) then
ws_etq_006:='No Existe Nombre ..';
ws_etq_007:=0;
else
if (ws_tab_ant!=ws_pam_key ) then
ws_etq_006:='No Existe Nombre ..';
ws_etq_007:=0;
select pam_nompar, pam_cvesec
into strict ws_etq_006, ws_etq_007 from glcopams
where pam_keypar ='00'
and pam_folini=ws_pam_key;
ws_tab_ant:=ws_pam_key;
end if;
end if;
if (wn_dsp_001=1 ) then
ws_pam_key:=null;
end if;
if (wn_dsp_002=1 ) then
ws_pam_cve:=null;
end if;
if (wn_dsp_003=1 ) then
ws_pam_nom:=null;
end if;
if (wn_dsp_004=1 ) then
ws_pam_ini:=null;
end if;
if (wn_dsp_005=1 ) then
ws_pam_fin:=null;
end if;
insert into glwkcrys( cry_nomrep,cry_idepcc,cry_keyusu,cry_chr001,cry_chr002,cry_chr015,cry_chr004,cry_chr005,cry_chr006,cry_chr007,cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_chr012,cry_chr013,cry_dat001,cry_chr014,cry_chr003)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,ws_des_cor,ws_pam_key,ws_pam_cve,ws_pam_nom,ws_pam_ini,ws_pam_fin,ws_etq_006,ws_etq_001,ws_etq_002,ws_etq_003,ws_etq_004,ws_etq_005,ws_hor_act,ws_dia_act,ws_etq_007,ws_des_lis); /* commit; */
end loop;
call sp_glfechor (ws_dia_act, ws_hor_act);
update glcoresu set res_numreg=wn_num_reg,res_fecfin=ws_dia_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro=ws_nom_rep
and res_idepcc=ws_ide_pcc
and res_keyusu=wn_key_usu
and res_fecini=ws_dia_act
and res_horreg=ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
