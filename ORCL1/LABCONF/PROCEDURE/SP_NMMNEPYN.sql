create or replace procedure labconf."sp_nmmnepyn"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar, wn_key_pro numeric, ws_des_pro varchar, wn_key_nom numeric, ws_des_nom varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de formulas y mnemonico.
ws_key_mne varchar(16);
ws_key_for varchar(4);
wn_num_ins numeric(5);
ws_ope_uno varchar(16);
ws_ope_dos varchar(16);
ws_res_for varchar(16);
ws_uso_mne varchar(15);
ws_uso_op1 varchar(5);
ws_uso_op2 varchar(5);
ws_uso_res varchar(5);
-- variables para la carga de las descripciones de las etiquetas.
ws_etq_001 varchar(8)  := sp_glgetdsc('nmloform', 'for_keyfor', '........',    null);
ws_etq_002 varchar(40) := sp_glgetdsl('nmloform', 'for_numins', '........',    null);
ws_etq_003 varchar(40) := sp_glgetdsl('nmloenfm', 'enf_de1for', 'DESCRIPCION', null);
ws_etq_004 varchar(8)  := sp_glgetdsc('nmlomnem', 'mne_keynem', 'MNEMONIC',    null);
ws_etq_005 varchar(8)  := sp_glgetdsc('nmlocxpr', 'cxp_keypro', 'PROCESO',     null);
ws_etq_006 varchar(8)  := sp_glgetdsc('nmlocxpr', 'cxp_keynom', 'NOMINA',      null);
ws_des_cor varchar(60);
-- variables para las descrip. de proceso y tipo de nomina y descripcion 1 de la formula.                                                             --
ws_des_for varchar(40);
ws_for_cxp varchar(4);
-- variables para el reporte de avance.
wn_tot_reg numeric(10);
wn_num_reg numeric(10)  := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)   := 1;
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
ws_hor_fin varchar(8);
ws_des_lis varchar(50)    := sp_glgetrep(ws_nom_rep, 'No existe nombre del Reporte', null);
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_nmlstmne record;
cc_nmlstmne record;
ccc_cxp record;
c_desfor record;
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
-- inicializa variables de trabajo para realizar monitoreo.
wn_pct_reg := wn_tot_reg / 10.0;
-- define cursor principal.
for c_nmlstmne in (select mne_keynem
from nmlomnem
where mne_keynem in (select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  mne_keynem) loop
ws_key_mne := c_nmlstmne.mne_keynem;
for cc_nmlstmne in (select distinct cxp_keyfor
from nmlocxpr
where cxp_keypro = wn_key_pro and
cxp_keynom = wn_key_nom) loop
ws_for_cxp := cc_nmlstmne.cxp_keyfor;
for ccc_cxp in (select for_keyfor, for_opera1, for_opera2, for_result, for_numins
from nmloform
where for_keyfor = ws_for_cxp and (for_opera1 = ws_key_mne or
for_opera2 = ws_key_mne or
for_result = ws_key_mne)
order by  for_keyfor, for_numins) loop
ws_key_for := ccc_cxp.for_keyfor;
ws_ope_uno := ccc_cxp.for_opera1;
ws_ope_dos := ccc_cxp.for_opera2;
ws_res_for := ccc_cxp.for_result;
wn_num_ins := ccc_cxp.for_numins;
ws_des_for := 'FORMULA NO EXISTE';
for c_desfor in (select enf_de1for
from nmloenfm
where enf_keyfor = ws_key_for) loop
ws_des_for := c_desfor.enf_de1for;
end loop;
ws_uso_op1 := ' ';
ws_uso_op2 := ' ';
ws_uso_res := ' ';
if ws_ope_uno = ws_key_mne then
ws_uso_op1 := 'OP1';
end if;
if ws_ope_dos = ws_key_mne then
ws_uso_op2 := 'OP2';
end if;
if ws_res_for = ws_key_mne then
ws_uso_res := 'RES';
end if;/* dmap converted statement start */
ws_uso_mne :=  concat(ws_uso_op1, ws_uso_op2 , ws_uso_res) ;/* dmap converted statement end */
wn_tot_reg := wn_tot_reg + 1;
-- inserta en la tabla de trabajo del crystal report.
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr008,
cry_chr017, cry_chr003, cry_chr009, cry_dec006, cry_dec007,
cry_dec008, cry_chr019, cry_chr005, cry_chr006, cry_chr022,
cry_chr023, cry_chr024, cry_chr025, cry_dat001, cry_chr010,
cry_chr004, cry_chr002)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, ws_key_mne,
ws_key_for, ws_des_for, ws_uso_mne, wn_num_ins, wn_key_pro,
wn_key_nom, ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004,
ws_etq_005, ws_etq_006, ws_hor_act, ws_fec_act, ws_des_pro,
ws_des_nom, ws_des_lis);
wn_con_reg := wn_con_reg + 1;
if wn_con_reg = wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
end loop;
-- actualiza registro de monitoreo.
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
