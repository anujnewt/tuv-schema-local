-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table comcias (
numcia varchar(4) not null,
nomcia varchar(60) not null
) server  options(schema 'LABPPTO', table 'COMCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table comparativo (
id_comp numeric(10) not null,
cve_origen numeric(38) not null,
cve_mes numeric(38) not null,
cve_cia varchar(4) not null,
cve_virh varchar(10) not null,
cve_vicon varchar(10) not null,
cve_tpreg varchar(2) not null,
cve_ccrh varchar(16) not null,
cve_dptrh varchar(16) not null,
cve_dptcon varchar(16) not null,
cve_proc numeric(38) not null,
cve_empl numeric(38) not null,
tipo_emp varchar(6) not null,
cve_pue varchar(16) not null,
status varchar(1) not null,
cve_plaza numeric(38),
version numeric(38),
cve_anio numeric(38)
) server  options(schema 'LABPPTO', table 'COMPARATIVO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table comtporegistro (
numtporeg numeric(38) not null,
destporeg varchar(60) not null
) server  options(schema 'LABPPTO', table 'COMTPOREGISTRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table cuenta_compara (
cve_cuenta numeric(38) not null,
des_cta varchar(60)
) server  options(schema 'LABPPTO', table 'CUENTA_COMPARA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table detalleparametros (
iddetalle numeric(10) options (key 'true') not null,
enq_keyrep varchar(16) not null,
orden numeric(10) not null,
descripcionparametro varchar(50) not null
) server  options(schema 'LABPPTO', table 'DETALLEPARAMETROS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table det_compara (
id_comp numeric(38) not null,
cve_cuenta varchar(20),
importe decimal(14,2) not null
) server  options(schema 'LABPPTO', table 'DET_COMPARA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table eocorede (
red_keyest varchar(3) not null,
red_paddep varchar(16),
red_hijdep varchar(16) not null,
red_codniv varchar(80) not null,
red_pesesp numeric(5),
red_numniv numeric(5)
) server  options(schema 'LABPPTO', table 'EOCOREDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table eolodest (
des_keyest varchar(3) not null,
des_desest varchar(40),
des_tipest varchar(1) not null
) server  options(schema 'LABPPTO', table 'EOLODEST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table equcuen (
equ_cnomina varchar(3) not null,
equ_cdeptal varchar(6) not null,
equ_cdescri varchar(60) not null
) server  options(schema 'LABPPTO', table 'EQUCUEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcoargu (
arg_idepro varchar(10),
arg_idepcc varchar(15),
arg_keyusu numeric(10),
arg_fecini timestamp(0),
arg_horini varchar(8),
arg_pvalor varchar(100),
arg_keycam varchar(10),
arg_descam varchar(40)
) server  options(schema 'LABPPTO', table 'GLCOARGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcobiny (
bin_keybin varchar(8) not null,
bin_desbin varchar(36),
bin_idefun varchar(30),
bin_idever varchar(15),
bin_perfil varchar(50)
) server  options(schema 'LABPPTO', table 'GLCOBINY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcobita (
bit_keyusu numeric(10),
bit_logusu varchar(15),
bit_idepcc varchar(15),
bit_fecmov timestamp(0),
bit_hormov varchar(8),
bit_tipmov varchar(2),
bit_key001 varchar(18),
bit_key002 varchar(18),
bit_key003 varchar(18),
bit_val001 varchar(18),
bit_val002 varchar(18),
bit_val003 varchar(18),
bit_desmen varchar(37),
bit_ideniv numeric(5)
) server  options(schema 'LABPPTO', table 'GLCOBITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcocamp (
cam_keytab varchar(40),
cam_keycam varchar(40),
cam_descam varchar(50),
cam_desaux varchar(50),
cam_descor varchar(10),
cam_valcam varchar(12)
) server  options(schema 'LABPPTO', table 'GLCOCAMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcocorp (
cor_razsoc varchar(60),
cor_licper numeric,
cor_idhost varchar(16),
cor_basdat varchar(20),
cor_sisope varchar(20),
cor_descri varchar(60)
) server  options(schema 'LABPPTO', table 'GLCOCORP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcodats (
dat_keymen varchar(4),
dat_idecam varchar(6),
dat_valore varchar(10)
) server  options(schema 'LABPPTO', table 'GLCODATS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcodeco (
dco_razsoc varchar(60),
dco_numlic numeric(38),
dco_idenpc varchar(16),
dco_sisope varchar(20),
dco_fecreg timestamp(0),
dco_cvelic varchar(25)
) server  options(schema 'LABPPTO', table 'GLCODECO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcodetb (
det_keyusu numeric(10),
det_fecmov timestamp(0),
det_hormov varchar(8),
det_keytab varchar(18),
det_keycam varchar(18),
det_valant varchar(40),
det_valact varchar(40)
) server  options(schema 'LABPPTO', table 'GLCODETB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcoeven (
eve_ideper varchar(2),
eve_desper varchar(16),
eve_defaul varchar(2)
) server  options(schema 'LABPPTO', table 'GLCOEVEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcohipa (
hip_keyusu numeric(10) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_cveusu varchar(64)
) server  options(schema 'LABPPTO', table 'GLCOHIPA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcomenu (
men_keymen varchar(4) not null,
men_ideniv numeric(5),
men_numsec numeric(5),
men_gpomen varchar(4),
men_tipmen varchar(1),
men_permis numeric(5),
men_mengpo varchar(4),
men_keybin varchar(8),
men_perfil varchar(40),
men_descri varchar(35),
men_modulo varchar(2)
) server  options(schema 'LABPPTO', table 'GLCOMENU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcopams (
pam_keypar varchar(10),
pam_cvesec varchar(10),
pam_nompar varchar(200),
pam_folini varchar(100),
pam_folfin varchar(100)
) server  options(schema 'LABPPTO', table 'GLCOPAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcoreca (
rec_keymen varchar(4),
rec_keytab varchar(18),
rec_keycam varchar(18),
rec_actual varchar(1),
rec_despli varchar(1),
rec_valcam varchar(1)
) server  options(schema 'LABPPTO', table 'GLCORECA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcoresu (
res_idepro varchar(10),
res_idepcc varchar(15),
res_keyusu numeric(10),
res_fecini timestamp(0),
res_fecfin timestamp(0),
res_horini varchar(8),
res_horfin varchar(8),
res_horreg varchar(8),
res_numreg numeric(10),
res_totreg numeric(10),
res_status varchar(1),
res_sqlerr numeric(10),
res_isaerr numeric(10),
res_deserr varchar(2000)
) server  options(schema 'LABPPTO', table 'GLCORESU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcoseda (
sed_col001 varchar(60),
sed_col002 varchar(60),
sed_col003 varchar(60),
sed_col004 varchar(60),
sed_col005 varchar(60),
sed_col006 varchar(60),
sed_col007 varchar(60),
sed_col008 varchar(60),
sed_col009 varchar(60),
sed_col010 varchar(60),
sed_col011 varchar(60),
sed_col012 varchar(60),
sed_col013 varchar(60),
sed_col014 varchar(60),
sed_col015 varchar(60),
sed_col016 varchar(60),
sed_col017 varchar(60),
sed_col018 varchar(60),
sed_col019 varchar(60),
sed_col020 varchar(60)
) server  options(schema 'LABPPTO', table 'GLCOSEDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcotabl (
tab_keytab varchar(40),
tab_destab varchar(50)
) server  options(schema 'LABPPTO', table 'GLCOTABL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glcousua (
usu_keyusu numeric(10) not null,
usu_nomusu varchar(40) not null,
usu_keyest varchar(3),
usu_keydep varchar(16),
usu_fecalt timestamp(0),
usu_horalt varchar(5),
usu_cveusu varchar(64),
usu_keymen varchar(4),
usu_masopc varchar(10),
usu_status varchar(1),
usu_acceso timestamp(0),
usu_passwd timestamp(0),
usu_fecdur numeric(10),
usu_tipusu varchar(1),
usu_permen varchar(1)
) server  options(schema 'LABPPTO', table 'GLCOUSUA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table glwkcrys (
cry_nomrep varchar(10),
cry_idepcc varchar(15),
cry_keyusu numeric(10),
cry_numsec numeric(10),
cry_chr001 varchar(60),
cry_chr002 varchar(60),
cry_chr003 varchar(60),
cry_chr004 varchar(60),
cry_chr005 varchar(60),
cry_chr006 varchar(60),
cry_chr007 varchar(60),
cry_chr008 varchar(60),
cry_chr009 varchar(60),
cry_chr010 varchar(60),
cry_chr011 varchar(60),
cry_chr012 varchar(16),
cry_chr013 varchar(16),
cry_chr014 varchar(16),
cry_chr015 varchar(16),
cry_chr016 varchar(16),
cry_chr017 varchar(8),
cry_chr018 varchar(8),
cry_chr019 varchar(8),
cry_chr020 varchar(8),
cry_chr021 varchar(8),
cry_chr022 varchar(8),
cry_chr023 varchar(8),
cry_chr024 varchar(8),
cry_chr025 varchar(8),
cry_chr026 varchar(8),
cry_chr027 varchar(8),
cry_chr028 varchar(8),
cry_chr029 varchar(8),
cry_chr030 varchar(8),
cry_chr031 varchar(8),
cry_chr032 varchar(8),
cry_chr033 varchar(8),
cry_chr034 varchar(8),
cry_chr035 varchar(8),
cry_chr036 varchar(8),
cry_chr037 varchar(8),
cry_chr038 varchar(8),
cry_chr039 varchar(8),
cry_chr040 varchar(8),
cry_chr041 varchar(8),
cry_chr042 varchar(8),
cry_chr043 varchar(8),
cry_chr044 varchar(8),
cry_chr045 varchar(8),
cry_dat001 timestamp(0),
cry_dat002 timestamp(0),
cry_dat003 timestamp(0),
cry_dat004 timestamp(0),
cry_dat005 timestamp(0),
cry_dec001 decimal(18,6),
cry_dec002 decimal(18,6),
cry_dec003 decimal(18,6),
cry_dec004 decimal(18,6),
cry_dec005 decimal(18,6),
cry_dec006 numeric(10),
cry_dec007 numeric(10),
cry_dec008 numeric(10),
cry_dec009 numeric(10),
cry_dec010 numeric(10),
cry_dec011 decimal(14,2),
cry_dec012 decimal(14,2),
cry_dec013 decimal(14,2),
cry_dec014 decimal(14,2),
cry_dec015 decimal(14,2),
cry_dec016 decimal(14,2),
cry_dec017 decimal(14,2),
cry_dec018 decimal(14,2),
cry_dec019 decimal(14,2),
cry_dec020 decimal(14,2),
cry_dec021 decimal(14,2),
cry_dec022 decimal(14,2),
cry_dec023 decimal(14,2),
cry_dec024 decimal(14,2),
cry_dec025 decimal(14,2)
) server  options(schema 'LABPPTO', table 'GLWKCRYS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table nmcodeps (
dep_keydep varchar(16) not null,
dep_desdep varchar(40) not null,
dep_refcon varchar(52),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10)
) server  options(schema 'LABPPTO', table 'NMCODEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table nmcooana (
oan_nomvar varchar(3) not null,
oan_catalo varchar(10) not null,
oan_concep varchar(10) not null,
oan_alias numeric(5) not null,
oan_descri varchar(30) not null,
oan_nivjer numeric(5) not null,
oan_longit numeric(5) not null,
oan_pref01 numeric(5),
oan_pref02 numeric(5),
oan_pref03 numeric(5),
oan_pref04 numeric(5),
oan_pref05 numeric(5)
) server  options(schema 'LABPPTO', table 'NMCOOANA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table nmcopues (
pue_keypue varchar(16) not null,
pue_despue varchar(60) not null,
pue_refcon varchar(20),
pue_nu1aux varchar(10),
pue_nu2aux varchar(10),
pue_nu3aux varchar(10),
pue_nu4aux varchar(10),
pue_nu5aux varchar(10),
pue_ca1aux varchar(10),
pue_ca2aux varchar(10),
pue_ca3aux varchar(10),
pue_ca4aux varchar(10),
pue_ca5aux varchar(10),
pue_sueniv numeric(10),
pue_subniv numeric(10),
pue_keysue varchar(4),
pue_cobert varchar(2),
pue_arepue varchar(6),
pue_subare varchar(6),
pue_nivpue numeric(10),
pue_grppue varchar(16),
pue_subgrp varchar(16),
pue_tippue varchar(2)
) server  options(schema 'LABPPTO', table 'NMCOPUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table nmlotabn (
tab_keytab varchar(3),
tab_sectab numeric(10),
tab_eleuno decimal(18,6),
tab_eledos decimal(18,6),
tab_eletre decimal(18,6),
tab_elecua decimal(18,6)
) server  options(schema 'LABPPTO', table 'NMLOTABN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table nmlotanu (
tan_keytab varchar(3),
tan_de1tab varchar(40),
tan_de2tab varchar(40),
tan_de3tab varchar(40),
tan_idever varchar(15)
) server  options(schema 'LABPPTO', table 'NMLOTANU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppciapro (
apr_keycia varchar(4),
apr_keypro numeric(38),
apr_prosta numeric(38),
apr_ciapad varchar(4),
apr_diaxpr numeric(38)
) server  options(schema 'LABPPTO', table 'PPCIAPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppempmes (
emm_keycia varchar(4) not null,
emm_keyver numeric(38) not null,
emm_mes numeric(38) not null,
emm_keyemp numeric(38) not null,
emm_nomemp varchar(75) not null,
emm_keycen varchar(16) not null,
emm_keypue varchar(16) not null,
emm_fecing timestamp(0) not null,
emm_tipemp varchar(6) not null,
emm_keypro numeric(38) not null,
emm_cvezon numeric(38),
emm_keyloc varchar(16),
emm_status numeric(38),
emm_keyplz numeric(38) not null,
emm_mesbaj numeric(38),
emm_ciaorg varchar(4),
emm_salmes decimal(12,2),
emm_cccont varchar(20),
emm_iest varchar(6)
) server  options(schema 'LABPPTO', table 'PPEMPMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppfacint (
int_condic varchar(16),
int_keypro numeric(38),
int_tpoemp numeric(38),
int_keyfor varchar(4),
int_despro varchar(20)
) server  options(schema 'LABPPTO', table 'PPFACINT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppflujo (
flu_keyver numeric(38),
flu_numtab numeric(38),
flu_status numeric(38),
flu_parame varchar(20)
) server  options(schema 'LABPPTO', table 'PPFLUJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploacxc (
acx_keycia varchar(4) not null,
acx_keyver numeric(38) not null,
acx_keycen varchar(16) not null,
acx_keycon numeric(38) not null,
acx_eneppt decimal(20,2) not null,
acx_febppt decimal(20,2) not null,
acx_marppt decimal(20,2) not null,
acx_abrppt decimal(20,2) not null,
acx_mayppt decimal(20,2) not null,
acx_junppt decimal(20,2) not null,
acx_julppt decimal(20,2) not null,
acx_agoppt decimal(20,2) not null,
acx_sepppt decimal(20,2) not null,
acx_octppt decimal(20,2) not null,
acx_novppt decimal(20,2) not null,
acx_dicppt decimal(20,2) not null
) server  options(schema 'LABPPTO', table 'PPLOACXC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploaux1 (
pru_keycia varchar(4),
pru_keyver numeric(38),
pru_keyemp numeric(38),
pru_nummes numeric(38),
pru_porcen decimal(5,2),
pru_import decimal(20,2),
pru_status numeric(38)
) server  options(schema 'LABPPTO', table 'PPLOAUX1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplocale (
cal_keymes numeric(38) not null,
cal_nommes varchar(10),
cal_diames numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOCALE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploccxv (
ccx_keycia varchar(4) not null,
ccx_keyvic numeric(38) not null,
ccx_keycen varchar(16) not null,
ccx_keyame numeric(38),
ccx_descri varchar(50) not null
) server  options(schema 'LABPPTO', table 'PPLOCCXV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplocias (
cia_keycia varchar(4) not null,
cia_descri varchar(60) not null
) server  options(schema 'LABPPTO', table 'PPLOCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplocomp (
com_keycia varchar(4) not null,
com_keyver numeric(38) not null,
com_keycen varchar(16) not null,
com_keyemp numeric(38) not null,
com_keycon numeric(38) not null,
com_keytpo numeric(38) not null,
com_descen varchar(41) not null,
com_nomemp varchar(60) not null,
com_puesto varchar(40) not null,
com_tipemp varchar(6) not null,
com_descon varchar(35) not null,
com_eneppt decimal(20,2) not null,
com_febppt decimal(20,2) not null,
com_marppt decimal(20,2) not null,
com_abrppt decimal(20,2) not null,
com_mayppt decimal(20,2) not null,
com_junppt decimal(20,2) not null,
com_julppt decimal(20,2) not null,
com_agoppt decimal(20,2) not null,
com_sepppt decimal(20,2) not null,
com_octppt decimal(20,2) not null,
com_novppt decimal(20,2) not null,
com_dicppt decimal(20,2) not null,
com_enegto decimal(20,2) not null,
com_febgto decimal(20,2) not null,
com_margto decimal(20,2) not null,
com_abrgto decimal(20,2) not null,
com_maygto decimal(20,2) not null,
com_jungto decimal(20,2) not null,
com_julgto decimal(20,2) not null,
com_agogto decimal(20,2) not null,
com_sepgto decimal(20,2) not null,
com_octgto decimal(20,2) not null,
com_novgto decimal(20,2) not null,
com_dicgto decimal(20,2) not null
) server  options(schema 'LABPPTO', table 'PPLOCOMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploconc (
con_keycon varchar(3) not null,
con_descri varchar(35) not null,
con_keycue numeric(38)
) server  options(schema 'LABPPTO', table 'PPLOCONC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplocuen (
cue_keycue numeric(38) not null,
cue_keytpo numeric(38) not null,
cue_keydes varchar(36) not null,
cue_tipcue numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOCUEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploemcc (
emc_keycia varchar(2) not null,
emc_keyemp numeric(38) not null,
emc_keyame numeric(38),
emc_cen varchar(16)
) server  options(schema 'LABPPTO', table 'PPLOEMCC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplomes (
mes_keymes numeric(38) not null,
mes_nommes varchar(10),
mes_diames numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploorde (
ord_keycia varchar(4) not null,
ord_keyver numeric(38) not null,
ord_keyemp numeric(38) not null,
ord_keymes numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOORDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploparnew (
par_keycia varchar(4) not null,
par_keyver numeric(38) not null,
par_keypro numeric(38) not null,
par_keyloc varchar(16) not null,
par_pespe decimal(12,8) not null,
par_pespp decimal(12,8) not null,
par_pdine decimal(12,8) not null,
par_edinp decimal(12,8) not null,
par_cuofi decimal(12,8) not null,
par_enmae decimal(12,8) not null,
par_enmap decimal(12,8) not null,
par_invie decimal(12,8) not null,
par_invip decimal(12,8) not null,
par_guard decimal(12,8) not null,
par_rietr decimal(12,8) not null,
par_retir decimal(12,8) not null,
par_cevee decimal(12,8) not null,
par_cevep decimal(12,8) not null,
par_infon decimal(12,8) not null,
par_impes decimal(12,8) not null,
par_crite decimal(12,8) not null,
par_pipcon decimal(8,4),
par_pipsin decimal(8,4),
par_fomcon decimal(6,4),
par_fomsin decimal(6,4),
par_pmacon decimal(6,3),
par_pmasin decimal(6,3),
par_vafcon decimal(10,3),
par_vafsin decimal(10,3)
) server  options(schema 'LABPPTO', table 'PPLOPARNEW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploparp (
par_keycia varchar(4) not null,
par_keyver numeric(38) not null,
par_keypro numeric(38) not null,
par_diaagu numeric(38) not null,
par_diarut numeric(38) not null,
par_facivc decimal(9,7) not null,
par_facrtg decimal(9,7) not null,
par_faceme decimal(9,7) not null,
par_facem decimal(9,7) not null,
par_faccv decimal(9,7) not null,
par_facsar decimal(9,7) not null,
par_facinf decimal(9,7) not null,
par_pmavac decimal(6,3) not null,
par_valfin decimal(10,3) not null,
par_destra1 numeric(38) not null,
par_destra2 numeric(38) not null,
par_tipproc numeric(38),
par_destra3 numeric(38) not null,
par_destra4 numeric(38) not null,
par_destra5 numeric(38) not null,
par_destra6 numeric(38) not null,
par_destra7 numeric(38) not null,
par_destra8 numeric(38) not null,
par_destra9 numeric(38) not null,
par_destra10 numeric(38) not null,
par_destra11 numeric(38) not null,
par_destra12 numeric(38) not null,
par_impest decimal(8,6) not null,
par_facpip decimal(8,2) not null,
par_ptjpat decimal(8,6) not null,
par_ptjpip decimal(8,6) not null,
par_ptjqui decimal(8,6) not null,
par_ptjdec decimal(8,6) not null,
par_mttfza decimal(9,2) not null,
par_mttfzb decimal(9,2) not null,
par_mttfzc decimal(9,2) not null,
par_ptjval decimal(4,2) not null,
par_mttvza decimal(9,2) not null,
par_mttvzb decimal(9,2) not null,
par_mttvzc decimal(9,2) not null,
par_semes1 numeric(38) not null,
par_semes2 numeric(38) not null,
par_ptjvas numeric(16),
par_diaags numeric(38),
par_diarus numeric(38),
par_tsfims decimal(9,2),
par_salmdf decimal(9,2),
par_fomefi decimal(5,2),
par_ptumay numeric(38) not null,
par_ptunov numeric(38) not null,
par_pipcon decimal(8,4),
par_pipsin decimal(8,4),
par_fomcon decimal(6,4),
par_fomsin decimal(6,4),
par_pmacon decimal(6,3),
par_pmasin decimal(6,3),
par_vafcon decimal(10,3),
par_vafsin decimal(10,3)
) server  options(schema 'LABPPTO', table 'PPLOPARP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplopcxc (
pcx_keycia varchar(4) not null,
pcx_keyver numeric(38) not null,
pcx_keycen varchar(16) not null,
pcx_keycon numeric(38) not null,
pcx_tipcon numeric(38) not null,
pcx_eneppt decimal(20,2) not null,
pcx_febppt decimal(20,2) not null,
pcx_marppt decimal(20,2) not null,
pcx_abrppt decimal(20,2) not null,
pcx_mayppt decimal(20,2) not null,
pcx_junppt decimal(20,2) not null,
pcx_julppt decimal(20,2) not null,
pcx_agoppt decimal(20,2) not null,
pcx_sepppt decimal(20,2) not null,
pcx_octppt decimal(20,2) not null,
pcx_novppt decimal(20,2) not null,
pcx_dicppt decimal(20,2) not null,
pcx_tipemp numeric(38),
pcx_ciaorg varchar(4)
) server  options(schema 'LABPPTO', table 'PPLOPCXC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplopira (
pir_keycia varchar(4) not null,
pir_keyver numeric(38) not null,
pir_importe decimal(20,2) not null,
pir_313 decimal(20,2) not null,
pir_353 decimal(20,2) not null,
pir_325 decimal(20,2) not null,
pir_103 decimal(20,2) not null,
pir_105 decimal(20,2) not null,
pir_225 decimal(20,2) not null
) server  options(schema 'LABPPTO', table 'PPLOPIRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplopira2k6 (
pir_keycia varchar(4),
pir_keyver numeric(38),
pir_keycon numeric(38),
pir_impbto decimal(22,2),
pir_impuesto decimal(22,2),
pir_impnet decimal(22,2)
) server  options(schema 'LABPPTO', table 'PPLOPIRA2K6', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploplza (
ppl_keycia varchar(4) not null,
ppl_ciaorg varchar(4) not null,
ppl_keyver numeric(12) not null,
ppl_keycen varchar(16) not null,
ppl_eneppt numeric(12) not null,
ppl_febppt numeric(12) not null,
ppl_marppt numeric(12) not null,
ppl_abrppt numeric(12) not null,
ppl_mayppt numeric(12) not null,
ppl_junppt numeric(12) not null,
ppl_julppt numeric(12) not null,
ppl_agoppt numeric(12) not null,
ppl_sepppt numeric(12) not null,
ppl_octppt numeric(12) not null,
ppl_novppt numeric(12) not null,
ppl_dicppt numeric(12) not null
) server  options(schema 'LABPPTO', table 'PPLOPLZA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pploppto (
ppt_keycia varchar(4) not null,
ppt_keyver numeric(38) not null,
ppt_keyemp numeric(38) not null,
ppt_keycon numeric(38) not null,
ppt_ene decimal(20,2) not null,
ppt_feb decimal(20,2) not null,
ppt_mar decimal(20,2) not null,
ppt_abr decimal(20,2) not null,
ppt_may decimal(20,2) not null,
ppt_jun decimal(20,2) not null,
ppt_jul decimal(20,2) not null,
ppt_ago decimal(20,2) not null,
ppt_sep decimal(20,2) not null,
ppt_oct decimal(20,2) not null,
ppt_nov decimal(20,2) not null,
ppt_dic decimal(20,2) not null
) server  options(schema 'LABPPTO', table 'PPLOPPTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplorep (
rep_keycia varchar(4) not null,
rep_keyver numeric(38) not null,
rep_keyemp numeric(38) not null,
rep_keycon numeric(38) not null,
rep_ene decimal(20,2) not null,
rep_feb decimal(20,2) not null,
rep_mar decimal(20,2) not null,
rep_abr decimal(20,2) not null,
rep_may decimal(20,2) not null,
rep_jun decimal(20,2) not null,
rep_jul decimal(20,2) not null,
rep_ago decimal(20,2) not null,
rep_sep decimal(20,2) not null,
rep_oct decimal(20,2) not null,
rep_nov decimal(20,2) not null,
rep_dic decimal(20,2) not null
) server  options(schema 'LABPPTO', table 'PPLOREP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplotimp (
imp_keyver numeric(38) not null,
imp_keytab numeric(38) not null,
imp_keyren numeric(38) not null,
imp_valmin decimal(11,2) not null,
imp_valmax decimal(18,2) not null,
imp_cuofij decimal(11,2) not null,
imp_porexe decimal(11,3) not null
) server  options(schema 'LABPPTO', table 'PPLOTIMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplovac (
vac_keycia varchar(4) not null,
vac_aantig numeric(38) not null,
vac_dias numeric(38) not null,
vac_keypro numeric(38),
vac_tipemp varchar(6)
) server  options(schema 'LABPPTO', table 'PPLOVAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplovers (
ver_keycia varchar(4) not null,
ver_anio numeric(38) not null,
ver_mes numeric(38) not null,
ver_keyver numeric(38) not null,
ver_descri varchar(31) not null,
ver_status numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOVERS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pplovice (
vic_keycia varchar(4) not null,
vic_keyvic numeric(38) not null,
vic_descri varchar(60) not null,
vic_nomres varchar(35) not null,
vic_keyame numeric(38) not null
) server  options(schema 'LABPPTO', table 'PPLOVICE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppmapcias (
map_keycia varchar(3),
map_ciamap varchar(3) not null
) server  options(schema 'LABPPTO', table 'PPMAPCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppordeje (
eje_keycia varchar(4) not null,
eje_keyver numeric(38) not null,
eje_keycon varchar(3) not null,
eje_feceje timestamp(0),
eje_status numeric(38),
eje_ordeje numeric(38)
) server  options(schema 'LABPPTO', table 'PPORDEJE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pppagrales (
gra_keysec numeric(10) not null,
gra_descri varchar(60) not null,
gra_valor varchar(255) not null
) server  options(schema 'LABPPTO', table 'PPPAGRALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pppartop (
top_keycia varchar(4),
top_keyver numeric(38),
top_keypro numeric(38),
top_cvezon numeric(38),
top_tpoemp numeric(38),
top_clave numeric(38),
top_mesene decimal(20,2),
top_mesfeb decimal(20,2),
top_mesmar decimal(20,2),
top_mesabr decimal(20,2),
top_mesmay decimal(20,2),
top_mesjun decimal(20,2),
top_mesjul decimal(20,2),
top_mesago decimal(20,2),
top_messep decimal(20,2),
top_mesoct decimal(20,2),
top_mesnov decimal(20,2),
top_mesdic decimal(20,2)
) server  options(schema 'LABPPTO', table 'PPPARTOP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pptohyperion (
pto_ciamadre varchar(3),
pto_tipocia varchar(1),
pto_cia varchar(3) not null,
pto_neg varchar(2) not null,
pto_cta varchar(3) not null,
pto_scta varchar(6) not null,
pto_cc varchar(8) not null,
pto_icia varchar(3) not null,
pto_top varchar(1) not null,
pto_moneda numeric(1) not null,
pto_keyver numeric(6) not null,
pto_ene decimal(20,2) not null,
pto_feb decimal(20,2) not null,
pto_mar decimal(20,2) not null,
pto_abr decimal(20,2) not null,
pto_may decimal(20,2) not null,
pto_jun decimal(20,2) not null,
pto_jul decimal(20,2) not null,
pto_ago decimal(20,2) not null,
pto_sep decimal(20,2) not null,
pto_oct decimal(20,2) not null,
pto_nov decimal(20,2) not null,
pto_dic decimal(20,2) not null,
pto_tipreg varchar(2) not null
) server  options(schema 'LABPPTO', table 'PPTOHYPERION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pptopcxc (
ptx_keycia varchar(4),
ptx_keyver numeric(38),
ptx_keycon numeric(38),
ptx_ene decimal(20,2),
ptx_feb decimal(20,2),
ptx_mar decimal(20,2),
ptx_abr decimal(20,2),
ptx_may decimal(20,2),
ptx_jun decimal(20,2),
ptx_jul decimal(20,2),
ptx_ago decimal(20,2),
ptx_sep decimal(20,2),
ptx_oct decimal(20,2),
ptx_nov decimal(20,2),
ptx_dic decimal(20,2)
) server  options(schema 'LABPPTO', table 'PPTOPCXC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table ppto_tmp (
tmp_keycia varchar(4),
tmp_keyver numeric(38),
tmp_keyemp numeric(38),
tmp_keycon numeric(38),
mes decimal(38,2),
tmp_ene decimal(20,2),
fecha_proc varchar(6),
hora_proc varchar(6)
) server  options(schema 'LABPPTO', table 'PPTO_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table pptpomov (
tpo_keytpo numeric(38) not null,
tpo_destpo varchar(18) not null
) server  options(schema 'LABPPTO', table 'PPTPOMOV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcodequ (
deq_keyrep varchar(16),
deq_defvar varchar(16),
deq_numsec numeric(38),
deq_detqry varchar(200)
) server  options(schema 'LABPPTO', table 'RPCODEQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcoderp (
der_keyrep varchar(16),
der_keycam varchar(80),
der_numcam numeric(38),
der_keycor varchar(20),
der_posini numeric(38),
der_posfin numeric(38),
der_renglo numeric(38),
der_column numeric(38),
der_alinea numeric(38),
der_format numeric(38),
der_funcio numeric(38),
der_tiplet numeric(38),
der_posubi numeric(38),
der_oculta numeric(38),
der_valdes numeric(38),
der_clausu varchar(6),
der_ordcam varchar(4),
der_etique varchar(30)
) server  options(schema 'LABPPTO', table 'RPCODERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcoenqu (
enq_keyrep varchar(16),
enq_idepcc varchar(15),
enq_keyusu numeric(38),
enq_fecela timestamp(0),
enq_fecact timestamp(0),
enq_titrep varchar(80),
enq_status varchar(1),
enq_desrep varchar(60),
enq_usuexp varchar(1)
) server  options(schema 'LABPPTO', table 'RPCOENQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcoenrp (
enr_keyrep varchar(16),
enr_orihoj varchar(1),
enr_linpag numeric(38),
enr_linepa numeric(38),
enr_letenc numeric(38),
enr_encab1 varchar(50),
enr_encab2 varchar(50),
enr_encab3 varchar(50),
enr_encab4 varchar(50),
enr_letdet numeric(38),
enr_espcol numeric(38),
enr_delimi varchar(1),
enr_letpie numeric(38),
enr_piepa1 varchar(30),
enr_piepa2 varchar(30),
enr_swipie varchar(5)
) server  options(schema 'LABPPTO', table 'RPCOENRP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcoetiq (
eti_keyrep varchar(16),
eti_keycam varchar(18),
eti_etique varchar(20)
) server  options(schema 'LABPPTO', table 'RPCOETIQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcosegm (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_permen numeric(5)
) server  options(schema 'LABPPTO', table 'RPCOSEGM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcosegu (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_keyusu numeric(10),
seg_perusu numeric(5)
) server  options(schema 'LABPPTO', table 'RPCOSEGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpcospro (
spr_keyspr varchar(16),
spr_desspr varchar(60),
spr_parent varchar(200),
spr_keyrpt varchar(12),
spr_keytab varchar(18),
spr_iderep varchar(18),
spr_idepcc varchar(18),
spr_ideusu varchar(18),
spr_keyrep varchar(16),
spr_keyfor varchar(16)
) server  options(schema 'LABPPTO', table 'RPCOSPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table rpfmtcam (
cam_keyrep varchar(16),
cam_numsec numeric(38),
cam_keycam varchar(16),
cam_format varchar(100)
) server  options(schema 'LABPPTO', table 'RPFMTCAM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tempxmes (
emm_keycia varchar(4),
emm_cccont varchar(20),
emm_keyver numeric(38),
emm_keyplz numeric(38),
emm_keyemp numeric(38),
emm_mes numeric(38),
emm_nomemp varchar(60),
pue_despue varchar(60),
emm_fecing timestamp(0),
emm_tipemp varchar(6),
emm_keycen varchar(16),
emm_cccont2 varchar(20),
c100 decimal(20,2),
c101 decimal(20,2),
c102 decimal(20,2),
c103 decimal(20,2),
c104 decimal(20,2),
c105 decimal(20,2),
c106 decimal(20,2),
c107 decimal(20,2),
c108 decimal(20,2),
c109 decimal(20,2),
c110 decimal(20,2),
c118 decimal(20,2),
c119 decimal(20,2),
c120 decimal(20,2),
c121 decimal(20,2),
c122 decimal(20,2),
c123 decimal(20,2),
c124 decimal(20,2),
c125 decimal(20,2),
c126 decimal(20,2),
c130 decimal(20,2),
c134 decimal(20,2),
c138 decimal(20,2),
c139 decimal(20,2),
c141 decimal(20,2),
c142 decimal(20,2),
c143 decimal(20,2),
c145 decimal(20,2),
c151 decimal(20,2),
c154 decimal(20,2),
c155 decimal(20,2),
c156 decimal(20,2),
c157 decimal(20,2),
c159 decimal(20,2),
c160 decimal(20,2),
c165 decimal(20,2),
c166 decimal(20,2),
c167 decimal(20,2),
c168 decimal(20,2),
c181 decimal(20,2),
c182 decimal(20,2),
c184 decimal(20,2),
c225 decimal(20,2),
emm_keypro numeric(38),
map_ciamap varchar(3),
emm_cccont3 varchar(20),
fecha_proc varchar(6),
hora_proc varchar(6),
emm_cvezon numeric(38),
emm_keyloc varchar(16),
pue_keypue varchar(16)
) server  options(schema 'LABPPTO', table 'TEMPXMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tempxmesall (
emm_keycia varchar(4),
emm_cccont varchar(20),
emm_keyver numeric(38),
emm_keyplz numeric(38),
emm_keyemp numeric(38),
emm_mes numeric(38),
emm_nomemp varchar(61),
pue_despue varchar(60),
emm_fecing timestamp(0),
emm_tipemp varchar(6),
emm_keycen varchar(16),
emm_cccont2 varchar(20),
ppt_ene decimal(20,2),
ppt_feb decimal(20,2),
ppt_mar decimal(20,2),
ppt_abr decimal(20,2),
ppt_may decimal(20,2),
ppt_jun decimal(20,2),
ppt_jul decimal(20,2),
ppt_ago decimal(20,2),
ppt_sep decimal(20,2),
ppt_oct decimal(20,2),
ppt_nov decimal(20,2),
ppt_dic decimal(20,2),
ppt_keycon numeric(38),
emm_keypro numeric(38),
map_ciamap varchar(3),
emm_cccont3 varchar(20),
fecha_proc varchar(6),
hora_proc varchar(6),
emm_cvezon numeric(38),
emm_keyloc varchar(16),
pue_keypue varchar(16)
) server  options(schema 'LABPPTO', table 'TEMPXMESALL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tmpccmap (
cm varchar(200),
ch varchar(200),
cc varchar(100),
fecha_proc varchar(6),
hora_proc varchar(6)
) server  options(schema 'LABPPTO', table 'TMPCCMAP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tmppploform (
for_keycia varchar(4),
for_cccont1 varchar(10),
for_keyver numeric(38),
for_keyplz numeric(38),
for_keyemp numeric(38),
for_mes numeric(38),
for_nomemp varchar(75),
for_puesto varchar(75),
for_fecing timestamp(0),
for_tipemp numeric(38),
for_cen varchar(16),
for_cccont2 varchar(8),
for_100 decimal(12,2),
for_101 decimal(12,2),
for_102 decimal(12,2),
for_103 decimal(12,2),
for_104 decimal(12,2),
for_105 decimal(12,2),
for_106 decimal(12,2),
for_107 decimal(12,2),
for_108 decimal(12,2),
for_109 decimal(12,2),
for_110 decimal(12,2),
for_118 decimal(12,2),
for_119 decimal(12,2),
for_120 decimal(12,2),
for_121 decimal(12,2),
for_122 decimal(12,2),
for_123 decimal(12,2),
for_124 decimal(12,2),
for_125 decimal(12,2),
for_126 decimal(12,2),
for_130 decimal(12,2),
for_134 decimal(12,2),
for_138 decimal(12,2),
for_139 decimal(12,2),
for_141 decimal(12,2),
for_142 decimal(12,2),
for_143 decimal(12,2),
for_145 decimal(12,2),
for_151 decimal(12,2),
for_154 decimal(12,2),
for_155 decimal(12,2),
for_156 decimal(12,2),
for_157 decimal(12,2),
for_159 decimal(12,2),
for_160 decimal(12,2),
for_165 decimal(12,2),
for_166 decimal(12,2),
for_167 decimal(12,2),
for_168 decimal(12,2),
for_181 decimal(12,2),
for_182 decimal(12,2),
for_184 decimal(12,2),
for_225 decimal(12,2),
for_pro numeric(38),
for_ciasoin varchar(3),
for_ciaccma varchar(6),
fecha_proc varchar(6),
hora_proc varchar(6),
emm_cvezon numeric(38),
emm_keyloc varchar(16),
pue_keypue varchar(16)
) server  options(schema 'LABPPTO', table 'TMPPPLOFORM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tmppprepgen (
tmp_keycia varchar(4),
tmp_keyver numeric(38),
tmp_keycon numeric(38),
tmp_descon varchar(36),
tmp_ene decimal(20,2),
tmp_feb decimal(20,2),
tmp_mar decimal(20,2),
tmp_abr decimal(20,2),
tmp_may decimal(20,2),
tmp_jun decimal(20,2),
tmp_jul decimal(20,2),
tmp_ago decimal(20,2),
tmp_sep decimal(20,2),
tmp_oct decimal(20,2),
tmp_nov decimal(20,2),
tmp_dic decimal(20,2),
fecha_proc varchar(6),
hora_proc varchar(6)
) server  options(schema 'LABPPTO', table 'TMPPPREPGEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tmp_plzas_mes (
scia varchar(4),
nsversion numeric(38),
scc varchar(16),
niciaorg varchar(4),
sintercia varchar(3),
nienero numeric(38),
nifebrero numeric(38),
nimarzo numeric(38),
niabril numeric(38),
nimayo numeric(38),
nijunio numeric(38),
nijulio numeric(38),
niagosto numeric(38),
niseptiembre numeric(38),
nioctubre numeric(38),
ninoviembre numeric(38),
nidiciembre numeric(38)
) server  options(schema 'LABPPTO', table 'TMP_PLZAS_MES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = labppto,oracle,dmap_extension,public;
create foreign  table tmp_plz_pptos (
tmp_ene numeric(38),
tmp_feb numeric(38),
tmp_mar numeric(38),
tmp_abr numeric(38),
tmp_may numeric(38),
tmp_jun numeric(38),
tmp_jul numeric(38),
tmp_ago numeric(38),
tmp_sep numeric(38),
tmp_oct numeric(38),
tmp_nov numeric(38),
tmp_dic numeric(38),
fecha_proc varchar(6),
hora_proc varchar(6)
) server  options(schema 'LABPPTO', table 'TMP_PLZ_PPTOS', readonly 'true');
