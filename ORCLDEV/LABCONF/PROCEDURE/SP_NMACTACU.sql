create or replace procedure labconf."sp_nmactacu"  (ws_nom_rep varchar,ws_ide_pcc varchar,wn_key_usu numeric,ws_key_men varchar,ws_hor_reg varchar,wn_key_pro numeric,ws_acu_uno varchar,ws_acu_dos varchar,ws_acu_tre varchar,ws_acu_cua varchar,ws_acu_cin varchar,ws_acu_sei varchar,ws_acu_sie varchar,ws_acu_och varchar,ws_acu_nue varchar,ws_acu_die varchar,ws_acu_onc varchar,ws_acu_doc varchar,ws_acu_trc varchar,ws_per_ini varchar,ws_per_fin varchar,ws_cod_acu varchar,wn_che_eli numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp numeric(10);
wn_aux_emp numeric(10);
ws_key_con varchar(3);
ws_set_eli varchar(500);
wn_key_per varchar(7);
wn_can_tid decimal(12,2);
wn_imp_ort decimal(12,2);
his_key_con varchar(3);
his_key_per varchar(7);
his_cod_acu varchar(2);
his_can_tid decimal(12,2);
his_imp_ort decimal(12,2);
acu_uni_uno decimal(12,2);
acu_uni_dos decimal(12,2);
acu_uni_tre decimal(12,2);
acu_uni_cua decimal(12,2);
acu_uni_cin decimal(12,2);
acu_uni_sei decimal(12,2);
acu_uni_sie decimal(12,2);
acu_uni_och decimal(12,2);
acu_uni_nue decimal(12,2);
acu_uni_die decimal(12,2);
acu_uni_onc decimal(12,2);
acu_uni_doc decimal(12,2);
acu_uni_trc decimal(12,2);
acu_uni_cat decimal(12,2);
acu_uni_qui decimal(12,2);
acu_imp_uno decimal(12,2);
acu_imp_dos decimal(12,2);
acu_imp_tre decimal(12,2);
acu_imp_cua decimal(12,2);
acu_imp_cin decimal(12,2);
acu_imp_sei decimal(12,2);
acu_imp_sie decimal(12,2);
acu_imp_och decimal(12,2);
acu_imp_nue decimal(12,2);
acu_imp_die decimal(12,2);
acu_imp_onc decimal(12,2);
acu_imp_doc decimal(12,2);
acu_imp_trc decimal(12,2);
acu_imp_cat decimal(12,2);
acu_imp_qui decimal(12,2);
wn_uni_uno decimal(12,2);
wn_uni_dos decimal(12,2);
wn_uni_tre decimal(12,2);
wn_uni_cua decimal(12,2);
wn_uni_cin decimal(12,2);
wn_uni_sei decimal(12,2);
wn_uni_sie decimal(12,2);
wn_uni_och decimal(12,2);
wn_uni_nue decimal(12,2);
wn_uni_die decimal(12,2);
wn_uni_onc decimal(12,2);
wn_uni_doc decimal(12,2);
wn_uni_trc decimal(12,2);
wn_imp_uno decimal(12,2);
wn_imp_dos decimal(12,2);
wn_imp_tre decimal(12,2);
wn_imp_cua decimal(12,2);
wn_imp_cin decimal(12,2);
wn_imp_sei decimal(12,2);
wn_imp_sie decimal(12,2);
wn_imp_och decimal(12,2);
wn_imp_nue decimal(12,2);
wn_imp_die decimal(12,2);
wn_imp_onc decimal(12,2);
wn_imp_doc decimal(12,2);
wn_imp_trc decimal(12,2);
ban_der_pri numeric(5);
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(12,2);
wn_pct_act numeric(10);
ws_hor_act varchar(8);
wd_fec_act timestamp(0);
wn_num_tem numeric(10);
q_actualiza record;
q_empleados record;
q_act record;
begin
begin select  count(* ) alias1
into strict wn_tot_reg from nmcoempl
where emp_keyemp in (
select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null );
exception
when no_data_found then
null;
end;
call sp_glfechor (wd_fec_act, ws_hor_act);
insert into glcoresu( res_idepro,res_idepcc,res_keyusu,res_fecini,res_horini,res_horreg,res_totreg,res_status)
values (ws_nom_rep,ws_ide_pcc,wn_key_usu,wd_fec_act,ws_hor_act,ws_hor_reg,wn_tot_reg,'P'); /* commit; */
wn_num_reg:=0;
wn_pct_act:=1;
wn_pct_reg:=(wn_tot_reg/10.0);
ws_set_eli:= null;
if (wn_che_eli=1 ) then
for q_actualiza in ( select acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keycon, acu_keyemp from nmloacum
where acu_keyemp in (
select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null )
and acu_keycon in (
select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and acu_keypro = wn_key_pro
order by  acu_keyemp ) loop
wn_uni_uno :=q_actualiza.acu_uniuno;
wn_imp_uno :=q_actualiza.acu_impuno;
wn_uni_dos :=q_actualiza.acu_unidos;
wn_imp_dos :=q_actualiza.acu_impdos;
wn_uni_tre :=q_actualiza.acu_unitre;
wn_imp_tre :=q_actualiza.acu_imptre;
wn_uni_cua :=q_actualiza.acu_unicua;
wn_imp_cua :=q_actualiza.acu_impcua;
wn_uni_cin :=q_actualiza.acu_unicin;
wn_imp_cin :=q_actualiza.acu_impcin;
wn_uni_sei :=q_actualiza.acu_unisei;
wn_imp_sei :=q_actualiza.acu_impsei;
wn_uni_sie :=q_actualiza.acu_unisie;
wn_imp_sie :=q_actualiza.acu_impsie;
wn_uni_och :=q_actualiza.acu_unioch;
wn_imp_och :=q_actualiza.acu_impoch;
wn_uni_nue :=q_actualiza.acu_uninue;
wn_imp_nue :=q_actualiza.acu_impnue;
wn_uni_die :=q_actualiza.acu_unidie;
wn_imp_die :=q_actualiza.acu_impdie;
wn_uni_onc :=q_actualiza.acu_unionc;
wn_imp_onc :=q_actualiza.acu_imponc;
wn_uni_doc :=q_actualiza.acu_unidoc;
wn_imp_doc :=q_actualiza.acu_impdoc;
wn_uni_trc :=q_actualiza.acu_unitrc;
wn_imp_trc :=q_actualiza.acu_imptrc;
ws_key_con :=q_actualiza.acu_keycon;
wn_key_emp :=q_actualiza.acu_keyemp;
if (ws_acu_uno='S' ) then
wn_uni_uno:=0;
wn_imp_uno:=0;
end if;
if (ws_acu_dos='S' ) then
wn_uni_dos:=0;
wn_imp_dos:=0;
end if;
if (ws_acu_tre='S' ) then
wn_uni_tre:=0;
wn_imp_tre:=0;
end if;
if (ws_acu_cua='S' ) then
wn_uni_cua:=0;
wn_imp_cua:=0;
end if;
if (ws_acu_cin='S' ) then
wn_uni_cin:=0;
wn_imp_cin:=0;
end if;
if (ws_acu_sei='S' ) then
wn_uni_sei:=0;
wn_imp_sei:=0;
end if;
if (ws_acu_sie='S' ) then
wn_uni_sie:=0;
wn_imp_sie:=0;
end if;
if (ws_acu_och='S' ) then
wn_uni_och:=0;
wn_imp_och:=0;
end if;
if (ws_acu_nue='S' ) then
wn_uni_nue:=0;
wn_imp_nue:=0;
end if;
if (ws_acu_die='S' ) then
wn_uni_die:=0;
wn_imp_die:=0;
end if;
if (ws_acu_onc='S' ) then
wn_uni_onc:=0;
wn_imp_onc:=0;
end if;
if (ws_acu_doc='S' ) then
wn_uni_doc:=0;
wn_imp_doc:=0;
end if;
if (ws_acu_trc='S' ) then
wn_uni_trc:=0;
wn_imp_trc:=0;
end if;
update nmloacum set acu_uniuno=wn_uni_uno,acu_unidos=wn_uni_dos,acu_unitre=wn_uni_tre,acu_unicua=wn_uni_cua,acu_unicin=wn_uni_cin,acu_unisei=wn_uni_sei,acu_unisie=wn_uni_sie,acu_unioch=wn_uni_och,acu_uninue=wn_uni_nue,acu_unidie=wn_uni_die,acu_unionc=wn_uni_onc,acu_unidoc=wn_uni_doc,acu_unitrc=wn_uni_trc,acu_impuno=wn_imp_uno,acu_impdos=wn_imp_dos,acu_imptre=wn_imp_tre,acu_impcua=wn_imp_cua,acu_impcin=wn_imp_cin,acu_impsei=wn_imp_sei,acu_impsie=wn_imp_sie,acu_impoch=wn_imp_och,acu_impnue=wn_imp_nue,acu_impdie=wn_imp_die,acu_imponc=wn_imp_onc,acu_impdoc=wn_imp_doc,acu_imptrc=wn_imp_trc
where acu_keycon = ws_key_con
and acu_keyemp = wn_key_emp
and acu_keypro = wn_key_pro; /* commit; */
end loop;
ws_key_con:='*';
wn_key_emp:=0;
end if;
for q_empleados in ( select emp_keyemp from nmcoempl
where emp_keyemp in (
select ran_keyemp from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyemp::text, '') is not null ) ) loop
wn_key_emp :=q_empleados.emp_keyemp;
wn_num_reg:=(wn_num_reg+1);
wn_num_tem:=(wn_pct_reg*wn_pct_act);
if (wn_num_reg>=wn_num_tem ) then
update glcoresu set res_numreg=wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
wn_pct_act:=(wn_pct_act+1);
end if;
wn_can_tid:=0;
wn_imp_ort:=0;
ban_der_pri:=0;
ws_key_con:='*';
his_key_con:= null;
acu_imp_uno:=0;
acu_uni_uno:=0;
acu_imp_dos:=0;
acu_uni_dos:=0;
acu_imp_tre:=0;
acu_uni_tre:=0;
acu_imp_cua:=0;
acu_uni_cua:=0;
acu_imp_cin:=0;
acu_uni_cin:=0;
acu_imp_sei:=0;
acu_uni_sei:=0;
acu_imp_sie:=0;
acu_uni_sie:=0;
acu_imp_och:=0;
acu_uni_och:=0;
acu_imp_nue:=0;
acu_uni_nue:=0;
acu_imp_die:=0;
acu_uni_die:=0;
acu_imp_onc:=0;
acu_uni_onc:=0;
acu_imp_doc:=0;
acu_uni_doc:=0;
acu_imp_trc:=0;
acu_uni_trc:=0;
acu_uni_cat:=0;
acu_imp_cat:=0;
acu_uni_qui:=0;
acu_imp_qui:=0;
for q_act in ( select his_keycon, his_keyper, his_cantid, his_import from nmlohism
where his_keycon in (
select ran_keycon from glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keycon::text, '') is not null )
and his_keyper between ws_per_ini and ws_per_fin
and his_keyemp = wn_key_emp
and his_codacu = ws_cod_acu
and his_keypro = wn_key_pro
order by  his_keycon ) loop
his_key_con :=q_act.his_keycon;
his_key_per :=q_act.his_keyper;
his_can_tid :=q_act.his_cantid;
his_imp_ort :=q_act.his_import;
if (ban_der_pri=0) then
ws_key_con:=his_key_con;
wn_key_per:=his_key_per;
ban_der_pri:=1;
end if;
if (ws_key_con != his_key_con ) then
wn_aux_emp:=0;
begin select acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keyemp
into strict wn_uni_uno, wn_imp_uno, wn_uni_dos, wn_imp_dos, wn_uni_tre, wn_imp_tre, wn_uni_cua, wn_imp_cua, wn_uni_cin, wn_imp_cin, wn_uni_sei, wn_imp_sei, wn_uni_sie, wn_imp_sie, wn_uni_och, wn_imp_och, wn_uni_nue, wn_imp_nue, wn_uni_die, wn_imp_die, wn_uni_onc, wn_imp_onc, wn_uni_doc, wn_imp_doc, wn_uni_trc, wn_imp_trc, wn_aux_emp from nmloacum
where acu_keyemp = wn_key_emp
and acu_keycon = ws_key_con
and acu_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
if ((wn_aux_emp =0) or (nullif(wn_aux_emp::text, '') is null) ) then
insert into nmloacum( acu_keyemp,acu_keycon,acu_keypro,acu_uniuno,acu_impuno,acu_unidos,acu_impdos,acu_unitre,acu_imptre,acu_unicua,acu_impcua,acu_unicin,acu_impcin,acu_unisei,acu_impsei,acu_unisie,acu_impsie,acu_unioch,acu_impoch,acu_uninue,acu_impnue,acu_unidie,acu_impdie,acu_unionc,acu_imponc,acu_unidoc,acu_impdoc,acu_unitrc,acu_imptrc,acu_unicat,acu_impcat,acu_uniqui,acu_impqui)
values (wn_key_emp,ws_key_con,wn_key_pro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); /* commit; */
end if;
if (ws_acu_uno='S' ) then
wn_uni_uno:=acu_uni_uno;
wn_imp_uno:=acu_imp_uno;
end if;
if (ws_acu_dos='S' ) then
wn_uni_dos:=acu_uni_dos;
wn_imp_dos:=acu_imp_dos;
end if;
if (ws_acu_tre='S' ) then
wn_uni_tre:=acu_uni_tre;
wn_imp_tre:=acu_imp_tre;
end if;
if (ws_acu_cua='S' ) then
wn_uni_cua:=acu_uni_cua;
wn_imp_cua:=acu_imp_cua;
end if;
if (ws_acu_cin='S' ) then
wn_uni_cin:=acu_uni_cin;
wn_imp_cin:=acu_imp_cin;
end if;
if (ws_acu_sei='S' ) then
wn_uni_sei:=acu_uni_sei;
wn_imp_sei:=acu_imp_sei;
end if;
if (ws_acu_sie='S' ) then
wn_uni_sie:=acu_uni_sie;
wn_imp_sie:=acu_imp_sie;
end if;
if (ws_acu_och='S' ) then
wn_uni_och:=acu_uni_och;
wn_imp_och:=acu_imp_och;
end if;
if (ws_acu_nue='S' ) then
wn_uni_nue:=acu_uni_nue;
wn_imp_nue:=acu_imp_nue;
end if;
if (ws_acu_die='S' ) then
wn_uni_die:=acu_uni_die;
wn_imp_die:=acu_imp_die;
end if;
if (ws_acu_onc='S' ) then
wn_uni_onc:=acu_uni_onc;
wn_imp_onc:=acu_imp_onc;
end if;
if (ws_acu_doc='S' ) then
wn_uni_doc:=acu_uni_doc;
wn_imp_doc:=acu_imp_doc;
end if;
if (ws_acu_trc='S' ) then
wn_uni_trc:=acu_uni_trc;
wn_imp_trc:=acu_imp_trc;
end if;
update nmloacum set acu_uniuno=wn_uni_uno,acu_unidos=wn_uni_dos,acu_unitre=wn_uni_tre,acu_unicua=wn_uni_cua,acu_unicin=wn_uni_cin,acu_unisei=wn_uni_sei,acu_unisie=wn_uni_sie,acu_unioch=wn_uni_och,acu_uninue=wn_uni_nue,acu_unidie=wn_uni_die,acu_unionc=wn_uni_onc,acu_unidoc=wn_uni_doc,acu_impuno=wn_imp_uno,acu_impdos=wn_imp_dos,acu_imptre=wn_imp_tre,acu_impcua=wn_imp_cua,acu_impcin=wn_imp_cin,acu_impsei=wn_imp_sei,acu_impsie=wn_imp_sie,acu_impoch=wn_imp_och,acu_impnue=wn_imp_nue,acu_impdie=wn_imp_die,acu_imponc=wn_imp_onc,acu_impdoc=wn_imp_doc,acu_imptrc=wn_imp_trc
where acu_keyemp = wn_key_emp
and acu_keycon = ws_key_con
and acu_keypro = wn_key_pro; /* commit; */
acu_imp_uno:=0;
acu_uni_uno:=0;
acu_imp_dos:=0;
acu_uni_dos:=0;
acu_imp_tre:=0;
acu_uni_tre:=0;
acu_imp_cua:=0;
acu_uni_cua:=0;
acu_imp_cin:=0;
acu_uni_cin:=0;
acu_imp_sei:=0;
acu_uni_sei:=0;
acu_imp_sie:=0;
acu_uni_sie:=0;
acu_imp_och:=0;
acu_uni_och:=0;
acu_imp_nue:=0;
acu_uni_nue:=0;
acu_imp_die:=0;
acu_uni_die:=0;
acu_imp_onc:=0;
acu_uni_onc:=0;
acu_imp_doc:=0;
acu_uni_doc:=0;
acu_imp_trc:=0;
acu_uni_trc:=0;
acu_imp_cat:=0;
acu_imp_cat:=0;
acu_uni_qui:=0;
acu_uni_qui:=0;
wn_can_tid:=his_can_tid;
wn_imp_ort:=his_imp_ort;
ws_key_con:=his_key_con;
wn_key_per:=his_key_per;
call sp_ubicames (ws_cod_acu, wn_can_tid, wn_imp_ort, wn_key_pro, wn_key_per, acu_uni_uno, acu_uni_dos, acu_uni_tre, acu_uni_cua, acu_uni_cin, acu_uni_sei, acu_uni_sie, acu_uni_och, acu_uni_nue, acu_uni_die, acu_uni_onc, acu_uni_doc, acu_uni_trc, acu_uni_cat, acu_uni_qui, acu_imp_uno, acu_imp_dos, acu_imp_tre, acu_imp_cua, acu_imp_cin, acu_imp_sei, acu_imp_sie, acu_imp_och, acu_imp_nue, acu_imp_die, acu_imp_onc, acu_imp_doc, acu_imp_trc, acu_imp_cat, acu_imp_qui,acu_uni_uno , acu_uni_dos , acu_uni_tre , acu_uni_cua , acu_uni_cin , acu_uni_sei , acu_uni_sie , acu_uni_och , acu_uni_nue , acu_uni_die , acu_uni_onc , acu_uni_doc , acu_uni_trc , acu_uni_cat , acu_uni_qui , acu_imp_uno , acu_imp_dos , acu_imp_tre , acu_imp_cua , acu_imp_cin , acu_imp_sei , acu_imp_sie , acu_imp_och , acu_imp_nue , acu_imp_die , acu_imp_onc , acu_imp_doc , acu_imp_trc , acu_imp_cat , acu_imp_qui );
else
wn_can_tid:=his_can_tid;
wn_imp_ort:=his_imp_ort;
wn_key_per:=his_key_per;
call sp_ubicames (ws_cod_acu, wn_can_tid, wn_imp_ort, wn_key_pro, wn_key_per, acu_uni_uno, acu_uni_dos, acu_uni_tre, acu_uni_cua, acu_uni_cin, acu_uni_sei, acu_uni_sie, acu_uni_och, acu_uni_nue, acu_uni_die, acu_uni_onc, acu_uni_doc, acu_uni_trc, acu_uni_cat, acu_uni_qui, acu_imp_uno, acu_imp_dos, acu_imp_tre, acu_imp_cua, acu_imp_cin, acu_imp_sei, acu_imp_sie, acu_imp_och, acu_imp_nue, acu_imp_die, acu_imp_onc, acu_imp_doc, acu_imp_trc, acu_imp_cat, acu_imp_qui,acu_uni_uno , acu_uni_dos , acu_uni_tre , acu_uni_cua , acu_uni_cin , acu_uni_sei , acu_uni_sie , acu_uni_och , acu_uni_nue , acu_uni_die , acu_uni_onc , acu_uni_doc , acu_uni_trc , acu_uni_cat , acu_uni_qui , acu_imp_uno , acu_imp_dos , acu_imp_tre , acu_imp_cua , acu_imp_cin , acu_imp_sei , acu_imp_sie , acu_imp_och , acu_imp_nue , acu_imp_die , acu_imp_onc , acu_imp_doc , acu_imp_trc , acu_imp_cat , acu_imp_qui );
end if;
end loop;
if (ws_key_con != '*' ) then
wn_aux_emp:=0;
begin select acu_uniuno, acu_impuno, acu_unidos, acu_impdos, acu_unitre, acu_imptre, acu_unicua, acu_impcua, acu_unicin, acu_impcin, acu_unisei, acu_impsei, acu_unisie, acu_impsie, acu_unioch, acu_impoch, acu_uninue, acu_impnue, acu_unidie, acu_impdie, acu_unionc, acu_imponc, acu_unidoc, acu_impdoc, acu_unitrc, acu_imptrc, acu_keyemp
into strict wn_uni_uno, wn_imp_uno, wn_uni_dos, wn_imp_dos, wn_uni_tre, wn_imp_tre, wn_uni_cua, wn_imp_cua, wn_uni_cin, wn_imp_cin, wn_uni_sei, wn_imp_sei, wn_uni_sie, wn_imp_sie, wn_uni_och, wn_imp_och, wn_uni_nue, wn_imp_nue, wn_uni_die, wn_imp_die, wn_uni_onc, wn_imp_onc, wn_uni_doc, wn_imp_doc, wn_uni_trc, wn_imp_trc, wn_aux_emp from nmloacum
where acu_keyemp = wn_key_emp
and acu_keycon = ws_key_con
and acu_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
if ((wn_aux_emp =0) or (nullif(wn_aux_emp::text, '') is null) ) then
insert into nmloacum( acu_keyemp,acu_keycon,acu_keypro,acu_uniuno,acu_impuno,acu_unidos,acu_impdos,acu_unitre,acu_imptre,acu_unicua,acu_impcua,acu_unicin,acu_impcin,acu_unisei,acu_impsei,acu_unisie,acu_impsie,acu_unioch,acu_impoch,acu_uninue,acu_impnue,acu_unidie,acu_impdie,acu_unionc,acu_imponc,acu_unidoc,acu_impdoc,acu_unitrc,acu_imptrc,acu_unicat,acu_impcat,acu_uniqui,acu_impqui)
values (wn_key_emp,ws_key_con,wn_key_pro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); /* commit; */
end if;
wn_uni_uno:=0;
wn_imp_uno:=0;
wn_uni_dos:=0;
wn_imp_dos:=0;
wn_uni_tre:=0;
wn_imp_tre:=0;
wn_uni_cua:=0;
wn_imp_cua:=0;
wn_uni_cin:=0;
wn_imp_cin:=0;
wn_uni_sei:=0;
wn_imp_sei:=0;
wn_uni_sie:=0;
wn_imp_sie:=0;
wn_uni_och:=0;
wn_imp_och:=0;
wn_uni_nue:=0;
wn_imp_nue:=0;
wn_uni_die:=0;
wn_imp_die:=0;
wn_uni_onc:=0;
wn_imp_onc:=0;
wn_uni_doc:=0;
wn_imp_doc:=0;
wn_uni_trc:=0;
wn_imp_trc:=0;
begin select acu_uniuno, acu_unidos, acu_unitre, acu_unicua, acu_unicin, acu_unisei, acu_unisie, acu_unioch, acu_uninue, acu_unidie, acu_unionc, acu_unidoc, acu_impuno, acu_impdos, acu_imptre, acu_impcua, acu_impcin, acu_impsei, acu_impsie, acu_impoch, acu_impnue, acu_impdie, acu_imponc, acu_impdoc, acu_imptrc
into strict wn_uni_uno, wn_uni_dos, wn_uni_tre, wn_uni_cua, wn_uni_cin, wn_uni_sei, wn_uni_sie, wn_uni_och, wn_uni_nue, wn_uni_die, wn_uni_onc, wn_uni_doc, wn_imp_uno, wn_imp_dos, wn_imp_tre, wn_imp_cua, wn_imp_cin, wn_imp_sei, wn_imp_sie, wn_imp_och, wn_imp_nue, wn_imp_die, wn_imp_onc, wn_imp_doc, wn_imp_trc from nmloacum
where acu_keyemp = wn_key_emp
and acu_keycon = ws_key_con
and acu_keypro = wn_key_pro;
exception
when no_data_found then
null;
end;
if (ws_acu_uno='S' ) then
wn_uni_uno:=acu_uni_uno;
wn_imp_uno:=acu_imp_uno;
end if;
if (ws_acu_dos='S' ) then
wn_uni_dos:=acu_uni_dos;
wn_imp_dos:=acu_imp_dos;
end if;
if (ws_acu_tre='S' ) then
wn_uni_tre:=acu_uni_tre;
wn_imp_tre:=acu_imp_tre;
end if;
if (ws_acu_cua='S' ) then
wn_uni_cua:=acu_uni_cua;
wn_imp_cua:=acu_imp_cua;
end if;
if (ws_acu_cin='S' ) then
wn_uni_cin:=acu_uni_cin;
wn_imp_cin:=acu_imp_cin;
end if;
if (ws_acu_sei='S' ) then
wn_uni_sei:=acu_uni_sei;
wn_imp_sei:=acu_imp_sei;
end if;
if (ws_acu_sie='S' ) then
wn_uni_sie:=acu_uni_sie;
wn_imp_sie:=acu_imp_sie;
end if;
if (ws_acu_och='S' ) then
wn_uni_och:=acu_uni_och;
wn_imp_och:=acu_imp_och;
end if;
if (ws_acu_nue='S' ) then
wn_uni_nue:=acu_uni_nue;
wn_imp_nue:=acu_imp_nue;
end if;
if (ws_acu_die='S' ) then
wn_uni_die:=acu_uni_die;
wn_imp_die:=acu_imp_die;
end if;
if (ws_acu_onc='S' ) then
wn_uni_onc:=acu_uni_onc;
wn_imp_onc:=acu_imp_onc;
end if;
if (ws_acu_doc='S' ) then
wn_uni_doc:=acu_uni_doc;
wn_imp_doc:=acu_imp_doc;
end if;
if (ws_acu_trc='S' ) then
wn_uni_trc:=acu_uni_trc;
wn_imp_trc:=acu_imp_trc;
end if;
update nmloacum set acu_uniuno=wn_uni_uno,acu_impuno=wn_imp_uno,acu_unidos=wn_uni_dos,acu_impdos=wn_imp_dos,acu_unitre=wn_uni_tre,acu_imptre=wn_imp_tre,acu_unicua=wn_uni_cua,acu_impcua=wn_imp_cua,acu_unicin=wn_uni_cin,acu_impcin=wn_imp_cin,acu_unisei=wn_uni_sei,acu_impsei=wn_imp_sei,acu_unisie=wn_uni_sie,acu_impsie=wn_imp_sie,acu_unioch=wn_uni_och,acu_impoch=wn_imp_och,acu_uninue=wn_uni_nue,acu_impnue=wn_imp_nue,acu_unidie=wn_uni_die,acu_impdie=wn_imp_die,acu_unionc=wn_uni_onc,acu_imponc=wn_imp_onc,acu_unidoc=wn_uni_doc,acu_impdoc=wn_imp_doc,acu_unitrc=wn_uni_trc,acu_imptrc=wn_imp_trc
where acu_keyemp = wn_key_emp
and acu_keycon = ws_key_con
and acu_keypro = wn_key_pro; /* commit; */
end if;
end loop;
call sp_glfechor (wd_fec_act, ws_hor_act);
update glcoresu set res_numreg=wn_num_reg,res_fecfin=wd_fec_act,res_horfin=ws_hor_act,res_status='T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg; /* commit; */
end;
$body$
language plpgsql
;
