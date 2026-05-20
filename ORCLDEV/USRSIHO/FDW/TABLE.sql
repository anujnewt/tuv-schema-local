-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table accesocc (
acc_usuario varchar(20),
acc_nomusuario varchar(60),
acc_cencos varchar(16),
acc_ressol varchar(1),
acc_ussiho numeric(10),
acc_correo varchar(200),
acc_ccopia varchar(200),
acc_status varchar(1)
) server  options(schema 'USRSIHO', table 'ACCESOCC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table agrupxcod (
xco_keypro numeric(5) not null,
xco_cvegpo varchar(3) not null,
xco_prefij varchar(3) not null
) server  options(schema 'USRSIHO', table 'AGRUPXCOD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table anexo1 (
keycia varchar(10) not null,
a varchar(20),
b varchar(10),
c varchar(13),
d varchar(20),
e varchar(80),
f varchar(40),
g varchar(40),
h varchar(10),
i varchar(35),
j varchar(10),
k varchar(10),
l varchar(10),
m varchar(10),
n varchar(10),
o varchar(10),
p varchar(10),
q varchar(10),
r varchar(10),
s varchar(10),
t varchar(10),
u varchar(10),
v varchar(10),
w varchar(10),
x varchar(10),
y varchar(10),
z varchar(10),
aa varchar(10),
ab varchar(10),
ac varchar(10),
ad varchar(10),
ae varchar(10),
af varchar(10),
ag varchar(10),
ah varchar(10),
ai varchar(10),
aj varchar(10),
ak varchar(10),
al varchar(10),
am varchar(10),
an varchar(10),
ao varchar(10),
ap varchar(10),
aq varchar(10),
ar numeric(10)
) server  options(schema 'USRSIHO', table 'ANEXO1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table anexo2 (
keycia varchar(10) not null,
a varchar(20),
b varchar(30),
c varchar(10),
d varchar(10),
e varchar(80),
f varchar(35),
g varchar(20),
h varchar(10),
i varchar(13),
j varchar(10),
k varchar(10),
l varchar(10),
m varchar(10),
n varchar(10),
o varchar(10),
p varchar(10),
q varchar(10),
r varchar(10),
s varchar(10),
t varchar(10),
u varchar(10),
v varchar(10),
w varchar(10),
x varchar(10),
y varchar(10),
z varchar(10),
aa varchar(10),
ab varchar(10),
ac varchar(10),
ad varchar(10),
ae numeric(10)
) server  options(schema 'USRSIHO', table 'ANEXO2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table aud_nmlohism (
diayhora timestamp,
usuario varchar(8) not null,
ant_ca1aux varchar(16),
des_ca1aux varchar(16)
) server  options(schema 'USRSIHO', table 'AUD_NMLOHISM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table caracteres (
caracter varchar(1) not null,
descripcion varchar(50) not null
) server  options(schema 'USRSIHO', table 'CARACTERES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table cfdiconf (
idconfig numeric(10) not null,
con_keycia varchar(2),
con_codimp varchar(2),
con_keycon varchar(3),
con_tipcon varchar(1),
con_tipsat varchar(3),
con_clave varchar(15),
con_descri varchar(100),
con_camexe varchar(6),
con_camgra varchar(6),
con_tipope varchar(1),
con_incdia varchar(6),
con_incdes varchar(6),
con_hexdia varchar(6),
con_hexhor varchar(6),
con_heximp varchar(6),
con_diapag varchar(6)
) server  options(schema 'USRSIHO', table 'CFDICONF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table cfdimovtos (
idcomprobanteemp numeric(10),
com_keyemp numeric(10),
com_keycon varchar(3),
calificador varchar(1),
tiposat varchar(3),
clave varchar(6),
concepto varchar(100),
importegravado decimal(18,6),
importeexento decimal(18,6)
) server  options(schema 'USRSIHO', table 'CFDIMOVTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table cfdipagos (
idcomprobanteemp numeric(10) not null,
pag_keypol varchar(30),
pag_cvepol varchar(40),
pag_keypro numeric(5),
pag_keynom numeric(5),
pag_keyper varchar(7),
pag_keycia varchar(2),
pag_keyemp numeric(10),
pag_fecpag timestamp(0),
pag_ca2aux varchar(10),
pag_forpag varchar(30),
pag_feccar timestamp(0),
pag_horcar varchar(10),
pag_keyusu numeric(10),
pag_idepcc varchar(40),
pag_status numeric(5),
uuid varchar(36),
pag_fectim timestamp(0),
pag_hortim varchar(10)
) server  options(schema 'USRSIHO', table 'CFDIPAGOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table cfdiperiodos (
per_keypro numeric(5),
per_keynom numeric(5),
per_keyper varchar(7),
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0)
) server  options(schema 'USRSIHO', table 'CFDIPERIODOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table codeacont (
con_keyemp varchar(12) not null,
con_fecven timestamp(0),
con_keyplz numeric(10),
con_fecoto timestamp(0)
) server  options(schema 'USRSIHO', table 'CODEACONT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table com_sips_orac_bita (
bit_regist varchar(50),
bit_valant varchar(50),
bit_valnue varchar(50),
bit_keyemp numeric(10),
bit_fecmov timestamp(0),
bit_menerr varchar(200),
bit_noctvo numeric(10) not null,
bit_status varchar(1)
) server  options(schema 'USRSIHO', table 'COM_SIPS_ORAC_BITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table com_sips_orac_empl (
ora_ctvo numeric(10) not null,
ora_status varchar(1),
id_persona varchar(20),
apellidos varchar(150),
nombres varchar(150),
tipo_persona varchar(20),
sexo varchar(1),
rfc varchar(20),
curp varchar(20),
imss numeric(20),
fecha_alta timestamp(0),
fecha_nacimiento timestamp(0),
nacionalidad varchar(80),
business_group_id numeric(5),
email varchar(40)
) server  options(schema 'USRSIHO', table 'COM_SIPS_ORAC_EMPL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table consagrup (
gru_cvegpo varchar(3) not null,
gru_consec numeric(10) not null
) server  options(schema 'USRSIHO', table 'CONSAGRUP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table contratos_tmp (
contratos numeric(38)
) server  options(schema 'USRSIHO', table 'CONTRATOS_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table contra_pendpag2009 (
empleado numeric(10),
folio numeric(10)
) server  options(schema 'USRSIHO', table 'CONTRA_PENDPAG2009', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table cont_49 (
con_keydep varchar(16),
con_keypue varchar(16),
con_keyemp numeric(10),
con_cosuni decimal(13,2)
) server  options(schema 'USRSIHO', table 'CONT_49', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table detalleparametros (
iddetalle numeric(10) options (key 'true') not null,
enq_keyrep varchar(16) not null,
orden numeric(10) not null,
descripcionparametro varchar(50) not null
) server  options(schema 'USRSIHO', table 'DETALLEPARAMETROS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table detpcanr (
dpc_numpco numeric(10),
dpc_idereg numeric(10),
dpc_keyemp numeric(10),
dpc_sexo varchar(1),
dpc_nomreal varchar(20),
dpc_apepat varchar(20),
dpc_apemat varchar(20),
dpc_regrfc varchar(13),
dpc_recurp varchar(18),
dpc_nomart varchar(40),
dpc_cranda numeric(10),
dpc_domemp varchar(60),
dpc_numext varchar(5),
dpc_numint varchar(5),
dpc_colemp varchar(40),
dpc_codpos varchar(5),
dpc_munemp varchar(30),
dpc_cidemp varchar(40),
dpc_nacion varchar(40),
dpc_paisres varchar(3),
dpc_lugnac varchar(30),
dpc_telefono varchar(10),
dpc_edad numeric(10),
dpc_fecnac timestamp(0),
dpc_calsind varchar(5),
dpc_calmig varchar(30),
dpc_sindicato varchar(12),
dpc_clasif varchar(16),
dpc_siscon varchar(1),
dpc_person varchar(40),
dpc_numcap varchar(60),
dpc_fecgra timestamp(0),
dpc_padiftab numeric(5),
dpc_tabulador decimal(12,2),
dpc_tabulade numeric(10),
dpc_totcap numeric(10),
dpc_conjunto varchar(100),
dpc_idioma varchar(20),
dpc_tipval numeric(10),
dpc_keyfol numeric(10),
dpc_feccap timestamp(0),
dpc_stsreg numeric(10),
dpc_tipopago numeric(10),
dpc_chklst varchar(22),
dpc_numllama numeric(5),
dpc_cvenacdad varchar(6)
) server  options(schema 'USRSIHO', table 'DETPCANR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table detpetco (
dpc_numpco numeric(10),
dpc_idereg numeric(10),
dpc_keyemp numeric(10),
dpc_nomart varchar(40),
dpc_clasif varchar(16),
dpc_descla varchar(50),
dpc_tabulador decimal(12,2),
dpc_sindicato varchar(12),
dpc_siscon varchar(1),
dpc_fecgra timestamp(0),
dpc_nomreal varchar(60),
dpc_person varchar(40),
dpc_numcap varchar(60),
dpc_tabulade numeric(10),
dpc_padiftab numeric(5),
dpc_totcap numeric(10),
dpc_conjunto varchar(100),
dpc_nacion varchar(20),
dpc_idioma varchar(20),
dpc_tipval numeric(10),
dpc_keyfol numeric(10),
dpc_feccap timestamp(0),
dpc_stsreg numeric(10),
dpc_tipopago numeric(10),
dpc_docfis varchar(20),
dpc_numllama numeric(5)
) server  options(schema 'USRSIHO', table 'DETPETCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table detsolact (
dsa_numsol numeric(10),
dsa_idereg numeric(10),
dsa_keyemp numeric(10),
dsa_nomart varchar(40),
dsa_person varchar(40),
dsa_sindicato varchar(12),
dsa_keypue varchar(16),
dsa_keynac varchar(20),
dsa_numcap varchar(60),
dsa_coment varchar(255),
dsa_stsreg numeric(10),
dsa_tipodis varchar(25),
dsa_revdis varchar(20),
dsa_numpet numeric(10),
dsa_numlla numeric(10),
dsa_npcanr numeric(10),
dsa_nreptra numeric(10)
) server  options(schema 'USRSIHO', table 'DETSOLACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emaccaut (
acc_keyusu numeric(10) not null,
acc_passwd varchar(10) not null,
acc_nombre varchar(60) not null
) server  options(schema 'USRSIHO', table 'EMACCAUT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emacceco (
cco_keyusu numeric(10) not null,
cco_keydep varchar(16) not null
) server  options(schema 'USRSIHO', table 'EMACCECO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emacceso (
acc_keyusu numeric(10) not null,
acc_keyobj numeric(10) not null,
acc_tipmov varchar(4) not null,
acc_tipacc varchar(1)
) server  options(schema 'USRSIHO', table 'EMACCESO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emaccmod (
acc_keyusu numeric(10) not null,
acc_keymod numeric(10) not null
) server  options(schema 'USRSIHO', table 'EMACCMOD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emagencia (
age_numage numeric(10) not null,
age_cvsiho numeric(10),
age_nombre varchar(60) not null,
age_razsoc varchar(30) not null,
age_contel varchar(30),
age_cvecla varchar(6) not null,
age_rfc varchar(20) not null,
age_calle varchar(30) not null,
age_coloni varchar(30) not null,
age_cvedel numeric(5) not null,
age_numext varchar(20) not null,
age_numint varchar(20),
age_codpos numeric(5) not null,
age_cveent numeric(10) not null,
age_pais varchar(30) not null,
age_telef1 varchar(15) not null,
age_telef2 varchar(15),
age_observ varchar(250)
) server  options(schema 'USRSIHO', table 'EMAGENCIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table embitacora (
bit_keybit numeric(10) not null,
bit_keyusu numeric(10) not null,
bit_idepcc varchar(30) not null,
bit_clase varchar(30) not null,
bit_fecmov timestamp(0) not null,
bit_hormov varchar(8) not null,
bit_tipmov numeric(10) not null,
bit_tabla varchar(20) not null,
bit_campo1 varchar(20) not null,
bit_valor1 varchar(20),
bit_campo2 varchar(20),
bit_valor2 varchar(20),
bit_campo3 varchar(20),
bit_valor3 varchar(20),
bit_campo4 varchar(20),
bit_valor4 varchar(20)
) server  options(schema 'USRSIHO', table 'EMBITACORA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emcampos (
cam_keycam numeric(10) not null,
cam_nombre varchar(10) not null,
cam_descri varchar(255) not null,
cam_keytab numeric(10) not null
) server  options(schema 'USRSIHO', table 'EMCAMPOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emdetbit (
det_keybit numeric(10) not null,
det_tabla varchar(20) not null,
det_campo varchar(20) not null,
det_valact varchar(100),
det_valant varchar(100)
) server  options(schema 'USRSIHO', table 'EMDETBIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emdetenvios (
det_keyenv numeric(10) options (key 'true') not null,
det_keyemp numeric(10) options (key 'true') not null,
det_keysta numeric(10) not null,
det_feccan timestamp(0),
det_usucan numeric(10),
det_fecreq timestamp(0) not null
) server  options(schema 'USRSIHO', table 'EMDETENVIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emenvios (
env_keyenv numeric(10) not null,
env_keydep varchar(16) not null,
env_feclla timestamp(0) not null,
env_fecreq timestamp(0) not null,
env_horlla varchar(5) not null,
env_keysta numeric(10) not null,
env_keyfor varchar(6) not null,
env_keyusu numeric(10) not null,
env_feccan timestamp(0),
env_usucan numeric(10),
env_notas varchar(200)
) server  options(schema 'USRSIHO', table 'EMENVIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emfacturas (
fac_numfac numeric(10) not null,
fac_cencos varchar(16) not null,
fac_numage numeric(10) not null,
fac_fecha timestamp(0) not null,
fac_descri varchar(100) not null,
fac_import decimal(18,2) not null,
fac_iva decimal(15,2) not null
) server  options(schema 'USRSIHO', table 'EMFACTURAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emfechfac (
fec_fecha timestamp(0) not null,
fec_factor numeric(10) not null,
fec_descri varchar(200)
) server  options(schema 'USRSIHO', table 'EMFECHFAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emgencat (
gen_keycat numeric(10) not null,
gen_descri varchar(60) not null,
gen_keydat numeric(10),
gen_ranini varchar(30),
gen_ranfin varchar(255),
gen_ranmed varchar(30)
) server  options(schema 'USRSIHO', table 'EMGENCAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emimagen (
ima_keyim1 varchar(10) not null,
ima_keyim2 varchar(10),
ima_keyim3 varchar(10),
ima_imagen bytea not null,
ima_tipima varchar(15) not null
) server  options(schema 'USRSIHO', table 'EMIMAGEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emjoinst (
joi_keyjoi numeric(10) options (key 'true') not null,
joi_keyta1 numeric(10) not null,
joi_keyta2 numeric(10) not null,
joi_joins1 varchar(255),
joi_joins2 varchar(255)
) server  options(schema 'USRSIHO', table 'EMJOINST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emlocacion (
loc_keyloc numeric(10) not null,
loc_keydep varchar(16) not null,
loc_fecha timestamp(0) not null,
loc_descri varchar(100) not null,
loc_import decimal(18,2) not null,
loc_iva decimal(15,2) not null
) server  options(schema 'USRSIHO', table 'EMLOCACION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emmenace (
alm_klogin numeric(10) not null,
alm_knuobj numeric(10) not null,
alm_tipmov varchar(4) not null,
alm_tipacc varchar(1),
alm_valor varchar(1),
alm_padre numeric(5) not null,
alm_orden numeric(5) not null,
alm_tipmen varchar(1) not null,
alm_tipobj varchar(4) not null,
alm_descor varchar(20) not null
) server  options(schema 'USRSIHO', table 'EMMENACE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emmencat (
men_keyobj numeric(10) not null,
men_padre numeric(5) not null,
men_orden numeric(5) not null,
men_tipmen varchar(1) not null,
men_tipobj varchar(4) not null,
men_descor varchar(30) not null,
men_deslar varchar(60),
men_icono varchar(20),
men_hotkey varchar(10),
men_clase varchar(30)
) server  options(schema 'USRSIHO', table 'EMMENCAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emmodulo (
mod_keymod numeric(10) not null,
mod_descri varchar(60) not null
) server  options(schema 'USRSIHO', table 'EMMODULO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emobjeto (
obj_keypro varchar(10) not null,
obj_nomfrm varchar(20) not null,
obj_nomobj varchar(60) not null,
obj_keyobj numeric(10) not null,
obj_desobj varchar(60) not null,
obj_perfil varchar(1) not null,
obj_evento varchar(1)
) server  options(schema 'USRSIHO', table 'EMOBJETO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table empagdxm (
pag_keypag numeric(10) not null,
pag_keydet numeric(10) not null,
pag_keyemp numeric(10) not null,
pag_hrlleg varchar(5) not null,
pag_hrsali varchar(5) not null,
pag_tabula double precision not null,
pag_viatic double precision,
pag_nohras double precision,
pag_exhras double precision,
pag_imphre double precision,
pag_totale double precision not null,
pag_keypue varchar(16) not null
) server  options(schema 'USRSIHO', table 'EMPAGDXM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table empagexm (
pag_keypag numeric(10) not null,
pag_keydep varchar(16) not null,
pag_keyfor numeric(10) not null,
pag_fecpag timestamp(0) not null,
pag_keyrph numeric(10),
pag_keyenv numeric(10),
pag_keyest numeric(5),
pag_firmas varchar(11),
pag_observ text
) server  options(schema 'USRSIHO', table 'EMPAGEXM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table empercomple (
per_keyper numeric(10) not null,
per_keyemp numeric(10) not null,
per_keypue numeric(10),
per_altura double precision,
per_keycom numeric(5),
per_pesokg double precision,
per_keytez numeric(5),
per_keytoj numeric(5),
per_keycoj numeric(5),
per_keycab numeric(5),
per_keynar numeric(5),
per_lugnac varchar(60),
per_keyedc numeric(5),
per_keyboc numeric(5),
per_estatu varchar(1),
per_keyfol double precision
) server  options(schema 'USRSIHO', table 'EMPERCOMPLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table empersonas (
per_keyper numeric(10) not null,
per_nombre varchar(40),
per_apepat varchar(20),
per_apemat varchar(20),
per_fecnac timestamp(0),
per_regrfc varchar(13),
per_recurp varchar(18),
per_seudon varchar(40),
per_direci varchar(30),
per_coloni varchar(20),
per_poblac varchar(20),
per_ciudad varchar(20),
per_keydem numeric(10) not null,
per_keyenf numeric(10) not null,
per_codpos varchar(5),
per_keynac numeric(10),
per_keyzoe numeric(5) not null,
per_telef1 varchar(15),
per_telef2 varchar(15),
per_telef3 varchar(15),
per_lugnac varchar(30),
per_origen varchar(30),
per_paires varchar(3),
per_keysex numeric(5) not null,
per_keyedc numeric(5),
per_keyban varchar(7),
per_ctaban varchar(16),
per_keyrgf numeric(10),
per_cedula varchar(20),
per_refcon varchar(20),
per_fecing timestamp(0),
per_keyemp numeric(10),
per_keypue numeric(10),
per_altura double precision,
per_keycom numeric(5),
per_pesokg double precision,
per_keytez numeric(5),
per_keytoj numeric(5),
per_keycoj numeric(5),
per_keycab numeric(5),
per_keynar numeric(5),
per_keyboc numeric(5),
per_estatu varchar(1)
) server  options(schema 'USRSIHO', table 'EMPERSONAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table empleado (
keyemp numeric(10)
) server  options(schema 'USRSIHO', table 'EMPLEADO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emtablas (
tab_keytab numeric(10) not null,
tab_nombre varchar(50) not null,
tab_descri varchar(60) not null,
tab_aliast varchar(5) not null,
tab_restri varchar(255),
tab_keymod numeric(10)
) server  options(schema 'USRSIHO', table 'EMTABLAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emtabulador (
tab_keytab numeric(10) not null,
tab_keypue varchar(16) not null,
tab_monto decimal(18,2) not null,
tab_fecini timestamp(0),
tab_fecfin timestamp(0)
) server  options(schema 'USRSIHO', table 'EMTABULADOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table emusuari (
usu_keyusu numeric(10) not null,
usu_pass varchar(10) not null,
usu_nombre varchar(15) not null,
usu_apepat varchar(15) not null,
usu_apemat varchar(15) not null,
usu_fecalt timestamp(0) not null,
usu_puesto varchar(15) not null,
usu_status numeric(5) not null
) server  options(schema 'USRSIHO', table 'EMUSUARI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table encpcanr (
epc_numpco numeric(10),
epc_keydep varchar(16),
epc_fecpet timestamp(0),
epc_observ varchar(255),
epc_keyusu varchar(20),
epc_stspet numeric(10)
) server  options(schema 'USRSIHO', table 'ENCPCANR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table encpetco (
epc_numpco numeric(10),
epc_keydep varchar(16),
epc_fecpet timestamp(0),
epc_observ varchar(255),
epc_keyusu varchar(20),
epc_stspet numeric(10)
) server  options(schema 'USRSIHO', table 'ENCPETCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table encsolact (
esa_numsol numeric(10),
esa_keydep varchar(16),
esa_nomresp varchar(60),
esa_fecsol timestamp(0),
esa_fecgra timestamp(0),
esa_fecair timestamp(0),
esa_observ varchar(255),
esa_obscar varchar(255),
esa_keyusu varchar(20),
esa_stssol numeric(10),
esa_cdcori varchar(16),
esa_desori varchar(60)
) server  options(schema 'USRSIHO', table 'ENCSOLACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eocoplza (
plz_keyest varchar(3),
plz_keydep varchar(16),
plz_keypue varchar(16),
plz_keyplz numeric(5),
plz_keycat varchar(16),
plz_keyloc varchar(16),
plz_tippla varchar(2),
plz_fecini timestamp(0),
plz_fecfin timestamp(0),
plz_diavig numeric(5),
plz_turnop numeric(5),
plz_keyhor varchar(16),
plz_keyemp numeric(10),
plz_cveuoc numeric(10),
plz_cverem numeric(10),
plz_fecmov timestamp(0),
plz_submov varchar(2),
plz_cosplz decimal(14,2),
plz_ca1aux varchar(16),
plz_ca2aux varchar(16),
plz_ca3aux varchar(16),
plz_nu1aux varchar(10),
plz_nu2aux varchar(10),
plz_nu3aux varchar(10),
plz_fe1aux varchar(10),
plz_fe2aux varchar(10),
plz_fe3aux timestamp(0),
plz_co1aux decimal(14,2),
plz_co2aux decimal(14,2),
plz_co3aux decimal(14,2),
plz_co4aux decimal(14,2),
plz_co5aux decimal(14,2),
plz_keysue varchar(4),
plz_sueniv numeric(10),
plz_subniv numeric(10),
plz_cobert varchar(2),
plz_keypro numeric(5),
plz_keydpl decimal(16,6),
plz_fecocu timestamp(0),
plz_salplz decimal(12,6),
plz_titula numeric(10),
plz_origen varchar(2),
plz_valimp varchar(2),
plz_limocu timestamp(0),
plz_tiptab varchar(2)
) server  options(schema 'USRSIHO', table 'EOCOPLZA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eocorede (
red_keyest varchar(3),
red_paddep varchar(16),
red_hijdep varchar(16),
red_codniv varchar(80),
red_pesesp numeric(5),
red_numniv numeric(5)
) server  options(schema 'USRSIHO', table 'EOCOREDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eolodest (
des_keyest varchar(3),
des_desest varchar(40),
des_tipest varchar(1)
) server  options(schema 'USRSIHO', table 'EOLODEST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eoloorgn (
org_keyorg varchar(8),
org_desorg varchar(40),
org_tiporg varchar(1)
) server  options(schema 'USRSIHO', table 'EOLOORGN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eoloplan (
pla_keyest varchar(3),
pla_keydep varchar(16),
pla_keypue varchar(16),
pla_keysue varchar(4),
pla_sueniv numeric(10),
pla_subniv numeric(10),
pla_cobert varchar(2),
pla_plzocu numeric(10),
pla_tiptab varchar(2),
pla_cospla decimal(14,2),
pla_plz001 numeric(10),
pla_plz002 numeric(10),
pla_plz003 numeric(10),
pla_plz004 numeric(10),
pla_plz005 numeric(10),
pla_plz006 numeric(10),
pla_plz007 numeric(10),
pla_plz008 numeric(10),
pla_plz009 numeric(10),
pla_plz010 numeric(10),
pla_co1aux decimal(14,2),
pla_co2aux decimal(14,2),
pla_co3aux decimal(14,2),
pla_co4aux decimal(14,2),
pla_co5aux decimal(14,2),
pla_ca1aux varchar(10),
pla_ca2aux varchar(10),
pla_ca3aux varchar(10),
pla_ca4aux varchar(10),
pla_ca5aux varchar(10)
) server  options(schema 'USRSIHO', table 'EOLOPLAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eoloreor (
reo_keyorg varchar(3),
reo_keyplz numeric(10),
reo_keydep varchar(16),
reo_padplz numeric(10),
reo_paddep varchar(16),
reo_codniv varchar(80),
reo_pesesp numeric(5),
reo_numniv numeric(5),
reo_tipplz varchar(1),
reo_keypue varchar(16),
reo_ctrdir numeric(5),
reo_ctrind numeric(5)
) server  options(schema 'USRSIHO', table 'EOLOREOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table eolotplz (
tpl_numsec numeric(5),
tpl_tipplz varchar(2),
tpl_descri varchar(40),
tpl_dessec varchar(20),
tpl_catego varchar(1),
tpl_keypro numeric(5)
) server  options(schema 'USRSIHO', table 'EOLOTPLZ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table factura_erp (
poliza numeric(10) not null
) server  options(schema 'USRSIHO', table 'FACTURA_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table factura_ter (
poliza numeric(10) not null
) server  options(schema 'USRSIHO', table 'FACTURA_TER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table folios_cont (
fol_keypol numeric(10) not null,
fol_keyfol numeric(6) not null
) server  options(schema 'USRSIHO', table 'FOLIOS_CONT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoacac (
aca_keyusu numeric(10) options (key 'true') not null,
aca_keypue varchar(16) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'GLCOACAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoacar (
aca_keypro numeric(5) options (key 'true') not null,
aca_keyapr varchar(6) options (key 'true') not null,
aca_keyusu numeric(10) options (key 'true') not null,
aca_actual varchar(1)
) server  options(schema 'USRSIHO', table 'GLCOACAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoacim (
aci_keyusu numeric(5) options (key 'true') not null,
aci_keyimp varchar(15) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'GLCOACIM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoacno (
acn_keynom numeric(5) options (key 'true') not null,
acn_keyusu numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'GLCOACNO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoactc (
act_keytco varchar(6) options (key 'true') not null,
act_keyusu numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'GLCOACTC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoargu (
arg_idepro varchar(15),
arg_idepcc varchar(15),
arg_keyusu numeric(10),
arg_fecini timestamp(0),
arg_horini varchar(8),
arg_pvalor varchar(100),
arg_keycam varchar(10),
arg_descam varchar(40)
) server  options(schema 'USRSIHO', table 'GLCOARGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcobatc (
bat_idepro varchar(10),
bat_idepcc varchar(15),
bat_keyusu numeric(10),
bat_fecini timestamp(0),
bat_horini varchar(8),
bat_logusu varchar(15),
bat_keymen varchar(4),
bat_status varchar(1),
bat_valpro varchar(5),
bat_keynom numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOBATC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcobiny (
bin_keybin varchar(8),
bin_desbin varchar(35),
bin_idefun varchar(30),
bin_idever varchar(15),
bin_perfil varchar(40)
) server  options(schema 'USRSIHO', table 'GLCOBINY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
bit_desmen varchar(35),
bit_ideniv numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOBITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocaes (
cae_keyest varchar(2),
cae_desest varchar(40),
cae_aux001 varchar(10),
cae_aux002 varchar(10),
cae_fecmod timestamp(0),
cae_keyusu numeric(10)
) server  options(schema 'USRSIHO', table 'GLCOCAES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocamp (
cam_keytab varchar(40),
cam_keycam varchar(40),
cam_descam varchar(50),
cam_desaux varchar(40),
cam_descor varchar(8),
cam_valcam varchar(12)
) server  options(schema 'USRSIHO', table 'GLCOCAMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocnop (
cno_keycno varchar(8),
cno_descno varchar(35),
cno_keytab varchar(18)
) server  options(schema 'USRSIHO', table 'GLCOCNOP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocons (
con_keycvc numeric(10) not null,
con_keyemp numeric(10) not null,
con_keypro numeric(5),
con_keyapr numeric(5),
con_fecalt timestamp(0)
) server  options(schema 'USRSIHO', table 'GLCOCONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocorp (
cor_descor varchar(60)
) server  options(schema 'USRSIHO', table 'GLCOCORP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcocseg (
cse_keycno varchar(8),
cse_keymen varchar(4)
) server  options(schema 'USRSIHO', table 'GLCOCSEG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcodats (
dat_keymen varchar(4),
dat_idecam varchar(6),
dat_valore varchar(10)
) server  options(schema 'USRSIHO', table 'GLCODATS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcodetb (
det_keyusu numeric(10),
det_fecmov timestamp(0),
det_hormov varchar(8),
det_keytab varchar(18),
det_keycam varchar(18),
det_valant varchar(40),
det_valact varchar(40)
) server  options(schema 'USRSIHO', table 'GLCODETB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcodigo (
cod_keyemp numeric(10) not null,
cod_keypro numeric(5),
cod_nombre varchar(40),
cod_apllpa varchar(40),
cod_apllma varchar(40)
) server  options(schema 'USRSIHO', table 'GLCODIGO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcodocd (
dod_keydoc numeric(10),
dod_numsec numeric(5),
dod_descri varchar(100)
) server  options(schema 'USRSIHO', table 'GLCODOCD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcodocu (
doc_keydoc numeric(10),
doc_keytab varchar(18),
doc_campo1 varchar(16),
doc_campo2 varchar(16),
doc_keyuno varchar(16),
doc_keydos varchar(16),
doc_fecact timestamp(0),
doc_keyusu numeric(10)
) server  options(schema 'USRSIHO', table 'GLCODOCU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoerro (
mer_keyerr varchar(16),
mer_tiperr varchar(3),
mer_dessis varchar(125),
mer_desusu varchar(125),
mer_ayuerr varchar(250),
mer_titmos varchar(25),
mer_botmos numeric(10),
mer_icomos numeric(10),
mer_arcayu varchar(20),
mer_contex varchar(16),
mer_valdev numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOERRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoesev (
ese_keyeve varchar(16),
ese_seceve numeric(5),
ese_nivdef numeric(5),
ese_keycat varchar(4),
ese_deseve varchar(60),
ese_numeve numeric(5),
ese_induti varchar(1),
ese_indetq varchar(1),
ese_usocam varchar(14),
ese_valco1 numeric(5),
ese_valco2 numeric(5),
ese_valco3 numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOESEV', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoeven (
eve_ideper varchar(2),
eve_desper varchar(15),
eve_defaul varchar(1)
) server  options(schema 'USRSIHO', table 'GLCOEVEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcofmts (
fmt_keyfmt varchar(10),
fmt_des001 varchar(40),
fmt_des002 varchar(40),
fmt_des003 varchar(40),
fmt_keytab varchar(18),
fmt_key001 varchar(18),
fmt_key002 varchar(18),
ftm_despl1 varchar(18),
fmt_despl2 varchar(18),
fmt_cam001 varchar(18),
fmt_val001 varchar(16),
fmt_cam002 varchar(18),
fmt_val002 varchar(16),
fmt_keycia varchar(2),
fmt_fecact timestamp(0),
fmt_keyusu numeric(10),
fmt_horact varchar(8),
fmt_idepcc varchar(15)
) server  options(schema 'USRSIHO', table 'GLCOFMTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcofrmr (
frm_keycno varchar(8),
frm_numsec numeric(5),
frm_keytab varchar(18),
frm_keycam varchar(18),
frm_format varchar(19),
frm_ubicac varchar(1),
frm_ctotal varchar(1),
frm_corte1 numeric(5),
frm_idepcc varchar(15),
frm_nomcam varchar(40)
) server  options(schema 'USRSIHO', table 'GLCOFRMR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcofval (
fva_keyfmt varchar(10),
fva_val001 varchar(16),
fva_val002 varchar(16),
fva_keyent varchar(14),
fva_valent varchar(255),
fva_numren numeric(5),
fva_numcol numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOFVAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcohipa (
hip_keyusu numeric(10) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_cveusu varchar(65)
) server  options(schema 'USRSIHO', table 'GLCOHIPA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcojoin (
joi_tabori varchar(18),
joi_cmpori varchar(18),
joi_tabdes varchar(18),
joi_cmpdes varchar(18)
) server  options(schema 'USRSIHO', table 'GLCOJOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcolist (
lis_keylis varchar(12),
lis_deslis varchar(50)
) server  options(schema 'USRSIHO', table 'GLCOLIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcomenu (
men_keymen varchar(4),
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
) server  options(schema 'USRSIHO', table 'GLCOMENU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcopams (
pam_keypar varchar(4),
pam_cvesec varchar(6),
pam_nompar varchar(100),
pam_folini varchar(100),
pam_folfin varchar(100)
) server  options(schema 'USRSIHO', table 'GLCOPAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcopams_aux (
pam_keypar varchar(4),
pam_cvesec varchar(6),
pam_nompar varchar(40),
pam_folini varchar(16),
pam_folfin varchar(16)
) server  options(schema 'USRSIHO', table 'GLCOPAMS_AUX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoqrys (
qry_keycno varchar(8),
qry_querys varchar(2000),
qry_idepcc varchar(15),
qry_impdet numeric(5)
) server  options(schema 'USRSIHO', table 'GLCOQRYS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoreca (
rec_keymen varchar(4),
rec_keytab varchar(18),
rec_keycam varchar(18),
rec_actual varchar(1),
rec_despli varchar(1),
rec_valcam varchar(12)
) server  options(schema 'USRSIHO', table 'GLCORECA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
res_deserr varchar(60)
) server  options(schema 'USRSIHO', table 'GLCORESU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
) server  options(schema 'USRSIHO', table 'GLCOSEDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcoswit (
swi_keytab varchar(18),
swi_keycam varchar(18),
swi_numsec numeric(5),
swi_deswsi varchar(40)
) server  options(schema 'USRSIHO', table 'GLCOSWIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcotabl (
tab_keytab varchar(40),
tab_destab varchar(50)
) server  options(schema 'USRSIHO', table 'GLCOTABL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glcousua (
usu_keyusu numeric(10),
usu_nomusu varchar(40),
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
) server  options(schema 'USRSIHO', table 'GLCOUSUA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table gldesbita (
sbi_numrec numeric(10) not null,
sbi_keyusu numeric(10),
sbi_keynom numeric(10),
sbi_numemi numeric(10),
sbi_keypro numeric(10) not null,
sbi_keyapr varchar(6),
sbi_keyemp numeric(10),
sbi_ejerci numeric(10) not null,
sbi_fecdes varchar(10),
sbi_hordes varchar(5),
sbi_numrem numeric(10),
sbi_cvepol numeric(10),
sbi_feccob varchar(10)
) server  options(schema 'USRSIHO', table 'GLDESBITA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glwkcrys (
cry_nomrep varchar(10),
cry_idepcc varchar(15),
cry_keyusu numeric(10),
cry_numsec numeric(10),
cry_chr001 varchar(150),
cry_chr002 varchar(150),
cry_chr003 varchar(40),
cry_chr004 varchar(40),
cry_chr005 varchar(40),
cry_chr006 varchar(40),
cry_chr007 varchar(40),
cry_chr008 varchar(20),
cry_chr009 varchar(20),
cry_chr010 varchar(20),
cry_chr011 varchar(20),
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
cry_dec012 decimal(16,2),
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
) server  options(schema 'USRSIHO', table 'GLWKCRYS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glwkcrys_pru (
cry_nomrep varchar(10),
cry_idepcc varchar(15),
cry_keyusu numeric(10),
cry_numsec numeric(10),
cry_chr001 varchar(60),
cry_chr002 varchar(60),
cry_chr003 varchar(40),
cry_chr004 varchar(40),
cry_chr005 varchar(40),
cry_chr006 varchar(40),
cry_chr007 varchar(40),
cry_chr008 varchar(20),
cry_chr009 varchar(20),
cry_chr010 varchar(20),
cry_chr011 varchar(20),
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
) server  options(schema 'USRSIHO', table 'GLWKCRYS_PRU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glwklsts (
lst_keycno varchar(8),
lst_idepcc varchar(15),
lst_keyusu numeric(10),
lst_detall varchar(155),
lst_encabe varchar(155),
lst_corte1 varchar(80),
lst_corte2 varchar(80),
lst_corte3 varchar(80),
lst_total1 varchar(155),
lst_total2 varchar(155),
lst_total3 varchar(155),
lst_numsec numeric(10),
lst_impdet numeric(5)
) server  options(schema 'USRSIHO', table 'GLWKLSTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table glwkrang (
ran_nomrep varchar(10),
ran_idepcc varchar(15),
ran_keyusu numeric(10),
ran_keypro numeric(5),
ran_keyemp numeric(10),
ran_keycon varchar(3),
ran_keyper varchar(7),
ran_keydep varchar(16),
ran_keypue varchar(16),
ran_keynom numeric(5),
ran_keycat varchar(16),
ran_keycen varchar(16)
) server  options(schema 'USRSIHO', table 'GLWKRANG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table grcaerror (
err_keytvb numeric(10) not null,
err_keytdb numeric(10),
err_desusu varchar(200),
err_destec varchar(200) not null
) server  options(schema 'USRSIHO', table 'GRCAERROR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hocapanda (
cap_keydep varchar(16),
cap_keycap numeric(5),
cap_keyrph numeric(10),
cap_rphori numeric(10),
cap_fectra timestamp(0),
cap_tiprph varchar(2)
) server  options(schema 'USRSIHO', table 'HOCAPANDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hocarini (
car_ejerci numeric(10) not null,
car_keyemp numeric(10) not null,
car_nomben varchar(60),
car_keyapr varchar(6),
car_keynom numeric(5) not null,
car_numemi numeric(10) not null,
car_cvefac varchar(30),
car_stsrec numeric(5) not null,
car_import decimal(16,2),
car_fecpag timestamp(0),
car_feccob timestamp(0)
) server  options(schema 'USRSIHO', table 'HOCARINI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hocompro (
cpr_keydep varchar(30),
cpr_desdep varchar(60),
cpr_presupuesto decimal(20,2),
cpr_comprometido decimal(20,2),
cpr_ejercido decimal(20,2),
cpr_disponible decimal(20,2),
cpr_llasincon decimal(20,2),
cpr_keypue varchar(20)
) server  options(schema 'USRSIHO', table 'HOCOMPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hoctaban (
cta_keypro numeric(5) not null,
cta_keyban numeric(5) not null,
cta_ctaban varchar(11) not null,
cta_sucban varchar(4),
cta_contrato varchar(12)
) server  options(schema 'USRSIHO', table 'HOCTABAN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hoimpcon (
con_ejerci numeric(5),
con_numreg numeric(10),
con_keypro numeric(10),
con_keyare varchar(6),
con_keyemp numeric(10),
con_mesini varchar(2),
con_mesfin varchar(2),
con_rfcemp varchar(16),
con_recurp varchar(18),
con_apepat varchar(30),
con_apemat varchar(30),
con_nombre varchar(30),
con_aregeo varchar(2),
con_calanu varchar(1),
con_siasim varchar(1),
con_entfed varchar(2),
con_ingasim numeric(10),
con_israsim numeric(10),
con_stsimp varchar(1)
) server  options(schema 'USRSIHO', table 'HOIMPCON', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoacco (
acc_keytco numeric(10) not null,
acc_keyapr varchar(6) not null,
acc_keypue varchar(16) not null
) server  options(schema 'USRSIHO', table 'HOLOACCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoagcp (
agc_keyagr numeric(5) options (key 'true') not null,
agc_keycon varchar(3) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLOAGCP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoagcp01 (
agc_keyagr numeric(5) options (key 'true') not null,
agc_keycon varchar(3) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLOAGCP01', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoagcp02 (
agc_keyagr numeric(5) not null,
agc_keycon varchar(3) not null
) server  options(schema 'USRSIHO', table 'HOLOAGCP02', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoalem (
ale_keyemp numeric(10) options (key 'true') not null,
ale_marper varchar(1),
ale_fecnac timestamp(0),
ale_cranda numeric(10),
ale_calsin varchar(5),
ale_paisrs varchar(3),
ale_telem2 varchar(15),
ale_origen varchar(30),
ale_keytco numeric(10),
ale_cedula varchar(20),
ale_relpag numeric(5),
ale_keypr2 numeric(5),
ale_keyem2 numeric(10),
ale_arefis varchar(6),
ale_telem3 varchar(15),
ale_domemp varchar(60),
ale_status numeric(5),
ale_marrfc varchar(1),
ale_numint varchar(40),
ale_numext varchar(40)
) server  options(schema 'USRSIHO', table 'HOLOALEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoalgp (
gdp_keysec numeric(10) options (key 'true') not null,
gdp_keysol varchar(18),
gdp_keydep varchar(16) not null,
gdp_fechag timestamp(0) not null,
gdp_keyemp numeric(10) not null,
gdp_regrfc varchar(13),
gdp_recurp varchar(18),
gdp_keypue varchar(16) not null,
gdp_capini numeric(10) not null,
gdp_capfin numeric(10) not null,
gdp_numcap numeric(10) not null,
gdp_keycon varchar(3) not null,
gdp_marcon varchar(1) not null,
gdp_marcos varchar(1) not null,
gdp_cosuni double precision not null,
gdp_keysue varchar(4),
gdp_keytco numeric(5),
gdp_keyfol numeric(10),
gdp_keyusu numeric(10),
gdp_minleg numeric(10),
gdp_minsal numeric(10),
gdp_minext numeric(10),
gdp_mincom numeric(10),
gdp_contra numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOALGP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoalrp (
frp_keysol numeric(10) options (key 'true') not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0) not null,
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_keyrph numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOALRP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoapco (
apc_keypro numeric(5) options (key 'true') not null,
apc_keyapr varchar(6) options (key 'true') not null,
apc_keynom numeric(5) options (key 'true') not null,
apc_keycon varchar(3) options (key 'true') not null,
apc_keytfo varchar(1) options (key 'true') not null,
apc_keycom varchar(40),
apc_keycmc varchar(40),
apc_keycdf varchar(40),
apc_keycgt varchar(40)
) server  options(schema 'USRSIHO', table 'HOLOAPCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoapco2 (
apc_keypro numeric(5) not null,
apc_keyapr varchar(6),
apc_keynom numeric(5) not null,
apc_keycon varchar(3) not null,
apc_keytfo varchar(1) not null,
apc_cia varchar(3),
apc_neg varchar(2),
apc_cta varchar(3),
apc_scta varchar(6),
apc_cc varchar(8),
apc_icia varchar(3),
apc_top varchar(1),
apc_c_cia varchar(3),
apc_c_neg varchar(2),
apc_c_cta varchar(3),
apc_c_scta varchar(6),
apc_c_cc varchar(8),
apc_c_icia varchar(3),
apc_c_top varchar(1)
) server  options(schema 'USRSIHO', table 'HOLOAPCO2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocalen (
ale_fecpag timestamp(0) not null,
ale_consec varchar(3) not null,
ale_status varchar(1),
ale_forpag varchar(2)
) server  options(schema 'USRSIHO', table 'HOLOCALEN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocapi (
cap_keydep varchar(16) options (key 'true') not null,
cap_keycap numeric(10) options (key 'true') not null,
cap_descap varchar(60),
cap_nu1aux varchar(10),
cap_nu2aux varchar(10),
cap_ca1aux varchar(10),
cap_ca2aux varchar(10)
) server  options(schema 'USRSIHO', table 'HOLOCAPI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocoac (
coa_keyplz numeric(10) options (key 'true') not null,
coa_keypue varchar(16) options (key 'true') not null,
coa_cosuni decimal(13,2) not null
) server  options(schema 'USRSIHO', table 'HOLOCOAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holococa (
coc_keyplz numeric(10) not null,
coc_keycap numeric(5) not null,
coc_numsec numeric(6) not null,
coc_stspag varchar(1) not null,
coc_keyrph numeric(10),
coc_keygdp numeric(10),
coc_hjatra numeric(10),
coc_reghja numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOCOCA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocont (
con_keyplz numeric(10) not null,
con_keyfol numeric(10),
con_keytco numeric(10),
con_keydep varchar(16),
con_keypue varchar(16),
con_ctvplz numeric(10) not null,
con_keyemp numeric(10),
con_regrfc varchar(13),
con_preano numeric(5),
con_numcap numeric(5),
con_fecoto timestamp(0),
con_fecini timestamp(0) not null,
con_fecven timestamp(0),
con_keytab varchar(6),
con_pertra varchar(6),
con_idioma varchar(6),
con_keynac varchar(6),
con_cosuni decimal(13,2) not null,
con_despev varchar(80),
con_keytva numeric(5) not null,
con_keytic varchar(6),
con_diapag varchar(60),
con_tmpsal varchar(80),
con_araesp varchar(60),
con_stsfir varchar(1) not null,
con_stsplz varchar(1),
con_stspag varchar(1) not null,
con_fecfir timestamp(0),
con_feccan timestamp(0),
con_numcdi numeric(5),
con_recfis varchar(1),
con_descap varchar(80),
con_keyusg numeric(5),
con_contra varchar(20),
con_hrsjor varchar(5),
con_cccont varchar(16),
con_tippag numeric(10),
con_anopre numeric(10),
con_descan varchar(20),
con_observ varchar(80)
) server  options(schema 'USRSIHO', table 'HOLOCONT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocont_sdw (
marca_act varchar(2),
cmd varchar(15),
old_con_keyemp numeric(10),
old_con_fecini timestamp(0),
old_con_fecven timestamp(0),
old_con_keydep varchar(16),
old_con_keypue varchar(16),
new_con_keyemp numeric(10),
new_con_fecini timestamp(0),
new_con_fecven timestamp(0),
new_con_keydep varchar(16),
new_con_keypue varchar(16),
orderid1 timestamp(0),
orderid2 numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLOCONT_SDW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocont_sdw2 (
estatus varchar(1),
consec numeric(10) not null,
fecha timestamp(0),
con_keyplz numeric(10),
con_keyfol numeric(10),
con_keytco numeric(10),
con_keydep varchar(16),
con_keypue varchar(16),
con_ctvplz numeric(10),
con_keyemp numeric(10),
con_regrfc varchar(13),
con_preano numeric(10),
con_numcap numeric(10),
con_fecoto timestamp(0),
con_fecini timestamp(0),
con_fecven timestamp(0),
con_keytab varchar(6),
con_pertra varchar(6),
con_idioma varchar(6),
con_keynac varchar(6),
con_cosuni decimal(13,2),
con_despev varchar(80),
con_keytva numeric(10),
con_keytic varchar(6),
con_diapag varchar(60),
con_tmpsal varchar(80),
con_araesp varchar(60),
con_stsfir varchar(1),
con_stsplz varchar(1),
con_stspag varchar(1),
con_fecfir timestamp(0),
con_feccan timestamp(0),
con_numcdi numeric(10),
con_recfis varchar(1),
con_descap varchar(80),
con_keyusg numeric(10),
con_contra varchar(20),
con_hrsjor varchar(5)
) server  options(schema 'USRSIHO', table 'HOLOCONT_SDW2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocpfj (
cpf_repeti varchar(3) options (key 'true') not null,
cpf_keycon varchar(3) options (key 'true') not null,
cpf_keycof varchar(3) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLOCPFJ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holocusi (
cus_keyemp numeric(10) not null,
cus_keypue varchar(16) not null,
cus_keycen varchar(16) not null,
cus_porcen numeric(10),
cus_keysec varchar(4),
cus_import decimal(16,2)
) server  options(schema 'USRSIHO', table 'HOLOCUSI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodear (
dea_keydep varchar(16) options (key 'true') not null,
dea_keyapr varchar(6) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLODEAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodella (
del_keydep varchar(16) not null,
del_feclla timestamp(0) not null,
del_keytco numeric(10),
del_sindkto varchar(8),
del_keyfol numeric(10),
del_keyemp numeric(10),
del_nomcor varchar(40),
del_person varchar(40),
del_clasif varchar(40),
del_noforo varchar(20),
del_hralla varchar(10),
del_hraent varchar(10),
del_hrasal varchar(10),
del_hratra varchar(10),
del_capgra varchar(60),
del_status varchar(4),
del_stspag varchar(1),
del_keyaut varchar(15),
del_inanda varchar(1),
del_ultact timestamp(0),
del_fecpag timestamp(0),
del_keyrph numeric(10),
del_keynom numeric(5),
del_cdilla numeric(10),
del_capini numeric(10),
del_capfin numeric(10),
del_auxnu1 numeric(10),
del_auxnu2 numeric(10),
del_auxca1 varchar(150),
del_auxca2 varchar(20),
del_usuori varchar(15) not null,
del_fecori timestamp(0) not null,
del_usufin varchar(15),
del_fecfin timestamp(0),
del_numfol numeric(10) not null
) server  options(schema 'USRSIHO', table 'HOLODELLA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodetlla (
det_serial numeric(10) not null,
det_num_id numeric(10) not null,
det_keydep varchar(16),
det_feclla timestamp(0) not null,
det_keytco numeric(10),
det_sindkto varchar(15),
det_keyfol numeric(10),
det_keyemp numeric(10),
det_nomcor varchar(40),
det_person varchar(40),
det_keypue varchar(16),
det_noforo varchar(20),
det_hralla varchar(10),
det_ultact timestamp(0),
det_auxnu1 numeric(10),
det_auxnu2 numeric(10),
det_auxca1 varchar(150),
det_auxca2 varchar(20),
det_usuori varchar(15) not null,
det_tipinc varchar(2),
det_stslla varchar(1),
det_cdilla numeric(10),
det_cosuni decimal(12,2),
det_solscc numeric(10),
det_regsol numeric(10)
) server  options(schema 'USRSIHO', table 'HOLODETLLA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodetp (
det_keypol numeric(10) options (key 'true') not null,
det_cuenta varchar(40) options (key 'true') not null,
det_cargos decimal(16,2),
det_abonos decimal(16,2)
) server  options(schema 'USRSIHO', table 'HOLODETP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodetp1 (
det_keypol numeric(10) options (key 'true') not null,
det_keyfol numeric(6) options (key 'true') not null,
det_cuenta varchar(40) options (key 'true') not null,
det_cargos decimal(16,6),
det_abonos decimal(16,6),
det_sec_sindical varchar(50) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLODETP1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodetp2 (
det_keypol numeric(10) not null,
det_keyfol numeric(6),
det_cuenta varchar(40) not null,
det_cargos decimal(16,6),
det_abonos decimal(16,6),
det_keypue varchar(16),
det_caietu numeric(10),
det_sec_sindical varchar(50)
) server  options(schema 'USRSIHO', table 'HOLODETP2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodettra (
det_serial numeric(10) not null,
det_num_id numeric(10) not null,
det_keydep varchar(16) not null,
det_fecgra timestamp(0) not null,
det_keytco numeric(10),
det_sindkto varchar(15),
det_keyfol numeric(10),
det_keyemp numeric(10),
det_nomcor varchar(40),
det_person varchar(40),
det_keypue varchar(16),
det_keycon varchar(5),
det_noforo varchar(20),
det_hralla varchar(5),
det_hraent varchar(5),
det_hrasal varchar(5),
det_hrstra decimal(6,2),
det_capgra varchar(60),
det_stsreg varchar(1),
det_stspag varchar(1),
det_keyaut varchar(15),
det_inanda varchar(1),
det_ultact timestamp(0),
det_fecpag timestamp(0),
det_keyrph numeric(10),
det_keynom numeric(5),
det_cdilla numeric(10),
det_capini numeric(5),
det_capfin numeric(5),
det_auxnu1 numeric(10),
det_auxnu2 numeric(10),
det_auxca1 varchar(150),
det_auxca2 varchar(20),
det_usuori varchar(15) not null,
det_fecori timestamp(0),
det_usufin varchar(15),
det_fecfin timestamp(0),
det_tipinc varchar(2),
det_cosuni decimal(12,2),
det_numlla numeric(10),
det_honint numeric(5),
det_acomen numeric(38)
) server  options(schema 'USRSIHO', table 'HOLODETTRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodettra_xx (
det_num_id numeric(10),
det_serial numeric(10),
det_keyemp numeric(10),
det_keyfol numeric(10),
tco varchar(15)
) server  options(schema 'USRSIHO', table 'HOLODETTRA_XX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holodtemp (
det_keypol numeric(10),
det_keyfol numeric(6),
det_cuenta varchar(40),
det_cargos decimal(16,6),
det_abonos decimal(16,6)
) server  options(schema 'USRSIHO', table 'HOLODTEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoenclla (
enc_num_id numeric(10) not null,
enc_keydep varchar(16),
enc_feclla timestamp(0),
enc_keytpr varchar(6),
enc_nomprd varchar(60),
enc_feccap timestamp(0) not null,
enc_keypro numeric(5),
enc_usuori varchar(15),
enc_auxnu1 numeric(10),
enc_auxca1 varchar(60),
enc_solscc numeric(10),
enc_stslla numeric(10),
enc_hjatra numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOENCLLA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoenctra (
enc_num_id numeric(10) not null,
enc_keydep varchar(16) not null,
enc_fecgra timestamp(0),
enc_fecpag timestamp(0),
enc_keytpr varchar(6),
enc_nomprd varchar(60),
enc_feccap timestamp(0) not null,
enc_horcom varchar(20),
enc_keypro numeric(5),
enc_usuori varchar(15),
enc_stsrep varchar(1),
enc_feclib timestamp(0),
enc_horlib varchar(5),
enc_gcxxii varchar(1),
enc_entcom varchar(5),
enc_salcom varchar(5),
enc_auxnu1 numeric(10),
enc_auxca1 varchar(20),
enc_desscc varchar(60),
enc_numlla numeric(10),
enc_conlla varchar(1),
enc_descap varchar(60)
) server  options(schema 'USRSIHO', table 'HOLOENCTRA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoenlla (
enl_numfol numeric(10) not null,
enl_keydep varchar(16) not null,
enl_feclla timestamp(0),
enl_keytpr varchar(6),
enl_nomprd varchar(60),
enl_feccap timestamp(0) not null,
enl_horcom varchar(20),
enl_keypro numeric(5),
enl_auxnu1 numeric(10),
enl_auxca1 varchar(20)
) server  options(schema 'USRSIHO', table 'HOLOENLLA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoequi (
equ_keypro numeric(5) not null,
equ_keynom numeric(5) not null,
equ_keyapr numeric(5) not null,
equ_equiva varchar(16) not null
) server  options(schema 'USRSIHO', table 'HOLOEQUI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holofirp (
fir_keypro numeric(5) options (key 'true') not null,
fir_keyapr varchar(6) options (key 'true') not null,
fir_keynom numeric(5) options (key 'true') not null,
fir_keydep varchar(16) options (key 'true') not null,
fir_codvb1 numeric(10),
fir_codvb2 numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOFIRP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holofrph (
frp_keyrph numeric(10) options (key 'true') not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0),
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1),
frp_keyare varchar(6),
frp_desrep varchar(40),
frp_descap varchar(100)
) server  options(schema 'USRSIHO', table 'HOLOFRPH', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holofrph1 (
frp_keyrph numeric(10) options (key 'true') not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0) not null,
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1)
) server  options(schema 'USRSIHO', table 'HOLOFRPH1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holofrph_aux (
frp_keyrph numeric(10) not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0) not null,
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1),
frp_keyare varchar(6),
frp_desrep varchar(40),
frp_descap varchar(100)
) server  options(schema 'USRSIHO', table 'HOLOFRPH_AUX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holofrph_tmp (
frp_keyrph numeric(10) options (key 'true') not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0) not null,
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1),
frp_keyare varchar(6),
frp_desrep varchar(40),
frp_descap varchar(100)
) server  options(schema 'USRSIHO', table 'HOLOFRPH_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hologdpr (
gdp_keysec numeric(10) options (key 'true') not null,
gdp_keydep varchar(16),
gdp_keyrph numeric(10) not null,
gdp_fechag timestamp(0) not null,
gdp_keyemp numeric(10) not null,
gdp_regrfc varchar(13),
gdp_recurp varchar(18),
gdp_keypue varchar(16) not null,
gdp_capini numeric(10) not null,
gdp_capfin numeric(10) not null,
gdp_numcap numeric(10) not null,
gdp_keycon varchar(3) not null,
gdp_marcon varchar(1) not null,
gdp_marcos varchar(1) not null,
gdp_cosuni double precision not null,
gdp_keysue varchar(4),
gdp_keytco numeric(5),
gdp_keyfol numeric(10),
gdp_keyusu numeric(10),
gdp_minleg numeric(10),
gdp_minsal numeric(10),
gdp_minext numeric(10),
gdp_mincom numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOGDPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hologdpr1 (
gdp_keysec numeric(10) options (key 'true') not null,
gdp_keydep varchar(16) not null,
gdp_keyrph numeric(10) not null,
gdp_fechag timestamp(0) not null,
gdp_keyemp numeric(10) not null,
gdp_regrfc varchar(13),
gdp_recurp varchar(18),
gdp_keypue varchar(16) not null,
gdp_capini numeric(10) not null,
gdp_capfin numeric(10) not null,
gdp_numcap numeric(10) not null,
gdp_keycon varchar(3) not null,
gdp_marcon varchar(1) not null,
gdp_marcos varchar(1) not null,
gdp_cosuni double precision not null,
gdp_keysue varchar(4),
gdp_keytco numeric(5),
gdp_keyfol numeric(10),
gdp_keyusu numeric(10),
gdp_minleg numeric(10),
gdp_minsal numeric(10),
gdp_minext numeric(10),
gdp_mincom numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOGDPR1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hologlpr (
glp_keydep varchar(16) options (key 'true') not null,
glp_keypue varchar(16) options (key 'true') not null,
glp_presup decimal(16,2) not null,
glp_ejerci decimal(16,2) not null,
glp_pagado decimal(16,2),
glp_anio numeric(5) options (key 'true') not null,
glp_status varchar(1)
) server  options(schema 'USRSIHO', table 'HOLOGLPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holohgdp (
hgd_keysec numeric(10) options (key 'true') not null,
hgd_keydep varchar(16),
hgd_keyrph numeric(10),
hgd_fechag timestamp(0),
hgd_keyemp numeric(10),
hgd_regrfc varchar(13),
hgd_recurp varchar(18),
hgd_keypue varchar(16),
hgd_capini numeric(10),
hgd_capfin numeric(10),
hgd_numcap numeric(10),
hgd_keycon varchar(3),
hgd_marcon varchar(1),
hgd_marcos varchar(1),
hgd_costog double precision,
hgd_keysue varchar(4),
hgd_keytco numeric(5),
hgd_keyfol numeric(6),
hgd_keyusu numeric(10),
hgd_minleg numeric(6),
hgd_minsal numeric(6),
hgd_minext numeric(6),
hgd_mincom numeric(6)
) server  options(schema 'USRSIHO', table 'HOLOHGDP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holohgdp_tmp (
hgd_keysec numeric(10) options (key 'true') not null,
hgd_keydep varchar(16),
hgd_keyrph numeric(10),
hgd_fechag timestamp(0),
hgd_keyemp numeric(10),
hgd_regrfc varchar(13),
hgd_recurp varchar(18),
hgd_keypue varchar(16),
hgd_capini numeric(10),
hgd_capfin numeric(10),
hgd_numcap numeric(10),
hgd_keycon varchar(3),
hgd_marcon varchar(1),
hgd_marcos varchar(1),
hgd_costog double precision,
hgd_keysue varchar(4),
hgd_keytco numeric(3),
hgd_keyfol numeric(6),
hgd_keyusu numeric(10),
hgd_minleg numeric(6),
hgd_minsal numeric(6),
hgd_minext numeric(6),
hgd_mincom numeric(6)
) server  options(schema 'USRSIHO', table 'HOLOHGDP_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holohoex (
hoe_pertra varchar(3) not null,
hoe_jornad varchar(2),
hoe_keytpr varchar(1),
hoe_jorcos decimal(13,2),
hoe_jortie decimal(13,2)
) server  options(schema 'USRSIHO', table 'HOLOHOEX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holonopu (
nop_keynom numeric(5) options (key 'true') not null,
nop_keypue varchar(16) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'HOLONOPU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holopaco (
pac_keytco varchar(6) options (key 'true') not null,
pac_keyvar numeric(5) options (key 'true') not null,
pac_desvar varchar(40),
pac_select varchar(250) not null,
pac_varwor varchar(20) not null,
pac_tipdat varchar(1) not null,
pac_nalias varchar(10) not null
) server  options(schema 'USRSIHO', table 'HOLOPACO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoplza (
plz_ctvplz numeric(10) not null,
plz_keyfol numeric(10),
plz_keytco numeric(10),
plz_keydep varchar(16),
plz_keypue varchar(16),
plz_keyemp numeric(10),
plz_numcap numeric(5),
plz_keytab varchar(10),
plz_cosuni decimal(13,2) not null,
plz_keytva numeric(5) not null,
plz_status numeric(10),
plz_fecini timestamp(0),
plz_fecalt timestamp(0),
plz_keyusg numeric(5),
plz_hrsmod varchar(5),
plz_capini numeric(10),
plz_capfin numeric(10),
plz_emptemp numeric(10),
plz_mtomax decimal(13,2),
plz_mtoeje decimal(13,2),
plz_periodo varchar(10),
plz_primaria varchar(2),
plz_fecven timestamp(0),
plz_excep varchar(2),
plz_asig numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOPLZA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holopoli (
pol_keypol numeric(10) options (key 'true') not null,
pol_ctvpol numeric(5) options (key 'true') not null,
pol_keypro numeric(5),
pol_keyapr varchar(6) not null,
pol_keynom numeric(5),
pol_numemi numeric(5) not null,
pol_tippol varchar(1) not null,
pol_stspol varchar(1) not null,
pol_cvepol varchar(30),
pol_fecpol timestamp(0) not null,
pol_percon varchar(10) not null,
pol_numrem numeric(10),
pol_remrec numeric(10),
pol_totcar decimal(16,2) not null,
pol_totabo decimal(16,2) not null,
pol_carpas decimal(16,2),
pol_abopas decimal(16,2),
pol_usugen numeric(10),
pol_fecgen timestamp(0),
pol_usurem numeric(10),
pol_fecrem timestamp(0),
pol_usuaut numeric(10),
pol_fecaut timestamp(0),
pol_contra varchar(40),
pol_semana numeric(5),
pol_tipcta numeric(5),
pol_keymad numeric(10),
pol_ctvmad numeric(5)
) server  options(schema 'USRSIHO', table 'HOLOPOLI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holopoli1 (
pol_keypol numeric(10) options (key 'true') not null,
pol_ctvpol numeric(5) options (key 'true') not null,
pol_keypro numeric(5),
pol_keyapr varchar(6) not null,
pol_keynom numeric(5),
pol_numemi numeric(5) not null,
pol_keyrec numeric(10) not null,
pol_keyemp numeric(10) not null,
pol_regrfc varchar(18),
pol_emipag varchar(10),
pol_tippol varchar(1) not null,
pol_stspol varchar(1) not null,
pol_cvepol varchar(50),
pol_fecpol timestamp(0) not null,
pol_percon varchar(10) not null,
pol_numrem numeric(10),
pol_remrec numeric(10),
pol_totcar decimal(16,6) not null,
pol_totabo decimal(16,6) not null,
pol_carpas decimal(16,6),
pol_abopas decimal(16,6),
pol_usugen numeric(10),
pol_fecgen timestamp(0),
pol_usurem numeric(10),
pol_fecrem timestamp(0),
pol_usuaut numeric(10),
pol_fecaut timestamp(0),
pol_contra varchar(40),
pol_semana numeric(5),
pol_tipcta numeric(5),
pol_keymad numeric(10),
pol_ctvmad numeric(5),
pol_regfis varchar(4),
pol_forpag numeric(5),
pol_tipcam decimal(16,6),
pol_fpafin numeric(10),
pol_tcafin decimal(16,6),
pol_auxnu1 numeric(10),
pol_auxca1 varchar(20)
) server  options(schema 'USRSIHO', table 'HOLOPOLI1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holopres (
pre_keydep varchar(16) options (key 'true') not null,
pre_keypue varchar(16) options (key 'true') not null,
pre_presup decimal(16,2) not null,
pre_ejerci decimal(16,2) not null,
pre_pagado decimal(16,2),
pre_anio numeric(5) options (key 'true') not null,
pre_status varchar(1)
) server  options(schema 'USRSIHO', table 'HOLOPRES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoptemp (
pol_keypol numeric(10),
pol_ctvpol numeric(5),
pol_keypro numeric(5),
pol_keyapr varchar(6),
pol_keynom numeric(5),
pol_numemi numeric(5),
pol_keyrec numeric(10),
pol_keyemp numeric(10),
pol_regrfc varchar(13),
pol_emipag varchar(10),
pol_tippol varchar(1),
pol_stspol varchar(1),
pol_cvepol varchar(50),
pol_fecpol timestamp(0),
pol_percon varchar(10),
pol_numrem numeric(10),
pol_remrec numeric(10),
pol_totcar decimal(16,6),
pol_totabo decimal(16,6),
pol_carpas decimal(16,6),
pol_abopas decimal(16,6),
pol_usugen numeric(10),
pol_fecgen timestamp(0),
pol_usurem numeric(10),
pol_fecrem timestamp(0),
pol_usuaut numeric(10),
pol_fecaut timestamp(0),
pol_contra varchar(40),
pol_semana numeric(5),
pol_tipcta numeric(5),
pol_keymad numeric(10),
pol_ctvmad numeric(5),
pol_regfis varchar(4),
pol_forpag numeric(5),
pol_tipcam decimal(16,6),
pol_fpafin numeric(10),
pol_tcafin decimal(16,6),
pol_auxnu1 numeric(10),
pol_auxca1 varchar(20)
) server  options(schema 'USRSIHO', table 'HOLOPTEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoreci (
rec_ejerci numeric(10) options (key 'true') not null,
rec_keypro numeric(5) options (key 'true') not null,
rec_keyrec numeric(10) options (key 'true') not null,
rec_keyemp numeric(10) not null,
rec_keyapr varchar(20) not null,
rec_keynom numeric(5) not null,
rec_numemi numeric(10) not null,
rec_stsrec numeric(5) not null,
rec_numrem numeric(10),
rec_import decimal(16,2),
rec_fecpag timestamp(0),
rec_feccob timestamp(0),
rec_keyusg numeric(5) not null,
rec_fecact timestamp(0) not null,
rec_keyusc numeric(5),
rec_keypol numeric(10),
rec_stsfis varchar(1),
rec_fecfis timestamp(0),
rec_remtra varchar(20),
rec_stsfon numeric(5),
rec_impiva decimal(16,2),
rec_impisr timestamp(0),
rec_stscon numeric(5)
) server  options(schema 'USRSIHO', table 'HOLORECI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoreci_ter (
rec_ejerci numeric(10) options (key 'true') not null,
rec_keypro numeric(5) options (key 'true') not null,
rec_keyrec numeric(10) options (key 'true') not null,
rec_keyemp numeric(10) not null,
rec_regrfc varchar(13) not null,
rec_cvefac varchar(50) not null,
rec_keyapr varchar(6) not null,
rec_keynom numeric(5) not null,
rec_numemi numeric(10) not null,
rec_stsrec numeric(5) not null,
rec_numrem numeric(10),
rec_import decimal(16,2),
rec_fecpag timestamp(0),
rec_feccob timestamp(0),
rec_keyusg numeric(5) not null,
rec_fecact timestamp(0) not null,
rec_keyusc numeric(5),
rec_keypol numeric(10),
rec_stsfis varchar(1),
rec_fecfis timestamp(0),
rec_remtra varchar(20),
rec_stsfon numeric(5),
rec_impiva decimal(16,2),
rec_impisr timestamp(0),
rec_stscon numeric(5)
) server  options(schema 'USRSIHO', table 'HOLORECI_TER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoreci_tmp (
rec_ejerci numeric(10) options (key 'true') not null,
rec_keypro numeric(5) options (key 'true') not null,
rec_keyrec numeric(10) options (key 'true') not null,
rec_keyemp numeric(10) not null,
rec_keyapr varchar(6) not null,
rec_keynom numeric(5) not null,
rec_numemi numeric(10) not null,
rec_stsrec numeric(5) not null,
rec_numrem numeric(10),
rec_import decimal(16,2),
rec_fecpag timestamp(0),
rec_feccob timestamp(0),
rec_keyusg numeric(5) not null,
rec_fecact timestamp(0) not null,
rec_keyusc numeric(5),
rec_keypol numeric(10),
rec_stsfis varchar(1),
rec_fecfis timestamp(0),
rec_remtra varchar(20),
rec_stsfon numeric(5),
rec_impiva decimal(16,2),
rec_impisr timestamp(0),
rec_stscon numeric(5)
) server  options(schema 'USRSIHO', table 'HOLORECI_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holorecp (
rec_numsec numeric(10),
rec_keypro numeric(5),
rec_keyper varchar(7),
rec_keyemp numeric(10),
rec_import decimal(16,2),
rec_descia varchar(60),
rec_implet varchar(100),
rec_nomemp varchar(100),
rec_porcen decimal(16,2),
rec_oficio varchar(20),
rec_fecofc timestamp(0),
rec_autori varchar(80),
rec_numex varchar(10),
rec_banco varchar(20),
rec_cuenta varchar(20),
rec_nomben varchar(60),
rec_fecpag timestamp(0),
rec_keyare varchar(4),
rec_emision varchar(5),
rec_keyben numeric(5),
rec_ejerci numeric(5) not null
) server  options(schema 'USRSIHO', table 'HOLORECP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoreme (
rem_keypro numeric(5) options (key 'true') not null,
rem_keyapr varchar(6) options (key 'true') not null,
rem_keytir varchar(1) options (key 'true') not null,
rem_keyrem numeric(10) options (key 'true') not null,
rem_stsrem varchar(6) not null,
rem_keyusr numeric(5) not null,
rem_fecrem timestamp(0) not null,
rem_keyusa numeric(5),
rem_fecaut timestamp(0)
) server  options(schema 'USRSIHO', table 'HOLOREME', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holorepo (
rep_keyrep numeric(10) options (key 'true') not null,
rep_desrep varchar(60),
rep_proyec varchar(20),
rep_keyusu numeric(5) not null,
rep_fechag timestamp(0),
rep_rutarp varchar(60),
rep_status varchar(1)
) server  options(schema 'USRSIHO', table 'HOLOREPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holoretr (
ret_keyrph numeric(10),
ret_keyrpv numeric(10),
ret_status varchar(1),
ret_keyusu numeric(10),
ret_logusu varchar(15),
ret_idepcc varchar(15),
ret_fecmov timestamp(0),
ret_hormov varchar(8)
) server  options(schema 'USRSIHO', table 'HOLORETR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holosoco (
soc_keysol numeric(10) not null,
soc_keymot varchar(6),
soc_keyemp numeric(10),
soc_fecsol timestamp(0) not null,
soc_aresol numeric(10),
soc_nomemp varchar(60) not null,
soc_nomcor varchar(40),
soc_domemp varchar(60),
soc_colemp varchar(20),
soc_cidemp varchar(20),
soc_pobemp varchar(20),
soc_munemp varchar(6),
soc_entemp varchar(2),
soc_codemp varchar(5),
soc_telem1 varchar(10),
soc_telem2 varchar(10),
soc_telem3 varchar(10),
soc_regrfc varchar(13) not null,
soc_recurp varchar(20),
soc_cvesex varchar(1),
soc_refcon varchar(6),
soc_cveban varchar(7),
soc_ctaban varchar(16),
soc_forpag varchar(2),
soc_fecing timestamp(0),
soc_ca2aux varchar(10),
soc_ca3aux varchar(10),
soc_fecnac timestamp(0),
soc_paisrs varchar(3),
soc_origen varchar(30),
soc_cedula varchar(20),
soc_calsin varchar(5),
soc_keysih numeric(10)
) server  options(schema 'USRSIHO', table 'HOLOSOCO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holotabs (
tab_keypro numeric(5) options (key 'true') not null,
tab_keytab varchar(6) options (key 'true') not null,
tab_keypue varchar(16) options (key 'true') not null,
tab_pertra varchar(6) options (key 'true') not null,
tab_idioma varchar(6) options (key 'true') not null,
tab_keynac varchar(6) options (key 'true') not null,
tab_import decimal(16,2) not null,
tab_fecini timestamp(0) options (key 'true') not null,
tab_fecfin timestamp(0)
) server  options(schema 'USRSIHO', table 'HOLOTABS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holotco2 (
con_idepcc varchar(15),
con_keyusu numeric(10),
con_keyfol numeric(10),
emp_nomemp varchar(60),
con_keyemp numeric(10),
emp_nomcor varchar(40),
con_desnac varchar(30),
con_cvesex varchar(40),
emp_regrfc varchar(13),
ale_cranda numeric(10),
con_araesp varchar(60),
emp_domemp varchar(102),
emp_colemp varchar(20),
emp_codemp varchar(5),
con_delega varchar(40),
emp_telemp varchar(40),
con_keydep varchar(16),
dep_desdep varchar(40),
pue_despue varchar(80),
con_keytic varchar(40),
con_fecini timestamp(0),
con_descap varchar(80),
con_tmpsal varchar(80),
con_cosuni decimal(13,2),
con_cosun2 varchar(80),
con_fecoto timestamp(0),
ale_calsin varchar(5),
con_keypue varchar(16),
con_contra varchar(20),
con_hrsjor varchar(5),
emp_recurp varchar(18)
) server  options(schema 'USRSIHO', table 'HOLOTCO2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holotco3 (
con_idepcc varchar(15),
con_keyusu numeric(10),
emp_nomemp varchar(60),
con_keyemp numeric(10),
con_keyfol numeric(10),
emp_nomcor varchar(40),
emp_domemp varchar(102),
emp_colemp varchar(20),
emp_codemp varchar(5),
con_delega varchar(40),
con_desnac varchar(30),
emp_regrfc varchar(13),
dep_desdep varchar(40),
con_despev varchar(80),
con_tmpsal varchar(80),
pue_despue varchar(40),
con_cosuni decimal(13,2),
con_cosun2 varchar(80),
con_keytic varchar(40),
con_fecini timestamp(0),
con_descap varchar(80),
con_araesp varchar(60),
emp_homo varchar(3),
con_keydep varchar(16),
con_keypue varchar(16),
con_fecoto timestamp(0),
con_contra varchar(20),
con_hrsjor varchar(5),
emp_recurp varchar(18)
) server  options(schema 'USRSIHO', table 'HOLOTCO3', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holousau (
usa_keypro numeric(5) options (key 'true') not null,
usa_keyapr varchar(6) options (key 'true') not null,
usa_keyusu numeric(10) options (key 'true') not null,
usa_passwd varchar(20) not null
) server  options(schema 'USRSIHO', table 'HOLOUSAU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table holo_tmp (
frp_keyrph numeric(10) options (key 'true') not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0),
frp_stsfol varchar(1) not null,
frp_totcos decimal(15,2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16,6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15,2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1),
frp_keyare varchar(6),
frp_desrep varchar(40),
frp_descap varchar(100)
) server  options(schema 'USRSIHO', table 'HOLO_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hotmcoac (
coa_keypue varchar(16),
coa_cosuni decimal(13,2)
) server  options(schema 'USRSIHO', table 'HOTMCOAC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hotmcoac_tmp (
coa_keypue varchar(16),
coa_cosuni decimal(13,2)
) server  options(schema 'USRSIHO', table 'HOTMCOAC_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hotmcoca (
coc_keycap numeric(5)
) server  options(schema 'USRSIHO', table 'HOTMCOCA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hotmcoca_tmp (
coc_keycap numeric(5)
) server  options(schema 'USRSIHO', table 'HOTMCOCA_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hrepejec (
eje_keynom numeric(5) not null,
eje_numemi varchar(6) not null,
eje_keyapr varchar(6) not null,
eje_nummes numeric(5) not null,
eje_numcap numeric(5),
eje_keyemp numeric(10) not null,
eje_keytpr varchar(6),
eje_keydep varchar(16) not null,
eje_keypue varchar(16) not null,
eje_regfis varchar(6),
eje_plazas numeric(5),
eje_person numeric(5),
eje_grupos varchar(6),
eje_tipfol varchar(6),
eje_tipcam varchar(6),
eje_ssctas varchar(10),
eje_basess decimal(16,2),
eje_otring decimal(16,2),
eje_tiextr decimal(16,2),
eje_prevso decimal(16,2),
eje_sindic decimal(16,2),
eje_ivaacr decimal(16,2),
eje_ivapen decimal(16,2),
eje_ispttt decimal(16,2),
eje_isrnac decimal(16,2),
eje_isrext decimal(16,2),
eje_pensio decimal(16,2),
eje_otrdes decimal(16,2),
eje_cuocen decimal(16,2),
eje_secci1 decimal(16,2),
eje_secci6 decimal(16,2),
eje_secc10 decimal(16,2),
eje_secc12 decimal(16,2),
eje_cuomus decimal(16,2),
eje_ivaret decimal(16,2),
eje_stspag varchar(3),
eje_fecpag timestamp(0),
eje_fecgen timestamp(0),
eje_keypro numeric(10),
eje_fecmov timestamp(0),
eje_ejerci numeric(5)
) server  options(schema 'USRSIHO', table 'HREPEJEC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hrepejec01 (
eje_keynom numeric(5) not null,
eje_numemi varchar(6) not null,
eje_keyapr varchar(6) not null,
eje_nummes numeric(5) not null,
eje_numcap numeric(5),
eje_keyemp numeric(10) not null,
eje_keytpr varchar(6),
eje_keydep varchar(16) not null,
eje_keypue varchar(16) not null,
eje_regfis varchar(6),
eje_plazas numeric(5),
eje_person numeric(5),
eje_grupos varchar(6),
eje_tipfol varchar(6),
eje_tipcam varchar(6),
eje_ssctas varchar(10),
eje_basess decimal(16,2),
eje_otring decimal(16,2),
eje_tiextr decimal(16,2),
eje_prevso decimal(16,2),
eje_sindic decimal(16,2),
eje_ivaacr decimal(16,2),
eje_ivapen decimal(16,2),
eje_ispttt decimal(16,2),
eje_isrnac decimal(16,2),
eje_isrext decimal(16,2),
eje_pensio decimal(16,2),
eje_otrdes decimal(16,2),
eje_cuocen decimal(16,2),
eje_secci1 decimal(16,2),
eje_secci6 decimal(16,2),
eje_secc10 decimal(16,2),
eje_secc12 decimal(16,2),
eje_cuomus decimal(16,2),
eje_ivaret decimal(16,2),
eje_stspag varchar(3),
eje_fecpag timestamp(0),
eje_fecgen timestamp(0),
eje_keypro numeric(10)
) server  options(schema 'USRSIHO', table 'HREPEJEC01', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table hrpineje (
nej_rphant numeric(10),
nej_rphnew numeric(10),
nej_keyper varchar(7),
nej_status varchar(1)
) server  options(schema 'USRSIHO', table 'HRPINEJE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table inlodwor (
dwo_keywor varchar(4),
dwo_numsec numeric(5),
dwo_tipdat varchar(1),
dwo_funcio varchar(2),
dwo_format varchar(30),
dwo_valorw varchar(60),
dwo_numsql numeric(5),
dwo_seccmp numeric(5)
) server  options(schema 'USRSIHO', table 'INLODWOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table inlodwsq (
dws_keywor varchar(4),
dws_numsql numeric(5),
dws_numsec numeric(5),
dws_sqlaso numeric(5),
dws_seccmp numeric(5),
dws_descmp varchar(20)
) server  options(schema 'USRSIHO', table 'INLODWSQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table inloword (
wor_keywor varchar(4),
wor_deswor varchar(40),
wor_docwor varchar(40)
) server  options(schema 'USRSIHO', table 'INLOWORD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table inlowsql (
wsq_keywor varchar(4),
wsq_numsql numeric(5),
wsq_sqlsql varchar(2000)
) server  options(schema 'USRSIHO', table 'INLOWSQL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table menus_siho (
men_keyusu numeric(5),
men_idefun varchar(15),
men_desfun varchar(60)
) server  options(schema 'USRSIHO', table 'MENUS_SIHO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcodeps (
dep_keydep varchar(16) options (key 'true') not null,
dep_desdep varchar(40),
dep_refcon varchar(20),
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
) server  options(schema 'USRSIHO', table 'NMCODEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcodeps_aux (
dep_keydep varchar(16),
dep_desdep varchar(40),
dep_refcon varchar(20),
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
) server  options(schema 'USRSIHO', table 'NMCODEPS_AUX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcodeps_sdw (
marca_act varchar(2),
cmd varchar(15),
old_dep_keydep varchar(16),
old_dep_desdep varchar(40),
new_dep_keydep varchar(16),
new_dep_desdep varchar(40),
orderid1 timestamp(0),
orderid2 numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'NMCODEPS_SDW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcoempl (
emp_keyemp numeric(10),
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(150),
emp_nomcor varchar(40),
emp_domemp varchar(60),
emp_colemp varchar(40),
emp_cidemp varchar(40),
emp_pobemp varchar(40),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(15),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(5),
emp_keypro numeric(5),
emp_cvetur numeric(5),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(5),
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,6),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(5),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2)
) server  options(schema 'USRSIHO', table 'NMCOEMPL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcoempl01 (
emp_keyemp numeric(10),
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60),
emp_nomcor varchar(40),
emp_domemp varchar(30),
emp_colemp varchar(20),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(10),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(5),
emp_keypro numeric(5),
emp_cvetur numeric(5),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(5),
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,6),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(16),
emp_forpag varchar(2),
emp_diades numeric(5),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2)
) server  options(schema 'USRSIHO', table 'NMCOEMPL01', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcoempl2 (
emp_keyemp numeric(10),
emp_keydep varchar(16),
emp_keypue varchar(16),
emp_keycen varchar(16),
emp_keycat varchar(16),
emp_nomemp varchar(60),
emp_nomcor varchar(40),
emp_domemp varchar(30),
emp_colemp varchar(20),
emp_cidemp varchar(20),
emp_pobemp varchar(20),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(10),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_reginf varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(5),
emp_cvezon numeric(5),
emp_keypro numeric(5),
emp_cvetur numeric(5),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(5),
emp_salhor decimal(12,6),
emp_saldia decimal(12,6),
emp_salmes decimal(12,2),
emp_salint decimal(12,6),
emp_salivc decimal(12,6),
emp_salinf decimal(12,6),
emp_intsin decimal(12,6),
emp_infsin decimal(12,6),
emp_varims decimal(12,6),
emp_varinf decimal(12,6),
emp_anthor decimal(12,6),
emp_antdia decimal(12,6),
emp_antmes decimal(12,6),
emp_antint decimal(12,6),
emp_antivc decimal(12,6),
emp_antinf decimal(12,6),
emp_antits decimal(12,6),
emp_antifs decimal(12,6),
emp_refcon varchar(20),
emp_cveban varchar(7),
emp_ctaban varchar(18),
emp_forpag varchar(2),
emp_diades numeric(5),
emp_numliq varchar(6),
emp_keyloc varchar(16),
emp_fecing timestamp(0),
emp_fecrei timestamp(0),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_fecaum timestamp(0),
emp_peraum varchar(7),
emp_fecbaj timestamp(0),
emp_cvebaj varchar(4),
emp_jorlab varchar(1),
emp_unijor decimal(4,2),
emp_pering varchar(7),
emp_perbaj varchar(7),
emp_perdep varchar(7),
emp_perpue varchar(7),
emp_percat varchar(7),
emp_perpro varchar(7),
emp_fecaux timestamp(0),
emp_ca1aux varchar(10),
emp_ca2aux varchar(10),
emp_ca3aux varchar(10),
emp_ca4aux varchar(10),
emp_pctbec decimal(5,2),
emp_fecmod timestamp(0),
emp_hormod varchar(8),
emp_fecalt timestamp(0),
emp_bajfec timestamp(0),
emp_fecsal timestamp(0),
emp_perpag varchar(7),
emp_inifec timestamp(0),
emp_finfec timestamp(0),
emp_cobert varchar(2)
) server  options(schema 'USRSIHO', table 'NMCOEMPL2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcoinci (
inc_keyemp numeric(10),
inc_keycon varchar(3),
inc_keypro numeric(5),
inc_keyper varchar(7),
inc_keydep varchar(16),
inc_keypue varchar(16),
inc_fecmov timestamp(0),
inc_cantid decimal(16,6),
inc_import decimal(12,2),
inc_diauno decimal(12,2),
inc_diados decimal(12,2),
inc_diatre decimal(12,2),
inc_diacua decimal(12,2),
inc_diacin decimal(12,2),
inc_diasei decimal(12,2),
inc_diasie decimal(12,2),
inc_keyinc decimal(16,6),
inc_numfol numeric(10)
) server  options(schema 'USRSIHO', table 'NMCOINCI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmcopues (
pue_keypue varchar(16),
pue_despue varchar(40),
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
) server  options(schema 'USRSIHO', table 'NMCOPUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmdtaemp (
aem_keyemp numeric(10) options (key 'true') not null,
aem_keydep varchar(16),
aem_keypue varchar(16),
aem_tipem2 numeric(10),
aem_keyem2 numeric(10),
aem_tipemp numeric(10),
aem_keytco numeric(10),
aem_keyfol numeric(10)
) server  options(schema 'USRSIHO', table 'NMDTAEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmfolrem (
lre_fecha timestamp(0),
lre_numrem numeric(10) not null,
lre_consec numeric(10),
lre_nombre varchar(8)
) server  options(schema 'USRSIHO', table 'NMFOLREM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloacum (
acu_keyemp numeric(10),
acu_keycon varchar(3),
acu_uniuno decimal(14,2),
acu_unidos decimal(14,2),
acu_unitre decimal(14,2),
acu_unicua decimal(14,2),
acu_unicin decimal(14,2),
acu_unisei decimal(14,2),
acu_unisie decimal(14,2),
acu_unioch decimal(14,2),
acu_uninue decimal(14,2),
acu_unidie decimal(14,2),
acu_unionc decimal(14,2),
acu_unidoc decimal(14,2),
acu_unitrc decimal(14,2),
acu_unicat decimal(14,2),
acu_uniqui decimal(14,2),
acu_impuno decimal(14,2),
acu_impdos decimal(14,2),
acu_imptre decimal(14,2),
acu_impcua decimal(14,2),
acu_impcin decimal(14,2),
acu_impsei decimal(14,2),
acu_impsie decimal(14,2),
acu_impoch decimal(14,2),
acu_impnue decimal(14,2),
acu_impdie decimal(14,2),
acu_imponc decimal(14,2),
acu_impdoc decimal(14,2),
acu_imptrc decimal(14,2),
acu_impcat decimal(14,2),
acu_impqui decimal(14,2)
) server  options(schema 'USRSIHO', table 'NMLOACUM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloalde (
ald_keydep varchar(16) options (key 'true') not null,
ald_keytpr varchar(6),
ald_keyemp numeric(10),
ald_keyapr varchar(6),
ald_keyeve varchar(6),
ald_pertra varchar(3),
ald_idioma varchar(6),
ald_equcon varchar(15),
ald_fecidur timestamp(0) not null,
ald_fecfdur timestamp(0),
ald_equcpr varchar(15),
ald_ctabaj varchar(20),
ald_marcco varchar(1),
ald_cosgas varchar(1),
ald_keypro numeric(5) not null,
ald_status varchar(1)
) server  options(schema 'USRSIHO', table 'NMLOALDE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloalde_aux (
ald_keydep varchar(16) not null,
ald_keytpr varchar(6) not null,
ald_keyemp numeric(10),
ald_keyapr varchar(6) not null,
ald_keyeve varchar(6),
ald_pertra varchar(3),
ald_idioma varchar(6),
ald_equcon varchar(15),
ald_fecidur timestamp(0) not null,
ald_fecfdur timestamp(0),
ald_equcpr varchar(15),
ald_ctabaj varchar(20),
ald_marcco varchar(1),
ald_cosgas varchar(1),
ald_keypro numeric(5) not null,
ald_status varchar(1)
) server  options(schema 'USRSIHO', table 'NMLOALDE_AUX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloamor (
amo_keyemp numeric(10),
amo_keycon varchar(3),
amo_keypre decimal(16,6),
amo_refere varchar(20),
amo_keypro numeric(5),
amo_keydep varchar(16),
amo_keypue varchar(16),
amo_keycat varchar(16),
amo_keyubi varchar(16),
amo_keyper varchar(7),
amo_keynom numeric(5),
amo_numpag numeric(5),
amo_tiptra varchar(1),
amo_refpag varchar(10),
amo_fecpag timestamp(0),
amo_imppag decimal(12,2),
amo_unipag decimal(12,2),
amo_intpag decimal(12,2),
amo_porint decimal(6,4),
amo_conpro varchar(3),
amo_fecnom timestamp(0),
amo_ctreve varchar(16),
amo_ca1aux varchar(10),
amo_ca2aux varchar(10),
amo_uniope numeric(5)
) server  options(schema 'USRSIHO', table 'NMLOAMOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloamor_tmp (
amo_keyemp numeric(10),
amo_keycon varchar(3),
amo_keypre decimal(16,6),
amo_refere varchar(20),
amo_keypro numeric(5),
amo_keydep varchar(16),
amo_keypue varchar(16),
amo_keycat varchar(16),
amo_keyubi varchar(16),
amo_keyper varchar(7),
amo_keynom numeric(5),
amo_numpag numeric(5),
amo_tiptra varchar(1),
amo_refpag varchar(10),
amo_fecpag timestamp(0),
amo_imppag decimal(12,2),
amo_unipag decimal(12,2),
amo_intpag decimal(12,2),
amo_porint decimal(6,4),
amo_conpro varchar(3),
amo_fecnom timestamp(0),
amo_ctreve varchar(16),
amo_ca1aux varchar(10),
amo_ca2aux varchar(10),
amo_uniope numeric(5)
) server  options(schema 'USRSIHO', table 'NMLOAMOR_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlobanc (
ban_keyban varchar(3),
ban_desban varchar(30),
ban_keysuc varchar(4),
ban_dessuc varchar(30),
ban_cenreg varchar(4),
ban_dirsuc varchar(30),
ban_codpos varchar(6),
ban_ciudad varchar(20),
ban_estado varchar(20),
ban_nomleg varchar(40),
ban_rfcleg varchar(14),
ban_telleg varchar(15)
) server  options(schema 'USRSIHO', table 'NMLOBANC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlobebe (
beb_keyemp numeric(10),
beb_keyben numeric(5),
beb_comfam numeric(5),
beb_tipben varchar(2),
beb_fecven timestamp(0),
beb_porpar decimal(7,4),
beb_forpag varchar(2),
beb_keycon varchar(3),
beb_perini varchar(7),
beb_perfin varchar(7),
beb_status varchar(1),
beb_impfij decimal(12,2),
beb_fecini timestamp(0)
) server  options(schema 'USRSIHO', table 'NMLOBEBE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlobene (
ben_keyemp numeric(10),
ben_keyben numeric(5),
ben_comfam numeric(5),
ben_rfcben varchar(13),
ben_nomben varchar(60),
ben_fecnac timestamp(0),
ben_cvesex varchar(1),
ben_tippar varchar(2),
ben_keyban varchar(7),
ben_ctaban varchar(18),
ben_keydep varchar(16),
ben_keycen varchar(16),
ben_nomtut varchar(60),
ben_ca1aux varchar(10),
ben_ca2aux varchar(10),
ben_numex varchar(10),
ben_autori varchar(80)
) server  options(schema 'USRSIHO', table 'NMLOBENE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocalc (
cal_keyprg varchar(15),
cal_status varchar(1),
cal_fecmov timestamp(0),
cal_keypro numeric(5),
cal_keynom numeric(5),
cal_basdat varchar(10)
) server  options(schema 'USRSIHO', table 'NMLOCALC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocate (
cat_keycat varchar(16),
cat_descat varchar(40),
cat_refcon varchar(20),
cat_nu1aux varchar(10),
cat_nu2aux varchar(10),
cat_nu3aux varchar(10),
cat_nu4aux varchar(10),
cat_nu5aux varchar(10),
cat_ca1aux varchar(10),
cat_ca2aux varchar(10),
cat_ca3aux varchar(10),
cat_ca4aux varchar(10),
cat_ca5aux varchar(10)
) server  options(schema 'USRSIHO', table 'NMLOCATE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloccol (
cco_keyrco varchar(8),
cco_numsec numeric(5),
cco_secope numeric(5),
cco_operan varchar(10),
cco_operad varchar(1),
cco_tipope varchar(1),
cco_uniimp varchar(1),
cco_peracu varchar(15)
) server  options(schema 'USRSIHO', table 'NMLOCCOL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocenc (
cen_keycen varchar(16),
cen_descen varchar(40),
cen_refcon varchar(20),
cen_nu1aux varchar(10),
cen_nu2aux varchar(10),
cen_nu3aux varchar(10),
cen_nu4aux varchar(10),
cen_nu5aux varchar(10),
cen_ca1aux varchar(10),
cen_ca2aux varchar(10),
cen_ca3aux varchar(10),
cen_ca4aux varchar(10),
cen_ca5aux varchar(10)
) server  options(schema 'USRSIHO', table 'NMLOCENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocias (
cia_keycia varchar(4),
cia_descia varchar(100),
cia_rfccia varchar(15),
cia_infcia varchar(15),
cia_dircia varchar(30),
cia_colcia varchar(20),
cia_cidcia varchar(20),
cia_pobcia varchar(30),
cia_muncia varchar(6),
cia_entcia varchar(2),
cia_codpos varchar(5),
cia_telcia varchar(25),
cia_repcia varchar(25),
cia_curcia varchar(25),
cia_reprfc varchar(13),
cia_ca1aux varchar(10),
cia_ca2aux varchar(10),
cia_ca3aux varchar(10),
cia_razsoc varchar(100),
cia_socied varchar(50)
) server  options(schema 'USRSIHO', table 'NMLOCIAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocias_sdw (
marca_act varchar(2),
cmd varchar(15),
old_cia_keycia varchar(16),
old_cia_descia varchar(40),
new_cia_keycia varchar(16),
new_cia_descia varchar(40),
orderid1 timestamp(0),
orderid2 numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'NMLOCIAS_SDW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocier (
cie_keycie varchar(10),
cie_descie varchar(60),
cie_keynom numeric(5),
cie_mesini numeric(5),
cie_mesfin numeric(5),
cie_codame varchar(1),
cie_codaa2 varchar(1),
cie_codaa3 varchar(1),
cie_codaa4 varchar(1),
cie_perini varchar(7),
cie_perfin varchar(7),
cie_semini varchar(7),
cie_semfin varchar(7),
cie_datfij varchar(1),
cie_fecbaj timestamp(0),
cie_fecinc timestamp(0),
cie_fectra timestamp(0),
cie_ranpro varchar(200),
cie_ranims varchar(200)
) server  options(schema 'USRSIHO', table 'NMLOCIER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloconc (
con_keycon varchar(3),
con_descon varchar(30),
con_descor varchar(10),
con_keyfor varchar(4),
con_leeinc varchar(1),
con_leedfi varchar(1),
con_leepre varchar(1),
con_leeacu varchar(1),
con_leedfc varchar(1),
con_codimp varchar(2),
con_codacu varchar(2),
con_codval varchar(2),
con_uniini decimal(12,2),
con_unifin decimal(12,2),
con_impini decimal(12,2),
con_impfin decimal(12,2),
con_ctaref varchar(20),
con_ctaaux varchar(20),
con_nu1aux varchar(10),
con_nu2aux varchar(10),
con_ca1aux varchar(10),
con_ca2aux varchar(10),
con_forval varchar(4),
con_porcen decimal(12,2)
) server  options(schema 'USRSIHO', table 'NMLOCONC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocopr (
cop_keytpr varchar(2),
cop_keycon varchar(3),
cop_numsec numeric(5)
) server  options(schema 'USRSIHO', table 'NMLOCOPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloctas (
cta_keypro numeric(5),
cta_keyemp numeric(10),
cta_ctaban varchar(20)
) server  options(schema 'USRSIHO', table 'NMLOCTAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlocxpr (
cxp_keypro numeric(5),
cxp_keynom numeric(5),
cxp_numsec numeric(5),
cxp_keycon varchar(3),
cxp_keyfor varchar(4),
cxp_leeinc varchar(1),
cxp_leedfi varchar(1),
cxp_leedfc varchar(1),
cxp_leepre varchar(1),
cxp_leeacu varchar(1),
cxp_codacu varchar(2),
cxp_codimp varchar(2),
cxp_codval varchar(2),
cxp_uniini decimal(12,2),
cxp_unifin decimal(12,2),
cxp_impini decimal(12,2),
cxp_impfin decimal(12,2),
cxp_forval varchar(4),
cxp_porcen decimal(12,2)
) server  options(schema 'USRSIHO', table 'NMLOCXPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlodata (
dat_keyemp numeric(10),
dat_keypar varchar(2),
dat_valpar varchar(30)
) server  options(schema 'USRSIHO', table 'NMLODATA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlodfij (
dfi_keyemp numeric(10),
dfi_keycon varchar(3),
dfi_keypro numeric(5),
dfi_perini varchar(7),
dfi_perfin varchar(7),
dfi_keydep varchar(16),
dfi_keypue varchar(16),
dfi_fecmov timestamp(0),
dfi_cantid decimal(12,2),
dfi_import decimal(12,2),
dfi_ca1aux varchar(10),
dfi_ca2aux varchar(10)
) server  options(schema 'USRSIHO', table 'NMLODFIJ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloenfm (
enf_keyfor varchar(4),
enf_de1for varchar(40),
enf_de2for varchar(40),
enf_de3for varchar(40),
enf_idever varchar(15)
) server  options(schema 'USRSIHO', table 'NMLOENFM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloform (
for_keyfor varchar(4),
for_numins numeric(5),
for_opera1 varchar(16),
for_operad varchar(16),
for_opera2 varchar(16),
for_result varchar(16)
) server  options(schema 'USRSIHO', table 'NMLOFORM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlohism (
his_keyemp numeric(10),
his_keycon varchar(3),
his_keypro numeric(5),
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16,2),
his_import decimal(16,2),
his_fecmov timestamp(0),
his_keyper varchar(7),
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16,6),
his_uniope numeric(5),
his_keyplz numeric(5),
his_tipplz varchar(2)
) server  options(schema 'USRSIHO', table 'NMLOHISM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlohism_cons (
his_keyemp numeric(10),
his_keycon varchar(3),
his_keypro numeric(5),
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16,2),
his_import decimal(16,2),
his_fecmov timestamp(0),
his_keyper varchar(7),
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16,6),
his_uniope numeric(5),
his_keyplz numeric(5),
his_tipplz varchar(2)
) server  options(schema 'USRSIHO', table 'NMLOHISM_CONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlohism_tmp (
his_keyemp numeric(10),
his_keycon varchar(3),
his_keypro numeric(5),
his_keydep varchar(16),
his_keypue varchar(16),
his_cantid decimal(16,2),
his_import decimal(16,2),
his_fecmov timestamp(0),
his_keyper varchar(7),
his_keynom numeric(5),
his_codimp varchar(2),
his_codacu varchar(2),
his_ca1aux varchar(16),
his_ca2aux varchar(16),
his_rowide decimal(16,6),
his_uniope numeric(5),
his_keyplz numeric(5),
his_tipplz varchar(2)
) server  options(schema 'USRSIHO', table 'NMLOHISM_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloimss (
ims_keyims varchar(5),
ims_rfcims varchar(14),
ims_razsoc varchar(40),
ims_dirloc varchar(40),
ims_numext varchar(6),
ims_numint varchar(6),
ims_colloc varchar(20),
ims_codpos varchar(5),
ims_munloc varchar(6),
ims_entloc varchar(2),
ims_numban varchar(20),
ims_pririe decimal(12,6),
ims_tiprie varchar(12),
ims_luggui numeric(10),
ims_actloc varchar(24),
ims_keyban varchar(7),
ims_numcot numeric(5),
ims_bascal numeric(5),
ims_totpag numeric(5),
ims_keycia varchar(4),
ims_cveedi varchar(16),
ims_ca1aux varchar(30),
ims_ca2aux varchar(20),
ims_ca3aux varchar(20),
ims_ca4aux varchar(20)
) server  options(schema 'USRSIHO', table 'NMLOIMSS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlolocp (
loc_keyloc varchar(16),
loc_desloc varchar(40),
loc_domloc varchar(30),
loc_colloc varchar(20),
loc_ciuloc varchar(6),
loc_estloc varchar(6),
loc_codpos varchar(6),
loc_lardis varchar(5),
loc_teluno varchar(10),
loc_teldos varchar(10),
loc_teltre varchar(10),
loc_cvezon numeric(5),
loc_reggeo varchar(10),
loc_keyban varchar(3),
loc_keysuc varchar(4),
loc_ca1aux varchar(10),
loc_ca2aux varchar(10),
loc_ca3aux varchar(10),
loc_ca4aux varchar(10),
loc_ca5aux varchar(10)
) server  options(schema 'USRSIHO', table 'NMLOLOCP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlomnem (
mne_keynem varchar(16),
mne_keytab varchar(8),
mne_keycam varchar(16),
mne_condic varchar(16),
mne_tipdat varchar(1)
) server  options(schema 'USRSIHO', table 'NMLOMNEM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlonomi (
nom_keynom numeric(5),
nom_destip varchar(40)
) server  options(schema 'USRSIHO', table 'NMLONOMI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlopcol (
pco_keyrco varchar(8),
pco_numsec numeric(5),
pco_etqcol varchar(16)
) server  options(schema 'USRSIHO', table 'NMLOPCOL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloperi (
per_keypro numeric(5) options (key 'true') not null,
per_keynom numeric(5),
per_keyper varchar(7) options (key 'true') not null,
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0),
per_feccor timestamp(0),
per_nummes numeric(5),
per_acudos numeric(5),
per_acutre numeric(5),
per_acucua numeric(5),
per_nu1aux varchar(10),
per_nu2aux varchar(10),
per_nu3aux varchar(10),
per_nu4aux varchar(10),
per_nu5aux varchar(10),
per_keypol varchar(10),
per_impnom decimal(18,2),
per_totemp numeric(10),
per_fecact timestamp(0),
per_horact varchar(6),
per_persel varchar(1),
per_fecpol timestamp(0),
per_despol varchar(20)
) server  options(schema 'USRSIHO', table 'NMLOPERI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloperi02 (
per_keypro numeric(5) options (key 'true') not null,
per_keynom numeric(5),
per_keyper varchar(7) options (key 'true') not null,
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0),
per_feccor timestamp(0),
per_nummes numeric(5),
per_acudos numeric(5),
per_acutre numeric(5),
per_acucua numeric(5),
per_nu1aux varchar(10),
per_nu2aux varchar(10),
per_nu3aux varchar(10),
per_nu4aux varchar(10),
per_nu5aux varchar(10),
per_keypol varchar(10),
per_impnom decimal(18,2),
per_totemp numeric(10),
per_fecact timestamp(0),
per_horact varchar(6),
per_persel varchar(1),
per_fecpol timestamp(0),
per_despol varchar(20)
) server  options(schema 'USRSIHO', table 'NMLOPERI02', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloperi_aux (
per_keypro numeric(5),
per_keynom numeric(5),
per_keyper varchar(7),
per_fecini timestamp(0),
per_fecfin timestamp(0),
per_fecpag timestamp(0),
per_feccor timestamp(0),
per_nummes numeric(5),
per_acudos numeric(5),
per_acutre numeric(5),
per_acucua numeric(5),
per_nu1aux varchar(10),
per_nu2aux varchar(10),
per_nu3aux varchar(10),
per_nu4aux varchar(10),
per_nu5aux varchar(10),
per_keypol varchar(10),
per_impnom decimal(18,2),
per_totemp numeric(10),
per_fecact timestamp(0),
per_horact varchar(6),
per_persel varchar(1),
per_fecpol timestamp(0),
per_despol varchar(20)
) server  options(schema 'USRSIHO', table 'NMLOPERI_AUX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlopres (
pre_keyemp numeric(10),
pre_keycon varchar(3),
pre_keypre decimal(16,6),
pre_refere varchar(20),
pre_fecreg timestamp(0),
pre_tippre varchar(2),
pre_unipre decimal(12,2),
pre_imppre decimal(12,2),
pre_gastos decimal(12,2),
pre_plazop numeric(5),
pre_unides decimal(12,2),
pre_impdes decimal(12,2),
pre_porint decimal(6,4),
pre_perini varchar(7),
pre_fecini timestamp(0),
pre_fecaut timestamp(0),
pre_cveaut numeric(10),
pre_fechab timestamp(0),
pre_uniamo decimal(12,2),
pre_impamo decimal(12,2),
pre_unisal decimal(12,2),
pre_impsal decimal(12,2),
pre_uniult decimal(12,2),
pre_impult decimal(12,2),
pre_numpag numeric(5),
pre_intpag decimal(12,2),
pre_status varchar(1),
pre_ultact timestamp(0),
pre_refcon varchar(20),
pre_ctreve varchar(16),
pre_fe1aux timestamp(0),
pre_fe2aux timestamp(0),
pre_ca1aux varchar(10),
pre_ca2aux varchar(10),
pre_ca3aux varchar(10),
pre_ca4aux varchar(10),
pre_uniope numeric(5),
pre_keypro numeric(5)
) server  options(schema 'USRSIHO', table 'NMLOPRES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloproc (
pro_keypro numeric(5),
pro_despro varchar(20),
pro_keycia varchar(4),
pro_tipsal varchar(1),
pro_dirpag varchar(30),
pro_diaper numeric(5),
pro_perano numeric(5),
pro_faccon decimal(4,2),
pro_keynom numeric(5),
pro_pereje varchar(7),
pro_vercon numeric(5),
pro_nu1aux varchar(10),
pro_nu2aux varchar(10),
pro_nu3aux varchar(10),
pro_nu4aux varchar(10),
pro_nu5aux varchar(10),
pro_ca1aux varchar(10),
pro_ca2aux varchar(10),
pro_ca3aux varchar(10),
pro_ca4aux varchar(10),
pro_ca5aux varchar(10)
) server  options(schema 'USRSIHO', table 'NMLOPROC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloproc_sdw (
marca_act varchar(2),
cmd varchar(15),
old_pro_keypro numeric(5),
old_pro_despro varchar(20),
old_pro_keycia varchar(4),
new_pro_keycia varchar(4),
new_pro_keypro numeric(5),
new_pro_despro varchar(20),
orderid1 timestamp(0),
orderid2 numeric(10) options (key 'true') not null
) server  options(schema 'USRSIHO', table 'NMLOPROC_SDW', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlorcon (
rco_keyrco varchar(8),
rco_desrco varchar(50),
rco_cam001 varchar(10),
rco_cam002 varchar(10),
rco_cam003 varchar(10),
rco_tipcam varchar(3),
rco_cor001 varchar(10),
rco_cor002 varchar(10),
rco_cor003 varchar(10),
rco_cor004 varchar(10),
rco_cor005 varchar(10),
rco_cor006 varchar(10),
rco_saltos varchar(6),
rco_tipcor varchar(6),
rco_tablaf varchar(1)
) server  options(schema 'USRSIHO', table 'NMLORCON', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlorepc (
rep_keyrco varchar(8),
rep_keymen varchar(4),
rep_keyusu numeric(10),
rep_destin varchar(1),
rep_ran001 varchar(60),
rep_ran002 varchar(60),
rep_ran003 varchar(60),
rep_ran004 varchar(60),
rep_ran005 varchar(60),
rep_ran006 varchar(60),
rep_rancia varchar(60),
rep_ranpro varchar(60),
rep_randep varchar(60),
rep_ranemp varchar(60),
rep_ranpue varchar(60),
rep_rannom varchar(60),
rep_ranca1 varchar(60),
rep_ranca2 varchar(60),
rep_tipper varchar(1),
rep_ranper varchar(60),
rep_tipord varchar(1),
rep_estorg varchar(1),
rep_totrep numeric(5),
rep_corper varchar(1)
) server  options(schema 'USRSIHO', table 'NMLOREPC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlosuel (
sue_keysue varchar(4),
sue_dessue varchar(40),
sue_fecact timestamp(0),
sue_ca1aux varchar(10),
sue_ca2aux varchar(10),
sue_ca3aux varchar(10),
sue_ca4aux varchar(10),
sue_collst varchar(5),
sue_etqmin varchar(40),
sue_etq1qa varchar(40),
sue_etqmed varchar(40),
sue_etq3qa varchar(40),
sue_etqmax varchar(40)
) server  options(schema 'USRSIHO', table 'NMLOSUEL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloswit (
swi_keyemp numeric(10),
swi_keycon varchar(3),
swi_marcas varchar(80)
) server  options(schema 'USRSIHO', table 'NMLOSWIT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlotabn (
tab_keytab varchar(3),
tab_sectab numeric(10),
tab_eleuno decimal(18,6),
tab_eledos decimal(18,6),
tab_eletre decimal(18,6),
tab_elecua decimal(18,6)
) server  options(schema 'USRSIHO', table 'NMLOTABN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlotabs (
tab_keysue varchar(4),
tab_cobert varchar(2),
tab_tiptab varchar(2),
tab_sueniv numeric(10),
tab_subniv numeric(10),
tab_feccad timestamp(0),
tab_suemin decimal(12,2),
tab_sue1qa decimal(12,2),
tab_suemed decimal(12,2),
tab_sue3qa decimal(12,2),
tab_suemax decimal(12,2)
) server  options(schema 'USRSIHO', table 'NMLOTABS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlotanu (
tan_keytab varchar(3),
tan_de1tab varchar(40),
tan_de2tab varchar(40),
tan_de3tab varchar(40),
tan_idever varchar(15)
) server  options(schema 'USRSIHO', table 'NMLOTANU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlotipr (
tpe_keytpr varchar(2),
tpe_destpr varchar(40),
tpe_valpre varchar(1),
tpe_status varchar(1)
) server  options(schema 'USRSIHO', table 'NMLOTIPR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmlotray (
tra_keyemp numeric(10),
tra_fecmov timestamp(0),
tra_tipmov varchar(2),
tra_keydep varchar(16),
tra_keypue varchar(16),
tra_keycat varchar(16),
tra_keycen varchar(16),
tra_saldia decimal(12,6),
tra_salmes decimal(12,2),
tra_salint decimal(12,6),
tra_salivc decimal(12,6),
tra_salinf decimal(12,6),
tra_intsin decimal(12,6),
tra_infsin decimal(12,6),
tra_keyims varchar(5),
tra_keyper varchar(7),
tra_codloc varchar(16),
tra_keypla numeric(10),
tra_keypro numeric(10),
tra_jorlab varchar(1),
tra_unijor decimal(4,2),
tra_submov varchar(6),
tra_ca1aux varchar(10),
tra_ca2aux varchar(10),
tra_fecmod timestamp(0),
tra_hormod varchar(8)
) server  options(schema 'USRSIHO', table 'NMLOTRAY', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmloverc (
ver_keyver numeric(5),
ver_ctacar varchar(20),
ver_refcta varchar(30),
ver_tipexc varchar(1),
ver_keycon varchar(3),
ver_ctaabo varchar(20),
ver_cveco1 varchar(8),
ver_cveop1 varchar(1),
ver_cveco2 varchar(8),
ver_cveop2 varchar(1),
ver_cveco3 varchar(8),
ver_cveop3 varchar(1),
ver_cveco4 varchar(8),
ver_cveop4 varchar(1),
ver_cveco5 varchar(8),
ver_cveop5 varchar(1),
ver_cveco6 varchar(8),
ver_cveop6 varchar(1),
ver_cveco7 varchar(8),
ver_cveop7 varchar(1),
ver_cveco8 varchar(8),
ver_cveop8 varchar(1),
ver_cveco9 varchar(8),
ver_cveop9 varchar(1),
ver_cveco0 varchar(8)
) server  options(schema 'USRSIHO', table 'NMLOVERC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmrepleg (
ple_nomrep varchar(100),
ple_rfcrep varchar(20) options (key 'true') not null,
ple_curp varchar(20)
) server  options(schema 'USRSIHO', table 'NMREPLEG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmwkeols (
eol_idepro varchar(10),
eol_idepcc varchar(15),
eol_keyusu numeric(10),
eol_keydep varchar(16),
eol_niv001 varchar(16),
eol_niv002 varchar(16),
eol_niv003 varchar(16),
eol_niv004 varchar(16),
eol_niv005 varchar(16),
eol_niv006 varchar(16),
eol_niv007 varchar(16),
eol_niv008 varchar(16),
eol_niv009 varchar(16),
eol_niv010 varchar(16),
eol_niv011 varchar(16),
eol_niv012 varchar(16),
eol_niv013 varchar(16),
eol_niv014 varchar(16),
eol_niv015 varchar(16),
eol_niv016 varchar(16),
eol_niv017 varchar(16),
eol_niv018 varchar(16),
eol_niv019 varchar(16),
eol_niv020 varchar(16),
eol_des001 varchar(40),
eol_des002 varchar(40),
eol_des003 varchar(40),
eol_des004 varchar(40),
eol_des005 varchar(40),
eol_des006 varchar(40),
eol_des007 varchar(40),
eol_des008 varchar(40),
eol_des009 varchar(40),
eol_des010 varchar(40),
eol_des011 varchar(40),
eol_des012 varchar(40),
eol_des013 varchar(40),
eol_des014 varchar(40),
eol_des015 varchar(40),
eol_des016 varchar(40),
eol_des017 varchar(40),
eol_des018 varchar(40),
eol_des019 varchar(40),
eol_des020 varchar(40)
) server  options(schema 'USRSIHO', table 'NMWKEOLS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmwketqc (
etq_nomrep varchar(10),
etq_idepcc varchar(15),
etq_keyusu numeric(10),
etq_nomcia varchar(60),
etq_titrep varchar(60),
etq_etq001 varchar(16),
etq_etq002 varchar(16),
etq_etq003 varchar(16),
etq_etq004 varchar(16),
etq_etq005 varchar(16),
etq_etq006 varchar(16),
etq_etq007 varchar(16),
etq_etq008 varchar(16),
etq_etq009 varchar(16),
etq_etq010 varchar(16),
etq_etq011 varchar(16),
etq_etq012 varchar(16),
etq_etq013 varchar(16),
etq_etq014 varchar(16),
etq_etq015 varchar(16),
etq_etq016 varchar(16),
etq_etq017 varchar(16),
etq_etq018 varchar(16),
etq_etq019 varchar(16),
etq_etq020 varchar(8),
etq_etq021 varchar(8),
etq_etq022 varchar(8),
etq_etq023 varchar(16),
etq_etq024 varchar(8),
etq_saltos varchar(6),
etq_despli varchar(8),
etq_fecreg timestamp(0),
etq_horreg varchar(8)
) server  options(schema 'USRSIHO', table 'NMWKETQC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmwklstc (
lst_nomrep varchar(10),
lst_idepcc varchar(15),
lst_keyusu numeric(10),
lst_numsec numeric(10),
lst_cam001 varchar(15),
lst_cam002 varchar(35),
lst_cam003 varchar(25),
lst_cor001 varchar(16),
lst_cor002 varchar(16),
lst_cor003 varchar(16),
lst_cor004 varchar(16),
lst_cor005 varchar(16),
lst_cor006 varchar(16),
lst_des001 varchar(40),
lst_des002 varchar(40),
lst_des003 varchar(40),
lst_des004 varchar(40),
lst_des005 varchar(40),
lst_des006 varchar(40),
lst_imp001 decimal(12,2),
lst_imp002 decimal(12,2),
lst_imp003 decimal(12,2),
lst_imp004 decimal(12,2),
lst_imp005 decimal(12,2),
lst_imp006 decimal(12,2),
lst_imp007 decimal(12,2),
lst_imp008 decimal(12,2),
lst_imp009 decimal(12,2),
lst_imp010 decimal(12,2),
lst_imp011 decimal(12,2),
lst_imp012 decimal(12,2),
lst_imp013 decimal(12,2),
lst_niv001 varchar(4),
lst_niv002 varchar(4),
lst_niv003 varchar(4),
lst_niv004 varchar(4),
lst_niv005 varchar(4),
lst_niv006 varchar(4),
lst_niv007 varchar(4),
lst_niv008 varchar(4),
lst_niv009 varchar(4),
lst_niv010 varchar(4),
lst_niv011 varchar(4),
lst_niv012 varchar(4),
lst_niv013 varchar(4),
lst_niv014 varchar(4),
lst_niv015 varchar(4),
lst_niv016 varchar(4),
lst_niv017 varchar(4),
lst_niv018 varchar(4),
lst_niv019 varchar(4),
lst_niv020 varchar(4),
lst_keyper varchar(60),
lst_fecini timestamp(0),
lst_fecfin timestamp(0)
) server  options(schema 'USRSIHO', table 'NMWKLSTC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmwkmovt (
mov_keyemp numeric(10),
mov_keycon varchar(3),
mov_keynom numeric(5),
mov_keydep varchar(16),
mov_keypue varchar(16),
mov_cantid decimal(16,2),
mov_import decimal(16,2),
mov_fecmov timestamp(0),
mov_keyper varchar(7),
mov_keypro numeric(5),
mov_keyfor varchar(4),
mov_codimp varchar(2),
mov_codacu varchar(2),
mov_rowide decimal(16,6),
mov_ca1aux varchar(16),
mov_ca2aux varchar(16),
mov_uniope numeric(5),
mov_keyplz numeric(5),
mov_tipplz varchar(2)
) server  options(schema 'USRSIHO', table 'NMWKMOVT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table nmwkpoli (
pol_keypro numeric(5),
pol_numcta varchar(20),
pol_descta varchar(30),
pol_impcar decimal(16,2),
pol_impabo decimal(16,2),
pol_keycia varchar(2),
pol_keypol varchar(10),
pol_keycon varchar(3),
pol_codacu numeric(10),
pol_import decimal(16,2),
pol_keyver numeric(5)
) server  options(schema 'USRSIHO', table 'NMWKPOLI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table paso (
pas_modulo varchar(20),
pas_nomrep varchar(15),
pas_idepcc varchar(15),
pas_keyusu numeric(10),
pas_variab varchar(10),
pas_observ varchar(40)
) server  options(schema 'USRSIHO', table 'PASO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table pcdetalleanda (
deaidnumdet numeric(10) options (key 'true') not null,
deaidnumenc numeric(10) not null,
deahorapeticion varchar(5),
deacodigoempleado numeric(10) not null,
deapersonaje varchar(40),
deafechagrabacion timestamp(0),
deanumeroprogramas varchar(20),
deatabulador numeric(5),
deapagdiftab numeric(5),
deaclapueact varchar(16) not null,
deatipocontrato numeric(10) not null,
deatipocontratacio varchar(1) not null,
deafoliocontrato numeric(10),
deafechaactualiza timestamp(0),
deafechacapturacon timestamp(0),
deaidproduccion numeric(10),
deaauxiliarnum1 numeric(10),
deaauxiliarnum2 numeric(10),
deaauxiliarchar1 varchar(20),
deaauxiliarchar2 varchar(20),
deaparteconjunto varchar(100),
deaestatus numeric(10),
deakeytab numeric(10),
deafecinicont timestamp(0),
deafecfincont timestamp(0)
) server  options(schema 'USRSIHO', table 'PCDETALLEANDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table pcencabezadoanda (
enaidnumenc numeric(10) options (key 'true') not null,
enacentrocostos varchar(16) not null,
enafechapeticion timestamp(0) not null,
enaidnumerousuario numeric(10) not null,
enaestatus numeric(10) not null,
enaproceso numeric(5),
enaauxiliarnum numeric(10),
enaauxiliarchar varchar(20),
enaobservacion varchar(255),
enaidproduccion numeric(10)
) server  options(schema 'USRSIHO', table 'PCENCABEZADOANDA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table pcusuarios (
usuidnumerousuario numeric(10) options (key 'true') not null,
usupassword varchar(10) not null,
usulogin varchar(10) not null,
usunombre varchar(60),
usuacceso numeric(10) not null,
usuestado numeric(10) not null
) server  options(schema 'USRSIHO', table 'PCUSUARIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table reci_erp (
rec_cvepol varchar(50) not null,
rec_fecpag timestamp(0) not null,
rec_numerr numeric(5),
rec_stsrec varchar(1),
rec_status varchar(1),
rec_tipcam decimal(16,6),
rec_fecgen timestamp(0),
rec_forpag numeric(10),
rec_fpafin numeric(10),
rec_tcafin decimal(16,6),
rec_tippag varchar(15),
rec_refere varchar(20),
rec_fecrec timestamp(0),
rec_cveban varchar(7),
rec_ctaban varchar(30)
) server  options(schema 'USRSIHO', table 'RECI_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table reci_erp_c (
rec_cvepol varchar(50) not null,
rec_fecpag timestamp(0) not null,
rec_numerr numeric(5),
rec_stsrec varchar(1),
rec_status varchar(1),
rec_tipcam decimal(16,6),
rec_fecgen timestamp(0),
rec_forpag numeric(10),
rec_fpafin numeric(10),
rec_tcafin decimal(16,6),
rec_tippag varchar(15),
rec_refere varchar(20),
rec_fecrec timestamp(0),
rec_cveban varchar(7),
rec_ctaban varchar(30)
) server  options(schema 'USRSIHO', table 'RECI_ERP_C', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table reportes (
rep_keyfol numeric(10) not null,
rep_fecrep timestamp(0),
rep_fecasi timestamp(0),
rep_fecsol timestamp(0),
rep_status numeric(5),
rep_severi numeric(5),
rep_descri varchar(400),
rep_tipser numeric(5),
rep_keyusu numeric(5),
rep_keyres numeric(5),
rep_modulo varchar(40),
rep_tierep varchar(8),
rep_tieasi varchar(8),
rep_keyreu numeric(5),
rep_fecten timestamp(0),
rep_feccer timestamp(0),
rep_fecrea timestamp(0),
rep_submod varchar(35),
rep_porcen numeric(5)
) server  options(schema 'USRSIHO', table 'REPORTES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table reprocesos (
rep_ejercicio numeric(10) not null,
rep_keyemp numeric(10),
rep_capini double precision,
rep_capfin double precision,
rep_costog double precision,
rep_keyrec numeric(10),
rep_fecsol timestamp(0),
rep_import decimal(20,2),
rep_imbase decimal(20,2),
rep_forpag numeric(10),
rep_tipcam decimal(16,6),
rep_pertra numeric(10),
rep_moneda decimal(16,6),
rep_keypro numeric(5),
rep_keyapr varchar(6),
rep_keynom numeric(5),
rep_numemi numeric(10),
rep_bannvo numeric(10),
rep_impres double precision,
rep_keycon varchar(5),
rep_status numeric(10),
rep_rphori numeric(10),
rep_keyrph numeric(10),
rep_fecpag timestamp(0),
rep_ordcom varchar(100),
rep_obscan varchar(100),
rep_eminvo numeric(10),
rep_imneto decimal(12,2),
rep_keypol numeric(10),
rep_nummes numeric(10),
rep_ordnvo numeric(10),
rep_recnvo numeric(10),
rep_basnvo decimal(12,2)
) server  options(schema 'USRSIHO', table 'REPROCESOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table reprocesos_bkp (
rep_ejercicio numeric(10) not null,
rep_keyemp numeric(10),
rep_capini double precision,
rep_capfin double precision,
rep_costog double precision,
rep_keyrec numeric(10),
rep_fecsol timestamp(0),
rep_import decimal(20,2),
rep_imbase decimal(20,2),
rep_forpag numeric(10),
rep_tipcam decimal(16,6),
rep_pertra numeric(10),
rep_moneda decimal(16,6),
rep_keypro numeric(5),
rep_keyapr varchar(6),
rep_keynom numeric(5),
rep_numemi numeric(10),
rep_bannvo numeric(10),
rep_impres double precision,
rep_keycon varchar(5),
rep_status numeric(10),
rep_rphori numeric(10),
rep_keyrph numeric(10),
rep_fecpag timestamp(0),
rep_ordcom varchar(100),
rep_obscan varchar(100),
rep_eminvo numeric(10),
rep_imneto decimal(12,2),
rep_keypol numeric(10),
rep_nummes numeric(10),
rep_ordnvo numeric(10),
rep_recnvo numeric(10),
rep_basnvo decimal(12,2)
) server  options(schema 'USRSIHO', table 'REPROCESOS_BKP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table responsables (
res_status numeric(5),
res_tipo numeric(5),
res_clave numeric(5),
res_keyusu numeric(5)
) server  options(schema 'USRSIHO', table 'RESPONSABLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rhdesreciap (
iap_keysec numeric(10) not null,
iap_descap varchar(200)
) server  options(schema 'USRSIHO', table 'RHDESRECIAP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rpcodequ (
deq_keyrep varchar(16),
deq_defvar varchar(16),
deq_numsec numeric(38),
deq_detqry varchar(200)
) server  options(schema 'USRSIHO', table 'RPCODEQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
) server  options(schema 'USRSIHO', table 'RPCODERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
) server  options(schema 'USRSIHO', table 'RPCOENQU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
) server  options(schema 'USRSIHO', table 'RPCOENRP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rpcoetiq (
eti_keyrep varchar(16),
eti_keycam varchar(18),
eti_etique varchar(20)
) server  options(schema 'USRSIHO', table 'RPCOETIQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rpcosegm (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_permen numeric(5)
) server  options(schema 'USRSIHO', table 'RPCOSEGM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rpcosegu (
seg_keyrep varchar(16),
seg_keymen varchar(4),
seg_repfor varchar(3),
seg_keyusu numeric(10),
seg_perusu numeric(5)
) server  options(schema 'USRSIHO', table 'RPCOSEGU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
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
) server  options(schema 'USRSIHO', table 'RPCOSPRO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table rpfmtcam (
cam_keyrep varchar(16),
cam_numsec numeric(38),
cam_keycam varchar(16),
cam_format varchar(100)
) server  options(schema 'USRSIHO', table 'RPFMTCAM', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table tmpconrec (
rec_keypro numeric(5),
rec_keyper varchar(7),
rec_keynom numeric(5),
rec_keycon varchar(3),
rec_codimp varchar(2),
rec_numrec varchar(10),
rec_agrupa varchar(10),
rec_secuen varchar(10),
rec_subtpo numeric(5),
rec_strcon varchar(300)
) server  options(schema 'USRSIHO', table 'TMPCONREC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table tmpmonitoreo (
linea numeric(10),
mensaje varchar(400)
) server  options(schema 'USRSIHO', table 'TMPMONITOREO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table tmp_cap_val (
nocapitulos numeric(38)
) server  options(schema 'USRSIHO', table 'TMP_CAP_VAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table tmp_cont_exclu (
con_keyfol numeric(10),
con_keydep varchar(16),
con_keypue varchar(16),
con_keyemp numeric(10),
con_numcap numeric(5),
con_fecpag timestamp(0),
con_fecpro timestamp(0),
con_cosuni decimal(13,2) not null,
con_numerr numeric(5),
con_stscon varchar(1),
con_tipfol varchar(1),
con_numlin numeric(10),
con_keynom numeric(5),
con_forpag numeric(10),
con_tipcam decimal(16,6),
con_tiptra varchar(2),
con_keypro numeric(5),
con_arefis varchar(6),
con_descap varchar(200),
con_fpafin numeric(10),
con_tcafin decimal(16,6),
con_keyrph numeric(10),
con_keyusu numeric(10),
con_fecmod timestamp(0),
con_odcori varchar(50)
) server  options(schema 'USRSIHO', table 'TMP_CONT_EXCLU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table tvbancorp (
cor_keycia varchar(240),
cor_orgid numeric(10) options (key 'true') not null,
cor_provee varchar(240),
cor_keyrfc varchar(30) options (key 'true') not null,
cor_sucurs varchar(15),
cor_forpag varchar(25),
cor_keyemp varchar(115),
cor_fecalt timestamp(0),
cor_fecbaj timestamp(0)
) server  options(schema 'USRSIHO', table 'TVBANCORP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = usrsiho,oracle,dmap_extension,public;
create foreign  table xx_proveedorsiho (
noemple numeric(10),
tipoproveedor numeric(10),
cvempresa numeric(10),
nombre varchar(40),
paterno varchar(40),
materno varchar(40),
rfc varchar(13),
curp varchar(18),
perjuridica numeric(10),
tipomov varchar(5),
status varchar(3),
fecha timestamp(0),
hora varchar(10),
rfcanterior varchar(13),
telefono varchar(10),
ciudad varchar(40),
estado varchar(40),
delegacion varchar(40),
calle varchar(60),
nointerior varchar(40),
noexterior varchar(40),
colonia varchar(40),
codigopostal varchar(6)
) server  options(schema 'USRSIHO', table 'XX_PROVEEDORSIHO', readonly 'true');
