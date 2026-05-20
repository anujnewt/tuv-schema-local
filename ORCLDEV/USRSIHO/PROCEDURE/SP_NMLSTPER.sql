create or replace procedure usrsiho."sp_nmlstper"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_key_men varchar, ws_hor_reg varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sipros, s.a. de c.v.
--
-- sistema  : rh-2000 c/s
-- modulo   : administracion de remuneraciones (nm)
--
-- programa : sp_nmlstper
--            reporte de periodos
--
-- autor    : joaquin perez m.
-- fecha    : 07 de marzo de 1997.
--
-- variables para la carga de la tabla de periodos --
wn_key_pro numeric(5);
wn_key_per varchar(7);
wd_fec_ini timestamp(0);
wd_fec_fin timestamp(0);
wn_key_nom numeric(5);
wd_fec_pag timestamp(0);
wn_num_mes numeric(5);
wn_acu_dos numeric(5);
wn_acu_tre numeric(5);
wn_acu_cua numeric(5);
ws_nu1_aux varchar(10);
ws_nu2_aux varchar(10);
ws_nu3_aux varchar(10);
ws_nu4_aux varchar(10);
ws_nu5_aux varchar(10);
ws_key_pol varchar(10);
wd_fec_pol timestamp(0);
-- variables para la carga de las descripciones de las claves   --
ws_des_pro varchar(40);
ws_des_nom varchar(40);
ws_des_cor varchar(60);
wn_pro_ant numeric(5);
ws_des_lis varchar(50);
-- variables para la carga de las descripciones de las etiquetas --
ws_key_cam varchar(20);
ws_des_etq varchar(8);
ws_des_etq1 varchar(40);
ws_etq_001 varchar(8);
ws_etq_002 varchar(8);
ws_etq_003 varchar(8);
ws_etq_004 varchar(40);
ws_etq_005 varchar(8);
ws_etq_006 varchar(8);
ws_etq_007 varchar(8);
ws_etq_008 varchar(8);
ws_etq_009 varchar(8);
ws_etq_010 varchar(40);
ws_etq_011 varchar(40);
ws_etq_012 varchar(40);
ws_etq_013 varchar(40);
ws_etq_014 varchar(40);
ws_etq_015 varchar(40);
ws_etq_016 varchar(8);
ws_etq_017 varchar(8);
-- variables para las restricciones de despliegue               --
ws_dsp_cam varchar(1);
wn_dsp_001 numeric(5);
wn_dsp_002 numeric(5);
wn_dsp_003 numeric(5);
wn_dsp_004 numeric(5);
wn_dsp_005 numeric(5);
wn_dsp_006 numeric(5);
wn_dsp_007 numeric(5);
wn_dsp_008 numeric(5);
wn_dsp_009 numeric(5);
wn_dsp_010 numeric(5);
wn_dsp_011 numeric(5);
wn_dsp_012 numeric(5);
wn_dsp_013 numeric(5);
wn_dsp_014 numeric(5);
wn_dsp_015 numeric(5);
wn_dsp_016 numeric(5);
wn_dsp_017 numeric(5);
-- variables para el reporte de avance                          --
wn_tot_reg numeric(10);
wn_num_reg numeric(10);
wn_pct_reg decimal(6,2);
wn_pct_act numeric(5);
ws_hor_act varchar(8);
ws_fec_act timestamp(0);
c_descor cursor for
select cor_descor from usrsiho.glcocorp;
c_lista cursor for
select lis_deslis from usrsiho.glcolist
where lis_keylis = ws_nom_rep;
c_etiqueta1 cursor for
select cam_keycam, cam_descor
from usrsiho.glcocamp
where cam_keytab = 'nmloperi';
c_etiqueta cursor for
select cam_keycam, cam_descam
from usrsiho.glcocamp
where cam_keytab = 'nmloperi';
c_desplieg cursor for
select rec_keycam, rec_despli from usrsiho.glcoreca
where rec_keytab = 'nmloperi'
and rec_keymen = ws_key_men;
c_despro cursor for
select pro_despro from usrsiho.nmloproc
where pro_keypro = wn_key_pro;
c_desnom cursor for
select nom_destip from usrsiho.nmlonomi
where nom_keynom = wn_key_nom;
c_nmlstper cursor for
select per_keyper, per_fecini, per_fecfin, per_keynom, per_fecpag,
per_nummes, per_acudos, per_acutre, per_acucua, per_nu1aux,
per_nu2aux, per_nu3aux, per_nu4aux, per_nu5aux, per_keypol,
per_fecpol, per_keypro
from usrsiho.nmloperi
where per_keypro in ( select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and per_keynom in ( select ran_keynom from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keynom::text, '') is not null )
and per_keyper in ( select ran_keyper from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null )
order by per_keypro, per_keynom, per_keyper;
begin
-- realiza el conteo de registros a procesar                    --
begin
select count(*)
into strict wn_tot_reg
from usrsiho.nmloperi
where per_keypro in ( select ran_keypro from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keypro::text, '') is not null )
and per_keynom in ( select ran_keynom from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keynom::text, '') is not null )
and per_keyper in ( select ran_keyper from usrsiho.glwkrang
where ran_nomrep = ws_nom_rep
and ran_idepcc = ws_ide_pcc
and ran_keyusu = wn_key_usu
and nullif(ran_keyper::text, '') is not null );
exception when no_data_found then wn_tot_reg := 0;
end;
-- inserta registro para monitoreo de resultados                --
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
ws_fec_act := trunc(clock_timestamp());
insert into usrsiho.glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, trunc(clock_timestamp()), ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );
-- borra la tabla de trabajo del crystal report                 --
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_idepcc = ws_ide_pcc
and cry_keyusu = wn_key_usu;
-- extrae el nombre de la compania corporativa                 --
ws_des_cor := 'CORPORATIVO NO REGISTRADO ...';
for rec in c_descor loop
ws_des_cor := rec.cor_descor;
end loop;
-- extrae el nombre del reporte
ws_des_lis := 'No existe Nombre del Reporte ...';
for rec2 in c_lista loop
ws_des_lis := rec2.lis_deslis;
end loop;
-- asigna valores por omision a las etiquetas del diccionario de datos --
ws_etq_001 := '........';
ws_etq_002 := '........';
ws_etq_003 := '........';
ws_etq_004 := '........';
ws_etq_005 := '........';
ws_etq_006 := '........';
ws_etq_007 := '........';
ws_etq_008 := '........';
ws_etq_009 := '........';
ws_etq_010 := '........';
ws_etq_011 := '........';
ws_etq_012 := '........';
ws_etq_013 := '........';
ws_etq_014 := '........';
ws_etq_015 := '........';
ws_etq_016 := '........';
ws_etq_017 := '........';
-- extrae las etiquetas del diccionario de datos                --
for rec3 in c_etiqueta1 loop
ws_key_cam := rec3.cam_keycam;
ws_des_etq := rec3.cam_descor;
if ws_key_cam = 'per_keyper' then
ws_etq_001 := ws_des_etq;
end if;
if ws_key_cam = 'per_fecini' then
ws_etq_002 := ws_des_etq;
end if;
if ws_key_cam = 'per_fecfin' then
ws_etq_003 := ws_des_etq;
end if;
if ws_key_cam = 'per_fecpag' then
ws_etq_005 := ws_des_etq;
end if;
if ws_key_cam = 'per_nummes' then
ws_etq_006 := ws_des_etq;
end if;
if ws_key_cam = 'per_acudos' then
ws_etq_007 := ws_des_etq;
end if;
if ws_key_cam = 'per_acutre' then
ws_etq_008 := ws_des_etq;
end if;
if ws_key_cam = 'per_acucua' then
ws_etq_009 := ws_des_etq;
end if;
if ws_key_cam = 'per_fecpol' then
ws_etq_016 := ws_des_etq;
end if;
if ws_key_cam = 'per_keypro' then
ws_etq_017 := ws_des_etq;
end if;
end loop;
-- extrae las etiquetas del diccionario de datos                --
for rec4 in c_etiqueta loop
ws_key_cam := rec4.cam_keycam;
ws_des_etq1 := rec4.cam_descam;
if ws_key_cam = 'per_keynom' then
ws_etq_004 := ws_des_etq1;
end if;
if ws_key_cam = 'per_nu1aux' then
ws_etq_010 := ws_des_etq1;
end if;
if ws_key_cam = 'per_nu2aux' then
ws_etq_011 := ws_des_etq1;
end if;
if ws_key_cam = 'per_nu3aux' then
ws_etq_012 := ws_des_etq1;
end if;
if ws_key_cam = 'per_nu4aux' then
ws_etq_013 := ws_des_etq1;
end if;
if ws_key_cam = 'per_nu5aux' then
ws_etq_014 := ws_des_etq1;
end if;
if ws_key_cam = 'per_keypol' then
ws_etq_015 := ws_des_etq1;
end if;
end loop;
-- asigna por omision que todos los campos se pueden desplegar  --
wn_dsp_001 := 0;
wn_dsp_002 := 0;
wn_dsp_003 := 0;
wn_dsp_004 := 0;
wn_dsp_005 := 0;
wn_dsp_006 := 0;
wn_dsp_007 := 0;
wn_dsp_008 := 0;
wn_dsp_009 := 0;
wn_dsp_010 := 0;
wn_dsp_011 := 0;
wn_dsp_012 := 0;
wn_dsp_013 := 0;
wn_dsp_014 := 0;
wn_dsp_015 := 0;
wn_dsp_016 := 0;
wn_dsp_017 := 0;
-- extrae las restricciones de despliegue                       --
for rec5 in c_desplieg loop
ws_key_cam := rec5.rec_keycam;
ws_dsp_cam := rec5.rec_despli;
if ( ws_key_cam = 'per_keypro' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_001 := 1;
end if;
if ( ws_key_cam = 'per_keynom' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_002 := 1;
end if;
if ( ws_key_cam = 'per_keyper' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_003 := 1;
end if;
if ( ws_key_cam = 'per_fecini' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_004 := 1;
end if;
if ( ws_key_cam = 'per_fecfin' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_005 := 1;
end if;
if ( ws_key_cam = 'per_fecpag' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_006 := 1;
end if;
if ( ws_key_cam = 'per_nummes' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_007 := 1;
end if;
if ( ws_key_cam = 'per_acudos' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_008 := 1;
end if;
if ( ws_key_cam = 'per_acutre' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_009 := 1;
end if;
if ( ws_key_cam = 'per_acucua' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_010 := 1;
end if;
if ( ws_key_cam = 'per_nu1aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_011 := 1;
end if;
if ( ws_key_cam = 'per_nu2aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_012 := 1;
end if;
if ( ws_key_cam = 'per_nu3aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_013 := 1;
end if;
if ( ws_key_cam = 'per_nu4aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_014 := 1;
end if;
if ( ws_key_cam = 'per_nu5aux' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_015 := 1;
end if;
if ( ws_key_cam = 'per_keypol' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_016 := 1;
end if;
if ( ws_key_cam = 'per_fecpol' ) and ( ws_dsp_cam = 'N' ) then
wn_dsp_017 := 1;
end if;
end loop;
-- inicializa variables de trabajo para realizar cortes y monit --
wn_pro_ant := -32760;
wn_num_reg := 0;
wn_pct_act := 1;
wn_pct_reg := wn_tot_reg / 10.0;
-- define cursor principal                                      --
for rec6 in c_nmlstper loop
-- actualiza registro de monitoreo                              --
wn_key_per := rec6.per_keyper;
wd_fec_ini := rec6.per_fecini;
wd_fec_fin := rec6.per_fecfin;
wn_key_nom := rec6.per_keynom;
wd_fec_pag := rec6.per_fecpag;
wn_num_mes := rec6.per_nummes;
wn_acu_dos := rec6.per_acudos;
wn_acu_tre := rec6.per_acutre;
wn_acu_cua := rec6.per_acucua;
ws_nu1_aux := rec6.per_nu1aux;
ws_nu2_aux := rec6.per_nu2aux;
ws_nu3_aux := rec6.per_nu3aux;
ws_nu4_aux := rec6.per_nu4aux;
ws_nu5_aux := rec6.per_nu5aux;
ws_key_pol := rec6.per_keypol;
wd_fec_pol := rec6.per_fecpol;
wn_key_pro := rec6.per_keypro;
wn_num_reg := wn_num_reg + 1;
if wn_num_reg >= ( wn_pct_reg * wn_pct_act ) then
update usrsiho.glcoresu set res_numreg = wn_num_reg
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
wn_pct_act := wn_pct_act + 1;
end if;
-- extrae descripciones de proceso y tipo de nomina   --
if nullif(wn_key_pro::text, '') is null then
ws_des_pro := 'PROCESO NO EXISTE ...';
else
if wn_key_pro <> wn_pro_ant then
ws_des_pro := 'PROCESO NO EXISTE ...';
for rec7 in c_despro loop
ws_des_pro := rec7.pro_despro;
end loop;
wn_pro_ant := wn_key_pro;
end if;
end if;
ws_des_nom := 'NOMINA NO EXISTE ...';
for rec8 in c_desnom loop
ws_des_nom := rec8.nom_destip;
end loop;
-- aplica restricciones de despliegue de campos                 --
if wn_dsp_001 = 1 then
wn_key_pro := null;
ws_des_pro := null;
end if;
if wn_dsp_002 = 1 then
wn_key_nom := null;
ws_des_nom := null;
end if;
if wn_dsp_003 = 1 then wn_key_per := null; end if;
if wn_dsp_004 = 1 then wd_fec_ini := null; end if;
if wn_dsp_005 = 1 then wd_fec_fin := null; end if;
if wn_dsp_006 = 1 then wd_fec_pag := null; end if;
if wn_dsp_007 = 1 then wn_num_mes := null; end if;
if wn_dsp_008 = 1 then wn_acu_dos := null; end if;
if wn_dsp_009 = 1 then wn_acu_tre := null; end if;
if wn_dsp_010 = 1 then wn_acu_cua := null; end if;
if wn_dsp_011 = 1 then ws_nu1_aux := null; end if;
if wn_dsp_012 = 1 then ws_nu2_aux := null; end if;
if wn_dsp_013 = 1 then ws_nu3_aux := null; end if;
if wn_dsp_014 = 1 then ws_nu4_aux := null; end if;
if wn_dsp_015 = 1 then ws_nu5_aux := null; end if;
if wn_dsp_016 = 1 then ws_key_pol := null; end if;
if wn_dsp_017 = 1 then wd_fec_pol := null; end if;
-- inserta en la tabla de trabajo del crystal report            --
insert into usrsiho.glwkcrys(
cry_nomrep, cry_idepcc, cry_keyusu, cry_chr001, cry_chr017,
cry_dat001, cry_dat002, cry_dec006, cry_chr003, cry_dat003,
cry_dec007, cry_dec008, cry_dec009, cry_dec010, cry_chr008,
cry_chr009, cry_chr010, cry_chr011, cry_chr007, cry_chr006,
cry_dat004, cry_dec011, cry_chr004, cry_chr018, cry_dat005,
cry_chr019, cry_chr020, cry_chr021, cry_chr005, cry_chr023,
cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr033,
cry_chr034, cry_chr035, cry_chr002 )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, ws_des_cor, wn_key_per,
wd_fec_ini, wd_fec_fin, wn_key_nom, ws_des_nom, wd_fec_pag,
wn_num_mes, wn_acu_dos, wn_acu_tre, wn_acu_cua, ws_nu1_aux,
ws_nu2_aux, ws_nu3_aux, ws_nu4_aux, ws_nu5_aux, ws_key_pol,
wd_fec_pol, wn_key_pro, ws_des_pro, ws_hor_act, ws_fec_act,
ws_etq_001, ws_etq_002, ws_etq_003, ws_etq_004, ws_etq_005,
ws_etq_006, ws_etq_007, ws_etq_008, ws_etq_009, oracle.substr(ws_etq_010,1,16),
oracle.substr(ws_etq_011,1,16), oracle.substr(ws_etq_012,1,16), ws_etq_013, ws_etq_014, ws_etq_015,
ws_etq_016, ws_etq_017, ws_des_lis );
end loop;
-- actualiza la tabla de monitoreo indicando la finalizacion    --
-- del proceso.                                                 --
ws_hor_act := to_char(clock_timestamp(), 'hh24:mi:ss');
update usrsiho.glcoresu set res_numreg = wn_num_reg,
res_fecfin = trunc(clock_timestamp()),
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = trunc(clock_timestamp())
and res_horreg = ws_hor_reg;
end;
$body$
language plpgsql
;
