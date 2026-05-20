create or replace procedure labconf."sp_nmlstmne"  (ws_nom_rep varchar,ws_ide_pcc varchar, wn_key_usu numeric ,ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
----------------------------------------------------------------------------
-- sipros, s.a. de c.v.
--
-- sistema  : rh-2000 c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmlstmne
--            reporte de mnemonicos por rangos.
--
-- autor    : joaquin perez m.
-- fecha    : 14 de abril de 1997.
--
-- conversion a oracle : luis f. c�ba s�hez.  30-jun-1998
----------------------------------------------------------------------------
-- modifico 		fecha		     comentario
----------------------------------------------------------------------------
-- roman diaz d. 	marzo del 2001   migracion proy. vb6 hrp
-- variables para la carga de la tabla de mnemonicos.
ws_key_mne glwkcrys.cry_chr008%type;
ws_key_tab glwkcrys.cry_chr017%type;
ws_mne_cam glwkcrys.cry_chr009%type;
ws_mne_con glwkcrys.cry_chr010%type;
ws_tip_dat glwkcrys.cry_chr018%type;
ws_etq_001 glwkcrys.cry_chr003%type := sp_glgetdsl('nmlomnem', 'mne_keynem', '........', null);
ws_etq_002 glwkcrys.cry_chr004%type := sp_glgetdsl('nmlomnem', 'mne_keytab', '........', null);
ws_etq_003 glwkcrys.cry_chr005%type := sp_glgetdsl('nmlomnem', 'mne_keycam', '........', null);
ws_etq_004 glwkcrys.cry_chr006%type := sp_glgetdsl('nmlomnem', 'mne_condic', '........', null);
ws_etq_005 glwkcrys.cry_chr007%type := sp_glgetdsl('nmlomnem', 'mne_tipdat', '........', null);
ws_des_cor glwkcrys.cry_chr001%type;
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10)  := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)   := 1;
ws_hor_act glwkcrys.cry_chr019%type;
ws_fec_act glwkcrys.cry_dat001%type;
ws_des_lis glwkcrys.cry_chr002%type := sp_glgetrep(ws_nom_rep, 'No existe nombre del Reporte', null);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmlstmne record;
begin
call sp_glfechor (ws_fec_act,ws_hor_act);
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor
from glcocorp;
-- realiza el conteo de registros a procesar.
select coalesce(count(*), 0)  into strict wn_tot_reg 	from nmlomnem
where mne_keynem in (
select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null);
insert into glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_fec_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
/* commit; */
-- inicializa variables de trabajo para realizar cortes y monit.
wn_pct_reg := wn_tot_reg / 10.0;
-- define cursor principal.
for c_nmlstmne in (select mne_keynem, mne_keytab, mne_keycam, mne_condic, mne_tipdat
from nmlomnem
where mne_keynem in (select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  mne_keynem) loop
ws_key_mne := c_nmlstmne.mne_keynem;
ws_key_tab := c_nmlstmne.mne_keytab;
ws_mne_cam := c_nmlstmne.mne_keycam;
ws_mne_con := c_nmlstmne.mne_condic;
ws_tip_dat := c_nmlstmne.mne_tipdat;
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= (wn_pct_reg * wn_pct_act) then
update glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = ws_fec_act and
res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008, cry_chr017,
cry_chr009, cry_chr010, cry_chr018, cry_chr019, cry_dat001, cry_chr003,
cry_chr004, cry_chr005, cry_chr006, cry_chr007, cry_chr002)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_mne, ws_key_tab,
ws_mne_cam, ws_mne_con, ws_tip_dat, ws_hor_act, ws_fec_act, ws_etq_001,
ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005, ws_des_lis);
wn_con_reg := wn_con_reg + 1;
if wn_con_reg = wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
call sp_glfechor (ws_fec_act,ws_hor_act);
-- actualiza la tabla de monitoreo indicando la finalizacion del proceso.
update glcoresu
set res_numreg = wn_num_reg,
res_fecfin = ws_fec_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = ws_fec_act and
res_horreg = ws_hor_reg;
/* commit; */
end;
$body$
language plpgsql
;
