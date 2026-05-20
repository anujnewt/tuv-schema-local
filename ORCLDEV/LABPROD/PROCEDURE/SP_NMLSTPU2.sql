create or replace procedure labprod."sp_nmlstpu2"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de las descripciones de las etiquetas.
ws_key_est varchar(3)  := '???';
ws_sue_ant varchar(4)  := '????';
ws_pue_ant varchar(16) := '????';
ws_key_cam varchar(20);
ws_key_tab varchar(4);
ws_fol_ini varchar(16);
ws_tab_are varchar(4);
ws_tab_sub varchar(4);
ws_des_etq varchar(8);
-- variables para el reporte de avance.
wn_tot_reg numeric(10) := -1;
wn_num_reg numeric(10) := 0;
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5)  := 1;
ws_des_cor glwkcrys.cry_chr001%type;
ws_des_sue glwkcrys.cry_chr003%type;
ws_des_grp glwkcrys.cry_chr004%type;
ws_des_sub glwkcrys.cry_chr005%type;
ws_des_lis glwkcrys.cry_chr002%type := sp_glgetrep(ws_nom_rep, 'No existe Nombre del Reporte ...', null);
ws_key_sue glwkcrys.cry_chr036%type;
wn_tot_per glwkcrys.cry_dec006%type := 0;
ws_des_zon glwkcrys.cry_chr007%type;
ws_etq_001 glwkcrys.cry_chr013%type := sp_glgetdsl('nmlotabs', 'tab_keysue', '........', 16);
ws_etq_002 glwkcrys.cry_chr021%type := sp_glgetdsl('nmcopues', 'pue_grppue', '........', 8);
ws_etq_003 glwkcrys.cry_chr022%type := sp_glgetdsl('nmcopues', 'pue_keypue', '........', 8);
ws_etq_004 glwkcrys.cry_chr023%type := sp_glgetdsl('nmcopues', 'pue_despue', '........', 8);
ws_etq_005 glwkcrys.cry_chr024%type := 'Personal';
ws_etq_006 glwkcrys.cry_chr025%type := sp_glgetdsl('nmlotabs', 'tab_sueniv', '........', 8);
ws_etq_007 glwkcrys.cry_chr014%type := sp_glgetdsl('nmlotabs', 'tab_cobert', '........', 16);
ws_etq_008 glwkcrys.cry_chr027%type := sp_glgetdsl('nmlotabs', 'tab_tiptab', '........', 8);
ws_etq_009 glwkcrys.cry_chr015%type := sp_glgetdsl('nmlotabs', 'tab_feccad', '........', 16);
ws_etq_010 glwkcrys.cry_chr029%type := sp_glgetdsl('nmlotabs', 'tab_subniv', '........', 8);
ws_etq_011 glwkcrys.cry_chr030%type := sp_glgetdsl('nmcopues', 'pue_subgrp', '........', 8);
ws_etq_min glwkcrys.cry_chr037%type;
ws_etq_1qa glwkcrys.cry_chr009%type;
ws_etq_med glwkcrys.cry_chr010%type;
ws_etq_3qa glwkcrys.cry_chr011%type;
ws_etq_max glwkcrys.cry_chr038%type;
wd_fec_act glwkcrys.cry_dat001%type;
ws_hor_act glwkcrys.cry_chr017%type;
wn_con_reg numeric(3) := 0;
wn_lim_ite numeric(3) := 100;
c_operat record;
c_nmlstpue record;
c_dessue record;
c_desare record;
c_dessub record;
begin
-- descripci? coorporativo
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
select cor_razsoc into strict ws_des_cor	from glcocorp;
-- fecha y hora
call sp_glfechor (wd_fec_act,ws_hor_act);
-- opcis
select pam_folini into strict ws_key_tab from glcopams
where pam_keypar = '00' and
pam_cvesec = 'abcpue';
select pam_folini into strict ws_fol_ini from glcopams
where pam_keypar = (	select pam_folini from glcopams
where pam_keypar = '00' and
pam_cvesec = 'glMDI')
and pam_cvesec = 'OPCI63';
insert into glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_totreg, res_status)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act,
ws_hor_act, ws_hor_reg, wn_tot_reg, 'P');
-- borra la tabla de trabajo del crystal report.
delete from glwkcrys
where cry_nomrep = ws_nom_rep and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
-- extrae la clave de la estructura operativa.
for c_operat in (select des_keyest
from eolodest
where des_tipest = '1') loop
ws_key_est := c_operat.des_keyest;
end loop;
-- inicializa variables de trabajo para realizar cortes y monit.
wn_pct_reg := wn_tot_reg / 10.0;/* dmap converted statement start */
/* commit; */
-- cursor principal.
for c_nmlstpue in (select pue_keypue, pue_despue, rtrim(pue_grppue::text) pue_grppue,
rtrim(pue_subgrp::text) pue_subgrp, tab_keysue,
tab_cobert, tab_tiptab, tab_sueniv, tab_subniv, tab_feccad,
tab_suemin, tab_sue1qa, tab_suemed, tab_sue3qa, tab_suemax
from nmcopues, nmlotabs
where pue_keysue = tab_keysue and
pue_sueniv = tab_sueniv and
pue_subniv = tab_subniv and
rtrim(pue_tippue::text) = '1' and
pue_grppue in (select ran_keydep
from glwkrang
where ran_nomrep = ws_nom_rep and
ran_idepcc = ws_ide_pcc and
ran_keyusu = wn_key_usu and
nullif(ran_keydep::text, '') is not null)
order by  tab_keysue, pue_keypue, tab_cobert,
tab_tiptab, tab_feccad) loop
ws_key_sue := c_nmlstpue.tab_keysue;/* dmap converted statement end */
wn_con_reg := wn_con_reg + 1;
-- actualiza registro de monitoreo.
wn_num_reg := wn_num_reg + 1;
wn_pct_act := wn_pct_act + 1;
wn_con_reg := wn_con_reg + 1;
if wn_pct_act > 50 then
update glcoresu
set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_fec_act and
res_horreg = ws_hor_reg;
wn_pct_act := 0;
wn_con_reg := wn_con_reg + 1;
end if;
-- extrae descripcion del tabulador, area, subarea y cobertura.
if ws_key_sue != ws_sue_ant then
ws_des_sue := 'TABULADOR NO EXISTE ...';
for c_dessue in (select sue_dessue, sue_etqmin, sue_etq1qa,
sue_etqmed, sue_etq3qa, sue_etqmax
from nmlosuel
where sue_keysue = ws_key_sue) loop
ws_des_sue := oracle.substr(c_dessue.sue_dessue, 1, 40);
ws_etq_min := oracle.substr(c_dessue.sue_etqmin, 1,  8);
ws_etq_1qa := oracle.substr(c_dessue.sue_etq1qa, 1, 20);
ws_etq_med := oracle.substr(c_dessue.sue_etqmed, 1, 20);
ws_etq_3qa := oracle.substr(c_dessue.sue_etq3qa, 1, 20);
ws_etq_max := oracle.substr(c_dessue.sue_etqmax, 1,  8);
end loop;
ws_sue_ant := oracle.substr(ws_key_sue, 1, 4);
end if;
if (nullif(c_nmlstpue.pue_grppue::text, '') is not null) and (c_nmlstpue.pue_grppue != ' ') then
ws_des_grp := 'GRUPO NO EXISTE ...';
for c_desare in (select pue_despue
from nmcopues
where pue_keypue = c_nmlstpue.pue_grppue) loop
ws_des_grp := c_desare.pue_despue;
end loop;
ws_etq_002 := sp_glgetdsl('nmcopues', 'pue_grppue', '........', 8);
else
ws_des_grp := ' ';
ws_etq_002 := ' ';
end if;
if (nullif(c_nmlstpue.pue_subgrp::text, '') is not null) and (c_nmlstpue.pue_subgrp != ' ') then
ws_des_sub := 'SUB-GRUPO NO EXISTE ...';
for c_dessub in (select pue_despue
from nmcopues
where pue_keypue = c_nmlstpue.pue_subgrp) loop
ws_des_sub := c_dessub.pue_despue;
end loop;
ws_etq_011 := sp_glgetdsl('nmcopues', 'pue_subgrp', '........', 8);
else
ws_des_sub := ' ';
ws_etq_011 := ' ';
end if;
select pam_nompar into strict ws_des_zon from glcopams
where pam_keypar = ws_fol_ini
and pam_cvesec = c_nmlstpue.tab_cobert;
-- realiza el conteo de personal de la plantilla.
if c_nmlstpue.pue_keypue != ws_pue_ant then
wn_tot_per := 0;
select coalesce(sum(sol_cantid), 0)
into strict wn_tot_per
from eolosolc
where sol_keyest = ws_key_est and
sol_keypue = c_nmlstpue.pue_keypue;
ws_pue_ant := c_nmlstpue.pue_keypue;
end if;
-- inserta en la tabla de trabajo del crystal report.
insert into glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
cry_chr001, cry_chr003, cry_chr004,
cry_chr005, cry_chr006, cry_chr002,
cry_chr036, cry_chr008, cry_chr016,
cry_chr012, cry_dec006, cry_dec007,
cry_dec008, cry_chr039, cry_dec001,
cry_dec002, cry_dec003, cry_dec004,
cry_dec005, cry_chr045, cry_chr007,
cry_chr013, cry_chr021, cry_chr022,
cry_chr023, cry_chr024, cry_chr025,
cry_chr014, cry_chr027, cry_chr015,
cry_chr029, cry_chr030, cry_chr037,
cry_chr009, cry_chr010, cry_chr011,
cry_chr038, cry_dat001, cry_chr017,
cry_dat002)
values (ws_nom_rep,            ws_ide_pcc,            wn_key_usu,
ws_des_cor,            ws_des_sue,            ws_des_grp,
ws_des_sub,            c_nmlstpue.pue_despue, ws_des_lis,
ws_key_sue,            c_nmlstpue.pue_grppue, c_nmlstpue.pue_subgrp,
c_nmlstpue.pue_keypue, wn_tot_per,            c_nmlstpue.tab_sueniv,
c_nmlstpue.tab_subniv, c_nmlstpue.tab_tiptab, c_nmlstpue.tab_suemin,
c_nmlstpue.tab_sue1qa, c_nmlstpue.tab_suemed, c_nmlstpue.tab_sue3qa,
c_nmlstpue.tab_suemax, c_nmlstpue.tab_cobert, ws_des_zon,
ws_etq_001,            ws_etq_002,            ws_etq_003,
ws_etq_004,            ws_etq_005,            ws_etq_006,
ws_etq_007,            ws_etq_008,            ws_etq_009,
ws_etq_010,            ws_etq_011,            ws_etq_min,
ws_etq_1qa,            ws_etq_med,            ws_etq_3qa,
ws_etq_max,            wd_fec_act,            ws_hor_act,
c_nmlstpue.tab_feccad);
if wn_con_reg >= wn_lim_ite then
/* commit; */
wn_con_reg := 0;
end if;
end loop;
call sp_glfechor (wd_fec_act,ws_hor_act);
-- actualiza la tabla de monitoreo indicando la finalizacion del proceso.
update glcoresu
set res_numreg = wn_num_reg,
res_fecfin = wd_fec_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep  and
res_idepcc = ws_ide_pcc  and
res_keyusu = wn_key_usu  and
res_fecini = wd_fec_act and
res_horreg = ws_hor_reg;
/* commit; */
end;
$body$
language plpgsql
;
