-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table bitacora_forecast_ns (
fecha_creacion timestamp(0),
ver_ene_hist numeric(38),
ver_feb_hist numeric(38),
ver_mar_hist numeric(38),
ver_abr_hist numeric(38),
ver_may_hist numeric(38),
ver_jun_hist numeric(38),
ver_jul_hist numeric(38),
ver_ago_hist numeric(38),
ver_sep_hist numeric(38),
ver_oct_hist numeric(38),
ver_nov_hist numeric(38),
ver_dic_hist numeric(38),
ver_ene_ns numeric(38),
ver_feb_ns numeric(38),
ver_mar_ns numeric(38),
ver_abr_ns numeric(38),
ver_may_ns numeric(38),
ver_jun_ns numeric(38),
ver_jul_ns numeric(38),
ver_ago_ns numeric(38),
ver_sep_ns numeric(38),
ver_oct_ns numeric(38),
ver_nov_ns numeric(38),
ver_dic_ns numeric(38),
ppto_hist numeric(38),
ppto_ns numeric(38),
comentario varchar(250),
usuario varchar(60)
) server  options(schema 'FECXC', table 'BITACORA_FORECAST_NS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table campos (
entidad varchar(30) not null,
campo varchar(30) not null,
nombre varchar(50) not null,
tipo char(1) not null,
longitud numeric(38) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CAMPOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table ccm001 (
moncod char(2) options (key 'true') not null,
mondes varchar(40),
montpc double precision,
montpv double precision not null,
monfca varchar(8),
monusr varchar(8),
monimp varchar(3),
monvtc double precision,
timestamp timestamp
) server  options(schema 'FECXC', table 'CCM001', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge000 (
cge0niv numeric(38),
cge1cod char(5),
cge5cod varchar(5),
cge0usr varchar(30),
cge0pas varchar(30),
cge0pce char(1) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE000', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge001 (
cge1cod char(5) options (key 'true') not null,
cge1des varchar(40) not null,
cge1dbl varchar(30),
cge1bdi varchar(30),
cge1bdc varchar(30),
cge1rep varchar(50),
cge1tel1 varchar(15),
cge1tel2 varchar(15),
cge1fax varchar(15),
cge1mail varchar(40),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE001', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge002 (
cge1cod char(5) options (key 'true') not null,
cgm1idd numeric(38) not null,
cgm1imd char(4) not null,
cgm1cdd varchar(100) not null,
cgm1idc numeric(38) not null,
cgm1imc char(4) not null,
cgm1cdc varchar(100) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE002', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge003 (
cge3cod numeric(38) options (key 'true') not null,
cge3des varchar(30) not null,
cge3tip char(1) not null,
cge3lon numeric(38) not null,
cge3dec numeric(38),
cge3obl char(1) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE003', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge004 (
cge1cod char(5) options (key 'true') not null,
cge3cod numeric(38) options (key 'true') not null,
cge4val varchar(100) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE004', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge005 (
cge1cod char(5) options (key 'true') not null,
cge5cod varchar(5) options (key 'true') not null,
cge5des varchar(40) not null,
cge5res varchar(40),
cge5tel varchar(15),
cge5fax varchar(15),
cge5mai varchar(50),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE005', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge006 (
pr1cod numeric(38) options (key 'true') not null,
pr1nom varchar(50) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE006', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge007 (
cge7cod numeric(38) options (key 'true') not null,
cge7des varchar(40) not null,
cge7fis varchar(30) not null,
cge7res char(1) not null,
cge15cod char(4) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE007', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge008 (
cge1cod char(5) options (key 'true') not null,
cge7cod numeric(38) options (key 'true') not null,
cge10cod numeric(38) options (key 'true') not null,
cge8tip char(1) not null,
cge8lon numeric(38) not null,
cge8rin numeric(38),
cge8rsu numeric(38),
cge8mas varchar(20) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE008', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge009 (
cge9cod numeric(38) options (key 'true') not null,
cge9des varchar(40) not null,
cge9loc varchar(40) not null,
cge9usr varchar(30) not null,
cge9pas varchar(30) not null,
cge9dip varchar(30) not null,
cge9pip varchar(30) not null,
cge13cod numeric(38) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE009', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge010 (
cge1cod char(5) options (key 'true') not null,
cge10cod numeric(38) options (key 'true') not null,
cge10nbd varchar(40) not null,
cge10usc varchar(30),
cge10psc varchar(30),
cge10act char(1) not null,
cge9cod numeric(38) not null,
cge17cod numeric(38) not null,
cge18con numeric(38) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE010', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge011 (
cge11cod numeric(38) options (key 'true') not null,
cge11des varchar(40) not null,
cge11can numeric(38) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE011', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge012 (
cge1cod char(5) options (key 'true') not null,
cge12deu char(5) options (key 'true') not null,
cge12por double precision not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE012', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge013 (
cge13cod numeric(38) options (key 'true') not null,
cge13des varchar(40) not null,
cge13mar varchar(40) not null,
cge13ver varchar(20) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE013', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge014 (
cge1cod char(5) options (key 'true') not null,
cge15cod char(4) options (key 'true') not null,
cge16con numeric(38) not null,
cge10cod numeric(38) not null,
cge14fec timestamp not null,
cge14usr varchar(30) not null,
cge14ccn varchar(50) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE014', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge015 (
cge15cod char(4) options (key 'true') not null,
cge15nom varchar(40) not null,
cge15url varchar(60),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE015', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge016 (
cge15cod char(4) options (key 'true') not null,
cge16con numeric(38) options (key 'true') not null,
cge16ver numeric(38) not null,
cge16mej numeric(38) not null,
cge16cor numeric(38) not null,
cge16for varchar(12) not null,
cge16doc char(1) not null,
cge16man char(1) not null,
cge16fec timestamp,
cge16not varchar(250),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE016', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge017 (
cge17cod numeric(38) options (key 'true') not null,
cge17nom varchar(40) not null,
cge17fab varchar(40) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE017', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge018 (
cge17cod numeric(38) options (key 'true') not null,
cge18con numeric(38) options (key 'true') not null,
cge18ver varchar(30) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE018', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge019 (
cge15cod char(4) options (key 'true') not null,
cge16con numeric(38) options (key 'true') not null,
cge19con numeric(38) options (key 'true') not null,
cge19dad numeric(38),
cge19nom varchar(60) not null,
cge19tip char(1) not null,
cge19inf varchar(255),
cge19lab varchar(100) not null,
cge19lnk varchar(255) not null,
cge19sec numeric(38),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE019', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge020 (
cge20cod numeric(38) options (key 'true') not null,
cge20pas varchar(32) not null,
cge20nol varchar(30) not null,
cge20noc varchar(30),
cge20est numeric(38) not null,
cge20cre timestamp not null,
cge20fex timestamp,
cge20fui timestamp,
cge20tui varchar(80),
cge20fcc timestamp,
cge20act char(1) not null,
cge20fdb timestamp,
cge20ifu numeric(38) not null,
cge20ifa numeric(38),
cge20eml varchar(40),
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE020', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge021 (
cge20cod numeric(38) options (key 'true') not null,
cge1cod char(5) options (key 'true') not null,
cge15cod char(4) options (key 'true') not null,
cge21fec timestamp not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE021', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge022 (
cge1cod char(5) options (key 'true') not null,
cge15cod char(4) options (key 'true') not null,
cge22fec timestamp options (key 'true') not null,
cge10cod numeric(38) not null,
cge16con numeric(38) not null,
cge14fec timestamp not null,
cge14usr varchar(30) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE022', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge023 (
cge11cod numeric(38) options (key 'true') not null,
cge1cod char(5) options (key 'true') not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE023', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge024 (
cge24cod numeric(38) options (key 'true') not null,
cge24nom varchar(40) not null,
ts_rversion timestamp
) server  options(schema 'FECXC', table 'CGE024', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge025 (
cge24cod numeric(38) options (key 'true') not null,
cge15cod char(4) options (key 'true') not null,
cge16con numeric(38) options (key 'true') not null,
cge19con numeric(38) options (key 'true') not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE025', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge026 (
cge1cod char(5) options (key 'true') not null,
cge20cod numeric(38) options (key 'true') not null,
cge24cod numeric(38) options (key 'true') not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE026', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cge027 (
cge27cod char(2) options (key 'true') not null,
cge27nom varchar(40) not null,
cgm1id numeric(38) not null,
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGE027', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgec01 (
cgecbat numeric(38) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEC01', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgem02 (
cgexori char(2) options (key 'true') not null,
cgedori varchar(40) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEM02', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgem03 (
cgexori char(2) options (key 'true') not null,
cgexsub char(2) options (key 'true') not null,
cgedsub varchar(40) not null,
cgexest char(1) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEM03', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cget02 (
cgecbat numeric(38) options (key 'true') not null,
cgexfec timestamp not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cge1eaf char(5) not null,
cgexdes varchar(30) not null,
cge5saf char(5) not null,
cgexusr varchar(30) not null,
cgexdeb double precision not null,
cgexcre double precision not null,
cgexdoc varchar(12) not null,
cgexmon double precision not null,
moncod char(2) not null,
cgextcm double precision not null,
cgexeli char(1) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGET02', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cget03 (
cgecbat numeric(38) options (key 'true') not null,
cgeclin numeric(38) options (key 'true') not null,
cgexori char(2) not null,
cgexsub char(2) not null,
cgexrf1 varchar(12),
cgexrf2 varchar(12),
cgextip varchar(1) not null,
cgexmon double precision not null,
cgextcm double precision not null,
cgexdes varchar(30),
moncod char(2) not null,
cgm1id numeric(38) not null,
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGET03', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgex02 (
cgecbat numeric(38) options (key 'true') not null,
cgexfec timestamp not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cge1eaf char(5) not null,
cgexdes varchar(30) not null,
cge5saf char(5) not null,
cgexusr varchar(30) not null,
cgexdeb double precision not null,
cgexcre double precision not null,
cgexdoc varchar(12) not null,
cgexmon double precision not null,
moncod char(2) not null,
cgextcm double precision not null,
cgexeli char(1) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEX02', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgex03 (
cgecbat numeric(38) options (key 'true') not null,
cgeclin numeric(38) options (key 'true') not null,
cgexori char(2) not null,
cgexsub char(2) not null,
cgexrf1 varchar(12),
cgexrf2 varchar(12),
cgextip varchar(1) not null,
cgexmon double precision not null,
moncod char(2) not null,
cgextcm double precision not null,
cgexdes varchar(30),
cgm1id numeric(38) not null,
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEX03', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgex04 (
cgecbat numeric(38) options (key 'true') not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cgexdoc varchar(12) not null,
cgexusr varchar(30) not null,
cgexfec timestamp not null,
cgexmon double precision not null,
moncod char(2) not null,
cgextcm double precision not null,
cgexmic char(1) not null,
ctdtip char(1) not null,
cgexdes varchar(30) not null,
cgm1id numeric(38),
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
cge27cod char(2),
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEX04', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgex05 (
cgecbat numeric(38) options (key 'true') not null,
cgeclin numeric(38) options (key 'true') not null,
cgexdoc varchar(12) not null,
cgexfec timestamp not null,
cge27cod char(2) not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cgexmon double precision not null,
moncod char(2) not null,
cgextcm double precision not null,
cgm1id numeric(38),
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
cgextip char(1) not null,
cgexeli char(1) not null,
cgexrf1 varchar(12),
cgexrf2 varchar(12),
timestamp timestamp
) server  options(schema 'FECXC', table 'CGEX05', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgm001 (
cg15id numeric(38) not null,
cgm1id numeric(38) options (key 'true') not null,
cgm1im char(4),
cgm1cd varchar(100),
cgm1ip numeric(38),
cgm1ni numeric(38) not null,
cgm1ic numeric(38),
ctades varchar(100),
ctaedi char(1),
ctafec varchar(8),
ctamov char(1),
ctaniv char(1),
ctasal char(1),
ctatip char(1),
ctausu varchar(10),
ctabal char(1) not null,
ctaref char(1),
ctaefe char(1),
ctadol char(1),
ctadef varchar(40),
ctaaux char(1),
cgm1au numeric(38) not null,
cgm1re varchar(255),
cgm1fi varchar(100),
timestamp timestamp
) server  options(schema 'FECXC', table 'CGM001', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table cgx001 (
cgpbat numeric(38) not null,
cgpmes numeric(38) not null,
cgppmf numeric(38) not null,
cgpuac numeric(38),
cgpumc numeric(38),
cgpano numeric(38) not null,
cgmloc varchar(2) not null,
cgmfun varchar(2),
cgppma numeric(38) not null,
bdcorp varchar(40),
cg5f52 numeric(38),
cgpnpe numeric(38),
cgppea numeric(38),
cgpupc numeric(38),
cgpppa numeric(38),
cgxori varchar(2),
cgxsub varchar(2),
cgpvpk char(1),
cgpdpf char(1),
cgpsgr numeric(38),
cg13gr numeric(38),
cgpttc char(1) not null,
cgpftc varchar(10) not null,
tipval char(1) not null,
cgmasi char(1),
cgx1av numeric(38),
cgx1ac numeric(38),
cgx1ii char(4),
cgx1if varchar(100),
cgx1i2 char(4),
cgx1i3 varchar(100),
cgx1gi char(4),
cgx1gf varchar(100),
cgx1g2 char(4),
cgx1g3 varchar(100),
cgx1se char(1),
timestamp timestamp
) server  options(schema 'FECXC', table 'CGX001', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table entidades (
entidad varchar(30) options (key 'true') not null,
descripcion varchar(40) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'ENTIDADES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_access_privs (
ap_id numeric(10) options (key 'true') not null,
ap_type varchar(10) not null,
ap_eu_id numeric(10) not null,
ap_priv_level numeric(2) not null,
gp_app_id numeric(10),
gba_ba_id numeric(10),
gd_doc_id numeric(10),
ap_element_state numeric(10) not null,
ap_created_by varchar(64) not null,
ap_created_date timestamp(0) not null,
ap_updated_by varchar(64),
ap_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_ACCESS_PRIVS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_app_params (
app_id numeric(10) options (key 'true') not null,
app_type varchar(10) not null,
app_name_mn numeric(10) not null,
app_description_mn numeric(10) not null,
sp_default_value varchar(240),
sp_value varchar(240),
app_element_state numeric(10) not null,
app_created_by varchar(64) not null,
app_created_date timestamp(0) not null,
app_updated_by varchar(64),
app_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_APP_PARAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_asmp_cons (
apc_id numeric(10) options (key 'true') not null,
apc_type varchar(10) not null,
apc_cons_type numeric(2) not null,
apc_asmp_id numeric(10) not null,
aoc_obj_id numeric(10),
asoc_sumo_id numeric(10),
auc_eu_id numeric(10),
apc_element_state numeric(10) not null,
apc_created_by varchar(64) not null,
apc_created_date timestamp(0) not null,
apc_updated_by varchar(64),
apc_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_ASMP_CONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_asmp_logs (
apl_id numeric(10) options (key 'true') not null,
apl_timestamp timestamp(0) not null,
apl_event_type numeric(2) not null,
apl_asmp_id numeric(10) not null,
apl_sumo_id numeric(10),
apl_element_state numeric(10) not null,
apl_created_by varchar(64) not null,
apl_created_date timestamp(0) not null,
apl_updated_by varchar(64),
apl_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_ASMP_LOGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_asm_policies (
asmp_id numeric(10) options (key 'true') not null,
asmp_name varchar(100) not null,
asmp_developer_key varchar(100) not null,
asmp_description varchar(240),
asmp_user_prop1 varchar(100),
asmp_user_prop2 varchar(100),
asmp_element_state numeric(10) not null,
asmp_created_by varchar(64) not null,
asmp_created_date timestamp(0) not null,
asmp_updated_by varchar(64),
asmp_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_ASM_POLICIES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_bas (
ba_id numeric(10) options (key 'true') not null,
ba_name varchar(100) not null,
ba_developer_key varchar(100) not null,
ba_description varchar(240),
ba_ext_name varchar(64),
ba_user_prop1 varchar(100),
ba_user_prop2 varchar(100),
ba_element_state numeric(10) not null,
ba_created_by varchar(64) not null,
ba_created_date timestamp(0) not null,
ba_updated_by varchar(64),
ba_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_batch_params (
bp_id numeric(10) options (key 'true') not null,
bp_name varchar(100) not null,
bp_value1 varchar(250) not null,
bp_value2 varchar(250),
bp_value3 varchar(250),
bp_value4 varchar(250),
bp_value5 varchar(250),
bp_value6 varchar(250),
bp_bs_id numeric(10) not null,
bp_element_state numeric(10) not null,
bp_created_by varchar(64) not null,
bp_created_date timestamp(0) not null,
bp_updated_by varchar(64),
bp_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BATCH_PARAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_batch_queries (
bq_id numeric(10) options (key 'true') not null,
bq_bs_id numeric(10) not null,
bq_query_id varchar(240) not null,
bq_result_sql_1 varchar(250),
bq_result_sql_2 varchar(250),
bq_result_sql_3 varchar(250),
bq_result_sql_4 varchar(250),
bq_element_state numeric(10) not null,
bq_created_by varchar(64) not null,
bq_created_date timestamp(0) not null,
bq_updated_by varchar(64),
bq_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BATCH_QUERIES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_batch_reports (
br_id numeric(10) options (key 'true') not null,
br_name varchar(100) not null,
br_workbook_name varchar(240) not null,
br_description varchar(240),
br_next_run_date timestamp(0),
br_job_id numeric(22),
br_expiry numeric(22),
br_completion_date timestamp(0),
br_num_freq_units numeric(22),
br_eu_id numeric(10) not null,
br_rfu_id numeric(10) not null,
br_auto_refresh numeric(1) not null,
br_report_schema varchar(64) not null,
br_element_state numeric(10) not null,
br_created_by varchar(64) not null,
br_created_date timestamp(0) not null,
br_updated_by varchar(64),
br_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BATCH_REPORTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_batch_sheets (
bs_id numeric(10) options (key 'true') not null,
bs_br_id numeric(10) not null,
bs_sheet_name varchar(240) not null,
bs_sheet_id varchar(240) not null,
bs_element_state numeric(10) not null,
bs_created_by varchar(64) not null,
bs_created_date timestamp(0) not null,
bs_updated_by varchar(64),
bs_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BATCH_SHEETS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_ba_obj_links (
bol_id numeric(10) options (key 'true') not null,
bol_ba_id numeric(10) not null,
bol_obj_id numeric(10) not null,
bol_sequence numeric(22),
bol_element_state numeric(10) not null,
bol_created_by varchar(64) not null,
bol_created_date timestamp(0) not null,
bol_updated_by varchar(64),
bol_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BA_OBJ_LINKS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_bq_deps (
bqd_id numeric(10) options (key 'true') not null,
bqd_type varchar(10) not null,
bqd_bq_id numeric(10) not null,
bfild_fil_id numeric(10),
bid_it_id numeric(10),
bfund_fun_id numeric(10),
bqd_element_state numeric(10) not null,
bqd_created_by varchar(64) not null,
bqd_created_date timestamp(0) not null,
bqd_updated_by varchar(64),
bqd_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BQ_DEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_bq_tables (
bqt_id numeric(10) options (key 'true') not null,
bqt_bq_id numeric(10) not null,
bqt_brr_id numeric(10) not null,
bqt_table_name varchar(64) not null,
bqt_element_state numeric(10) not null,
bqt_created_by varchar(64) not null,
bqt_created_date timestamp(0) not null,
bqt_updated_by varchar(64),
bqt_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BQ_TABLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_br_runs (
brr_id numeric(10) options (key 'true') not null,
brr_br_id numeric(10) not null,
brr_run_number numeric(22) not null,
brr_state numeric(2) not null,
brr_run_date timestamp(0),
brr_svr_err_code numeric,
brr_svr_err_text varchar(240),
brr_act_elap_time numeric,
brr_element_state numeric(10) not null,
brr_created_by varchar(64) not null,
brr_created_date timestamp(0) not null,
brr_updated_by varchar(64),
brr_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_BR_RUNS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_dbh_nodes (
dhn_id numeric(10) options (key 'true') not null,
dhn_name varchar(100) not null,
dhn_developer_key varchar(100) not null,
dhn_description varchar(240),
dhn_data_fmt_msk varchar(100) not null,
dhn_disp_fmt_msk varchar(100) not null,
dhn_hi_id numeric(10) not null,
dhn_user_prop2 varchar(100),
dhn_user_prop1 varchar(100),
dhn_element_state numeric(10) not null,
dhn_created_by varchar(64) not null,
dhn_created_date timestamp(0) not null,
dhn_updated_by varchar(64),
dhn_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_DBH_NODES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_documents (
doc_id numeric(10) options (key 'true') not null,
doc_name varchar(100) not null,
doc_developer_key varchar(100) not null,
doc_description varchar(240),
doc_eu_id numeric(10) not null,
doc_length numeric(22) not null,
doc_batch numeric(1) not null,
doc_content_type varchar(100) not null,
doc_document bytea,
doc_user_prop2 varchar(100),
doc_user_prop1 varchar(100),
doc_element_state numeric(10) not null,
doc_created_by varchar(64) not null,
doc_created_date timestamp(0) not null,
doc_updated_by varchar(64),
doc_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_DOCUMENTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_domains (
dom_id numeric(10) options (key 'true') not null,
dom_name varchar(100) not null,
dom_developer_key varchar(100) not null,
dom_description varchar(240),
dom_data_type numeric(2) not null,
dom_logical_item numeric(1) not null,
dom_sys_generated numeric(1) not null,
dom_cardinality numeric(22),
dom_last_exec_time numeric(22),
dom_cached numeric(1) not null,
dom_it_id_lov numeric(10),
dom_it_id_rank numeric(10),
dom_user_prop2 varchar(100),
dom_user_prop1 varchar(100),
dom_element_state numeric(10) not null,
dom_created_by varchar(64) not null,
dom_created_date timestamp(0) not null,
dom_updated_by varchar(64),
dom_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_DOMAINS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_elem_xrefs (
ex_id numeric(10) options (key 'true') not null,
ex_type numeric(2) not null,
ex_ref1 varchar(100) not null,
ex_el_type varchar(10) not null,
ex_el_id numeric(10) not null,
ex_ref2 varchar(100)
) server  options(schema 'FECXC', table 'EUL4_ELEM_XREFS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_eul_users (
eu_id numeric(10) options (key 'true') not null,
eu_username varchar(64) not null,
eu_security_model numeric(2) not null,
eu_use_pub_privs numeric(1) not null,
eu_query_time_lmt numeric(22),
eu_query_est_lmt numeric(22),
eu_row_fetch_lmt numeric(22),
eu_role_flag numeric(1) not null,
eu_batch_jobs_lmt numeric(22),
eu_batch_wnd_start timestamp(0),
eu_batch_wnd_end timestamp(0),
eu_batch_qtime_lmt numeric(22),
eu_batch_expiry numeric(22),
eu_batch_cmt_sz numeric(22),
eu_batch_rep_user varchar(64),
eu_element_state numeric(10) not null,
eu_created_by varchar(64) not null,
eu_created_date timestamp(0) not null,
eu_updated_by varchar(64),
eu_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_EUL_USERS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_expressions (
exp_id numeric(10) options (key 'true') not null,
exp_type varchar(10) not null,
exp_name varchar(100) not null,
exp_developer_key varchar(100) not null,
exp_description varchar(240),
exp_formula1 varchar(250),
exp_data_type numeric(2) not null,
exp_sequence numeric(22),
it_dom_id numeric(10),
it_obj_id numeric(10),
it_doc_id numeric(10),
it_format_mask varchar(100),
it_max_data_width numeric,
it_max_disp_width numeric,
it_alignment numeric(2),
it_word_wrap numeric(1),
it_disp_null_val varchar(100),
it_fun_id numeric(10),
it_heading varchar(240),
it_hidden numeric(1),
it_placement numeric(2),
it_user_def_fmt varchar(100),
it_case_storage numeric(2),
it_case_display numeric(2),
it_ext_column varchar(64),
ci_it_id numeric(10),
ci_runtime_item numeric(1),
par_multiple_vals numeric(1),
co_nullable numeric(1),
p_case_sensitive numeric(1),
jp_key_id numeric(10),
fil_obj_id numeric(10),
fil_doc_id numeric(10),
fil_runtime_filter numeric(1),
fil_app_type numeric(2),
fil_ext_filter varchar(64),
exp_user_prop2 varchar(100),
exp_user_prop1 varchar(100),
exp_element_state numeric(10) not null,
exp_created_by varchar(64) not null,
exp_created_date timestamp(0) not null,
exp_updated_by varchar(64),
exp_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_EXPRESSIONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_exp_deps (
ed_id numeric(10) options (key 'true') not null,
ed_type varchar(10) not null,
pd_p_id numeric(10),
ped_exp_id numeric(10),
pfd_fun_id numeric(10),
psd_sq_id numeric(10),
cd_exp_id numeric(10),
cfd_fun_id numeric(10),
cid_exp_id numeric(10),
ed_element_state numeric(10) not null,
ed_created_by varchar(64) not null,
ed_created_date timestamp(0) not null,
ed_updated_by varchar(64),
ed_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_EXP_DEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_freq_units (
rfu_id numeric(10) options (key 'true') not null,
rfu_name_mn numeric(10) not null,
rfu_sql_expression varchar(240) not null,
rfu_sequence numeric(22),
rfu_element_state numeric(10) not null,
rfu_created_by varchar(64) not null,
rfu_created_date timestamp(0) not null,
rfu_updated_by varchar(64),
rfu_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_FREQ_UNITS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_functions (
fun_id numeric(10) options (key 'true') not null,
fun_name varchar(100) not null,
fun_developer_key varchar(100) not null,
fun_description_s varchar(240),
fun_description_mn numeric(10),
fun_function_type numeric(2) not null,
fun_hidden numeric(1) not null,
fun_data_type numeric(2) not null,
fun_available numeric(1) not null,
fun_maximum_args numeric(22),
fun_minimum_args numeric(22) not null,
fun_built_in numeric(1) not null,
fun_ext_name varchar(64) not null,
fun_ext_package varchar(64),
fun_ext_owner varchar(64),
fun_ext_db_link varchar(64),
fun_user_prop2 varchar(100),
fun_user_prop1 varchar(100),
fun_element_state numeric(10) not null,
fun_created_by varchar(64) not null,
fun_created_date timestamp(0) not null,
fun_updated_by varchar(64),
fun_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_FUNCTIONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_fun_arguments (
fa_id numeric(10) options (key 'true') not null,
fa_name_s varchar(100),
fa_name_mn numeric(10),
fa_developer_key varchar(100) not null,
fa_description_s varchar(240),
fa_description_mn numeric(10),
fa_data_type numeric(2) not null,
fa_optional numeric(1) not null,
fa_position numeric(22) not null,
fa_fun_id numeric(10) not null,
fa_user_prop2 varchar(100),
fa_user_prop1 varchar(100),
fa_element_state numeric(10) not null,
fa_created_by varchar(64) not null,
fa_created_date timestamp(0) not null,
fa_updated_by varchar(64),
fa_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_FUN_ARGUMENTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_fun_ctgs (
fc_id numeric(10) options (key 'true') not null,
fc_name_s varchar(100),
fc_name_mn numeric(10),
fc_developer_key varchar(100) not null,
fc_description_s varchar(240),
fc_description_mn numeric(10),
fc_user_prop2 varchar(100),
fc_user_prop1 varchar(100),
fc_element_state numeric(10) not null,
fc_created_by varchar(64) not null,
fc_created_date timestamp(0) not null,
fc_updated_by varchar(64),
fc_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_FUN_CTGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_fun_fc_links (
ffl_id numeric(10) options (key 'true') not null,
ffl_fun_id numeric(10) not null,
ffl_fc_id numeric(10) not null,
ffl_element_state numeric(10) not null,
ffl_created_by varchar(64) not null,
ffl_created_date timestamp(0) not null,
ffl_updated_by varchar(64),
ffl_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_FUN_FC_LINKS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_gateways (
gw_id numeric(10) options (key 'true') not null,
gw_type varchar(10) not null,
gw_gateway_name varchar(100) not null,
gw_product_name varchar(100) not null,
gw_description varchar(240),
egw_version varchar(30),
egw_database_link varchar(64),
egw_schema varchar(64),
egw_sql_paradigm varchar(10),
gw_element_state numeric(10) not null,
gw_created_by varchar(64) not null,
gw_created_date timestamp(0) not null,
gw_updated_by varchar(64),
gw_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_GATEWAYS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_hierarchies (
hi_id numeric(10) options (key 'true') not null,
hi_type varchar(10) not null,
hi_name varchar(100) not null,
hi_developer_key varchar(100) not null,
hi_description varchar(240),
hi_sys_generated numeric(1) not null,
hi_ext_hierarchy varchar(64),
dbh_default numeric(1),
ibh_dbh_id numeric(10),
hi_user_prop2 varchar(100),
hi_user_prop1 varchar(100),
hi_element_state numeric(10) not null,
hi_created_by varchar(64) not null,
hi_created_date timestamp(0) not null,
hi_updated_by varchar(64),
hi_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_HIERARCHIES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_hi_nodes (
hn_id numeric(10) options (key 'true') not null,
hn_name varchar(100) not null,
hn_developer_key varchar(100) not null,
hn_description varchar(240),
hn_hi_id numeric(10) not null,
hn_ext_node varchar(64),
hn_user_prop2 varchar(100),
hn_user_prop1 varchar(100),
hn_element_state numeric(10) not null,
hn_created_by varchar(64) not null,
hn_created_date timestamp(0) not null,
hn_updated_by varchar(64),
hn_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_HI_NODES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_hi_segments (
hs_id numeric(10) options (key 'true') not null,
hs_type varchar(10) not null,
dhs_hi_id numeric(10),
dhs_dhn_id_child numeric(10),
dhs_dhn_id_parent numeric(10),
ihs_hn_id_child numeric(10),
ihs_hn_id_parent numeric(10),
ihs_hi_id numeric(10),
hs_element_state numeric(10) not null,
hs_created_by varchar(64) not null,
hs_created_date timestamp(0) not null,
hs_updated_by varchar(64),
hs_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_HI_SEGMENTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_ig_exp_links (
iel_id numeric(10) options (key 'true') not null,
iel_type varchar(10) not null,
hil_exp_id numeric(10),
hil_hn_id numeric(10),
kil_exp_id numeric(10),
kil_key_id numeric(10),
kil_sequence numeric(22),
iel_element_state numeric(10) not null,
iel_created_by varchar(64) not null,
iel_created_date timestamp(0) not null,
iel_updated_by varchar(64),
iel_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_IG_EXP_LINKS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_ihs_fk_links (
ifl_id numeric(10) options (key 'true') not null,
ifl_ihs_id numeric(10) not null,
ifl_key_id numeric(10) not null,
ifl_element_state numeric(10) not null,
ifl_created_by varchar(64) not null,
ifl_created_date timestamp(0) not null,
ifl_updated_by varchar(64),
ifl_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_IHS_FK_LINKS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_key_cons (
key_id numeric(10) options (key 'true') not null,
key_type varchar(10) not null,
key_name varchar(100) not null,
key_developer_key varchar(100) not null,
key_description varchar(240),
key_ext_key varchar(64),
key_obj_id numeric(10) not null,
uk_primary numeric(1),
fk_key_id_remote numeric(10),
fk_obj_id_remote numeric(10),
fk_one_to_one numeric(1),
fk_mstr_no_detail numeric(1),
fk_dtl_no_master numeric(1),
fk_mandatory numeric(1),
key_user_prop2 varchar(100),
key_user_prop1 varchar(100),
key_element_state numeric(10) not null,
key_created_by varchar(64) not null,
key_created_date timestamp(0) not null,
key_updated_by varchar(64),
key_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_KEY_CONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_objs (
obj_id numeric(10) options (key 'true') not null,
obj_type varchar(10) not null,
obj_name varchar(100) not null,
obj_developer_key varchar(100) not null,
obj_description varchar(240),
obj_ba_id numeric(10),
obj_hidden numeric(1) not null,
obj_distinct_flag numeric(1) not null,
obj_ndeterministic numeric(1) not null,
obj_cbo_hint varchar(100),
obj_ext_object varchar(64),
obj_ext_owner varchar(64),
obj_ext_db_link varchar(64),
obj_object_sql1 varchar(250),
obj_object_sql2 varchar(250),
obj_object_sql3 varchar(250),
sobj_ext_table varchar(64),
obj_user_prop2 varchar(100),
obj_user_prop1 varchar(100),
obj_element_state numeric(10) not null,
obj_created_by varchar(64) not null,
obj_created_date timestamp(0) not null,
obj_updated_by varchar(64),
obj_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_OBJS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_obj_deps (
od_id numeric(10) options (key 'true') not null,
od_obj_id_from numeric(10) not null,
od_obj_id_to numeric(10) not null,
od_element_state numeric(10) not null,
od_created_by varchar(64) not null,
od_created_date timestamp(0) not null,
od_updated_by varchar(64),
od_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_OBJ_DEPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_obj_join_usgs (
oju_id numeric(10) options (key 'true') not null,
oju_obj_id numeric(10),
oju_join_modified numeric(1) not null,
oju_key_id numeric(10) not null,
oju_sumo_id numeric(10),
oju_element_state numeric(10) not null,
oju_created_by varchar(64) not null,
oju_created_date timestamp(0) not null,
oju_updated_by varchar(64),
oju_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_OBJ_JOIN_USGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_plan_table (
statement_id varchar(30),
timestamp timestamp(0),
remarks varchar(80),
operation varchar(30),
options varchar(30),
object_node varchar(128),
object_owner varchar(30),
object_name varchar(30),
object_instance numeric,
object_type varchar(30),
optimizer varchar(255),
search_columns numeric(38),
id numeric,
parent_id numeric,
position numeric,
cost numeric,
cardinality numeric,
bytes numeric,
other_tag varchar(255),
partition_start varchar(255),
partition_stop varchar(255),
partition_id numeric,
other text,
distribution varchar(30)
) server  options(schema 'FECXC', table 'EUL4_PLAN_TABLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_qpp_stats (
qs_id numeric(10) options (key 'true') not null,
qs_cost numeric,
qs_act_cpu_time numeric,
qs_act_elap_time numeric not null,
qs_est_elap_time numeric not null,
qs_object_use_key varchar(240) not null,
qs_summary_fit numeric(2),
qs_state numeric(1),
qs_num_rows numeric(10),
qs_doc_owner varchar(64),
qs_doc_name varchar(100),
qs_doc_details varchar(240),
qs_sdo_id numeric(10),
qs_dbmp0 bytea,
qs_dbmp1 bytea,
qs_dbmp2 bytea,
qs_dbmp3 bytea,
qs_dbmp4 bytea,
qs_dbmp5 bytea,
qs_dbmp6 bytea,
qs_dbmp7 bytea,
qs_mbmp0 bytea,
qs_mbmp1 bytea,
qs_mbmp2 bytea,
qs_mbmp3 bytea,
qs_mbmp4 bytea,
qs_mbmp5 bytea,
qs_mbmp6 bytea,
qs_mbmp7 bytea,
qs_jbmp0 bytea,
qs_jbmp1 bytea,
qs_jbmp2 bytea,
qs_jbmp3 bytea,
qs_jbmp4 bytea,
qs_jbmp5 bytea,
qs_jbmp6 bytea,
qs_jbmp7 bytea,
qs_fbmp0 bytea,
qs_fbmp1 bytea,
qs_fbmp2 bytea,
qs_fbmp3 bytea,
qs_fbmp4 bytea,
qs_fbmp5 bytea,
qs_fbmp6 bytea,
qs_fbmp7 bytea,
qs_created_by varchar(64) not null,
qs_created_date timestamp(0) not null
) server  options(schema 'FECXC', table 'EUL4_QPP_STATS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_segments (
seg_id numeric(10) options (key 'true') not null,
seg_seg_type numeric(1) not null,
seg_sequence numeric(22) not null,
seg_obj_id numeric(10),
seg_sumo_id numeric(10),
seg_cuo_id numeric(10),
seg_bq_id numeric(10),
seg_exp_id numeric(10),
seg_sms_id numeric(10),
seg_el_id numeric(10),
seg_chunk1 varchar(250),
seg_chunk2 varchar(250),
seg_chunk3 varchar(250),
seg_chunk4 varchar(250),
seg_element_state numeric(10) not null,
seg_created_by varchar(64) not null,
seg_created_date timestamp(0) not null,
seg_updated_by varchar(64),
seg_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SEGMENTS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sequences (
seq_id numeric(10) not null,
seq_name varchar(100) not null,
seq_nextval numeric(22) not null
) server  options(schema 'FECXC', table 'EUL4_SEQUENCES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sq_crrltns (
sqc_id numeric(10) options (key 'true') not null,
sqc_sq_id numeric(10) not null,
sqc_it_inner_id numeric(10) not null,
sqc_it_outer_id numeric(10) not null,
sqc_element_state numeric(10) not null,
sqc_created_by varchar(64) not null,
sqc_created_date timestamp(0) not null,
sqc_updated_by varchar(64),
sqc_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SQ_CRRLTNS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sub_queries (
sq_id numeric(10) options (key 'true') not null,
sq_name varchar(100) not null,
sq_developer_key varchar(100) not null,
sq_description varchar(240),
sq_obj_id numeric(10) not null,
sq_it_id numeric(10) not null,
sq_fil_id numeric(10) not null,
sq_user_prop2 varchar(100),
sq_user_prop1 varchar(100),
sq_element_state numeric(10) not null,
sq_created_by varchar(64) not null,
sq_created_date timestamp(0) not null,
sq_updated_by varchar(64),
sq_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SUB_QUERIES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_summary_objs (
sumo_id numeric(10) options (key 'true') not null,
sumo_type varchar(10) not null,
sumo_internal numeric(1) not null,
sumo_item_deleted numeric(1) not null,
sumo_item_modified numeric(1) not null,
sumo_join_state numeric(1) not null,
sumo_validity numeric(1) not null,
sumo_ext_object varchar(64),
sumo_ext_owner varchar(64),
sumo_ext_db_link varchar(64),
sumo_asmp_id numeric(10),
sumo_active numeric(1) not null,
sbo_srs_id numeric(10),
sbo_max_item_comb numeric(22),
sdo_sbo_id numeric(10),
sdo_num_joins numeric(22),
sdo_num_usgs numeric(22),
sdo_num_axis_items numeric(22),
sdo_num_rows numeric(22),
sdo_bitmap_pos numeric(22),
sdo_object_sql1 varchar(250),
sdo_object_sql2 varchar(250),
sdo_object_sql3 varchar(250),
sdo_last_refresh timestamp(0),
sdo_table_name varchar(64),
sdo_table_owner varchar(64),
sdo_database_link varchar(64),
msdo_svr_err_code numeric(22),
msdo_svr_err_text varchar(240),
msdo_refresh_reqd numeric(1),
ems_commit_size numeric(22),
ems_state numeric(2),
sumo_element_state numeric(10) not null,
sumo_created_by varchar(64) not null,
sumo_created_date timestamp(0) not null,
sumo_updated_by varchar(64),
sumo_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SUMMARY_OBJS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sumo_exp_usgs (
seu_id numeric(10) options (key 'true') not null,
seu_type varchar(10) not null,
seu_sumo_id numeric(10) not null,
seu_ext_column varchar(64),
seu_visible numeric(1) not null,
siu_exp_id numeric(10),
siu_item_modified numeric(1),
smiu_fun_id numeric(10),
sfu_fun_id numeric(10),
seu_element_state numeric(10) not null,
seu_created_by varchar(64) not null,
seu_created_date timestamp(0) not null,
seu_updated_by varchar(64),
seu_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SUMO_EXP_USGS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sum_bitmaps (
sb_id numeric(10) options (key 'true') not null,
sb_bitmap bytea not null,
sb_sequence numeric(22) not null,
sb_exp_id numeric(10),
sb_key_id numeric(10),
sb_fun_id numeric(10),
sb_element_state numeric(10) not null,
sb_created_by varchar(64) not null,
sb_created_date timestamp(0) not null,
sb_updated_date timestamp(0),
sb_updated_by varchar(64),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SUM_BITMAPS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_sum_rfsh_sets (
srs_id numeric(10) options (key 'true') not null,
srs_name varchar(100) not null,
srs_developer_key varchar(100) not null,
srs_description varchar(240),
srs_state numeric(2) not null,
srs_online numeric(1) not null,
srs_auto_refresh numeric(1) not null,
srs_last_refresh timestamp(0),
srs_next_refresh timestamp(0),
srs_job_id numeric(22),
srs_eu_id numeric(10) not null,
srs_num_freq_units numeric(22),
srs_rfu_id numeric(10),
srs_refresh_count numeric(22),
srs_user_prop2 varchar(100),
srs_user_prop1 varchar(100),
srs_element_state numeric(10) not null,
srs_created_by varchar(64) not null,
srs_created_date timestamp(0) not null,
srs_updated_by varchar(64),
srs_updated_date timestamp(0),
notm numeric(10)
) server  options(schema 'FECXC', table 'EUL4_SUM_RFSH_SETS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table eul4_versions (
ver_name varchar(100),
ver_description varchar(240),
ver_release varchar(30) not null,
ver_min_code_ver varchar(30) not null,
ver_eul_timestamp varchar(30) not null,
ver_sa numeric(22)
) server  options(schema 'FECXC', table 'EUL4_VERSIONS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_clase_cliente_cat (
id_clase_cliente numeric options (key 'true') not null,
cod_clase_cliente varchar(20) not null,
des_clase_cliente varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_CLASE_CLIENTE_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_clasificacion_tab (
id_clasificacion numeric options (key 'true') not null,
folio_recibo numeric not null,
tipo_recibo varchar(20) not null,
orden numeric not null,
porcentaje_iva numeric not null,
importe_org numeric not null,
monto_base_org numeric not null,
monto_iva_org numeric not null,
importe_mxn numeric not null,
monto_base_mxn numeric not null,
monto_iva_mxn numeric not null,
importe_usd numeric not null,
monto_base_usd numeric not null,
monto_iva_usd numeric not null,
cod_segmento varchar(20) not null,
cod_grupo_forecast varchar(20) not null,
cod_concepto varchar(20),
cod_region varchar(20),
cod_pais varchar(20),
desc_cps varchar(100),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_CLASIFICACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_concepto_cat (
id_concepto numeric options (key 'true') not null,
cod_concepto varchar(20) not null,
des_concepto varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_CONCEPTO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_configuracion_cat (
id_configuracion numeric options (key 'true') not null,
cod_configuracion varchar(20) not null,
des_configuracion varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_CONFIGURACION_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_empresa_cat (
id_empresa numeric options (key 'true') not null,
cod_empresa varchar(20) not null,
des_empresa varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_EMPRESA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_empresa_cat_2 (
id_empresa numeric options (key 'true') not null,
cod_empresa varchar(20) not null,
des_empresa varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_EMPRESA_CAT_2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_emp_usu_tab (
id_usuario numeric,
id_empresa numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_EMP_USU_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_estimacion_tab (
id_estimacion numeric options (key 'true') not null,
cod_grupo_forecast varchar(20) not null,
cod_segmento varchar(20) not null,
num_anio numeric not null,
num_mes numeric not null,
num_semana numeric not null,
num_importe_mxn numeric not null,
num_importe_usd numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_ESTIMACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_grfc_segm_cat (
id_segmento numeric,
id_grupo_forecast numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_GRFC_SEGM_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_grupo_forecast_cat (
id_grupo_forecast numeric options (key 'true') not null,
cod_grupo_forecast varchar(20) not null,
des_grupo_forecast varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_GRUPO_FORECAST_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_moneda_cat (
id_moneda numeric options (key 'true') not null,
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_MONEDA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_moneda_cat_2 (
id_moneda numeric options (key 'true') not null,
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_MONEDA_CAT_2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_operacion_tab (
id_operacion numeric options (key 'true') not null,
des_agrupador varchar(100) not null,
cod_operacion varchar(100) not null,
des_nombre varchar(100) not null,
cod_tipo_operacion varchar(20),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_OPERACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_pais_cat (
id_pais numeric options (key 'true') not null,
id_region numeric not null,
cod_pais varchar(20) not null,
des_pais varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_PAIS_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_porcentaje_iva_cat (
id_porcentaje_iva numeric options (key 'true') not null,
cod_porcentaje_iva varchar(20) not null,
num_valor numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_PORCENTAJE_IVA_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_presupuesto_tab (
id_presupuesto numeric options (key 'true') not null,
cod_segmento varchar(20) not null,
cod_concepto varchar(20) not null,
cod_region varchar(20),
cod_moneda varchar(20) not null,
fec_presupuesto timestamp(0) not null,
num_gestion numeric not null,
num_importe numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_PRESUPUESTO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_recibo_manual_tab (
folio_recibo_manual numeric options (key 'true') not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
ref_cliente varchar(100) not null,
nom_cliente varchar(250) not null,
clase_cliente varchar(100) not null,
metodo_pago varchar(100) not null,
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null,
cod_cliente varchar(1000)
) server  options(schema 'FECXC', table 'FECI_RECIBO_MANUAL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_recibo_tab (
folio_recibo numeric options (key 'true') not null,
fec_ingreso timestamp(0) not null,
fec_deposito timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
nom_cliente varchar(250) not null,
ref_cliente varchar(100) not null,
clase_cliente varchar(100) not null,
metodo_pago varchar(100) not null,
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_RECIBO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_recibo_tab_2 (
folio_recibo numeric options (key 'true') not null,
fec_ingreso timestamp(0) not null,
fec_deposito timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
nom_cliente varchar(250) not null,
ref_cliente varchar(100) not null,
clase_cliente varchar(100) not null,
metodo_pago varchar(100) not null,
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_RECIBO_TAB_2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_region_cat (
id_region numeric options (key 'true') not null,
cod_region varchar(20) not null,
des_region varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_REGION_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_regn_conc_cat (
id_region numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_REGN_CONC_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_rol_operacion_tab (
id_rol numeric,
id_operacion numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_ROL_OPERACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_rol_tab (
id_rol numeric options (key 'true') not null,
cod_rol varchar(20) not null,
nom_rol varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_ROL_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_segmento_cat (
id_segmento numeric options (key 'true') not null,
cod_segmento varchar(20) not null,
des_segmento varchar(250) not null,
cod_moneda varchar(20) not null,
ind_cps numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_SEGMENTO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_segm_conc_cat (
id_segmento numeric,
id_grupo_forecast numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_SEGM_CONC_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_segm_pais_cat (
id_segmento numeric,
id_pais numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_SEGM_PAIS_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_segm_regn_cat (
id_segmento numeric,
id_region numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_SEGM_REGN_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_semanas_estimacion_tab (
id_semanas_estimacion numeric options (key 'true') not null,
num_anio numeric not null,
num_mes numeric not null,
fec_inicio_semana_1 timestamp(0) not null,
fec_fin_semana_1 timestamp(0) not null,
fec_inicio_semana_2 timestamp(0) not null,
fec_fin_semana_2 timestamp(0) not null,
fec_inicio_semana_3 timestamp(0) not null,
fec_fin_semana_3 timestamp(0) not null,
fec_inicio_semana_4 timestamp(0) not null,
fec_fin_semana_4 timestamp(0) not null,
fec_inicio_semana_5 timestamp(0),
fec_fin_semana_5 timestamp(0),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_SEMANAS_ESTIMACION_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_tipo_cambio_cat (
id_tipo_cambio numeric options (key 'true') not null,
fec_fecha_tc timestamp(0) not null,
cod_moneda varchar(20) not null,
num_valor numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_TIPO_CAMBIO_CAT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_tipo_cambio_cat_2 (
id_tipo_cambio numeric options (key 'true') not null,
fec_fecha_tc timestamp(0) not null,
cod_moneda varchar(20) not null,
num_valor numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_TIPO_CAMBIO_CAT_2', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table feci_usuario_tab (
id_usuario numeric options (key 'true') not null,
id_rol numeric,
des_email varchar(250) not null,
des_nombres varchar(150) not null,
des_apellidos varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) server  options(schema 'FECXC', table 'FECI_USUARIO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_bit_clasif_mas_tab (
id_session numeric,
cod_folio numeric(38),
num_linea numeric(38),
val_importe decimal(20,2),
cod_sec_importa numeric(38),
cod_clasif varchar(10),
cod_clas_desc varchar(40),
cod_subclasif varchar(10),
cod_sclasif_desc varchar(40),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15),
e_codigo numeric(38)
) server  options(schema 'FECXC', table 'FECXC_BIT_CLASIF_MAS_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_calendario_cob (
anio_cobranza numeric(38) options (key 'true') not null,
mes_cobranza numeric(38) options (key 'true') not null,
fecha_inicio timestamp(0) not null,
fecha_fin timestamp(0) not null
) server  options(schema 'FECXC', table 'FECXC_CALENDARIO_COB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_alafecha_pre (
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
presup_mes decimal(20,4),
presupreal_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_ALAFECHA_PRE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_alafech_cob_act (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20,4),
cobranzareal_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_ALAFECH_COB_ACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_alafech_cob_ant (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20,4),
cobranzareal_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_ALAFECH_COB_ANT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_deldia (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_dia decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_DELDIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_xmes_cob_act (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_XMES_COB_ACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_xmes_cob_ant (
e_codigo numeric(38),
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20,4),
cobranzareal_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_XMES_COB_ANT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_caninter_xmes_pre (
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
presup_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_CANINTER_XMES_PRE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_carga_presup (
moneda varchar(25),
fecha timestamp(0),
segmento varchar(25),
concepto varchar(25),
importe numeric,
anio numeric(38),
division varchar(25),
estatus_origen varchar(25)
) server  options(schema 'FECXC', table 'FECXC_CARGA_PRESUP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cat_xempresa (
e_codigo numeric(38) options (key 'true') not null,
cod_nivel numeric(38) options (key 'true') not null,
cod_sec_tipcat numeric(38)
) server  options(schema 'FECXC', table 'FECXC_CAT_XEMPRESA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cifras_control (
mes numeric,
periodo numeric,
segmento varchar(25),
importe_seg numeric,
concepto varchar(25),
importe_con numeric,
division varchar(25),
importe_div numeric,
canal varchar(25),
importe_can numeric,
region varchar(25),
importe_reg numeric
) server  options(schema 'FECXC', table 'FECXC_CIFRAS_CONTROL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cobranza_alafecha (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
cobranza_alafecha decimal(20,4),
cobranzareal_alafecha decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_COBRANZA_ALAFECHA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cobranza_anterior (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
cobranza_anterior decimal(20,4),
cobranzareal_anterior decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_COBRANZA_ANTERIOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cobranza_deldia (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
cobranza_dia decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_COBRANZA_DELDIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cobranza_delmes (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
cobranza_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_COBRANZA_DELMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cob_canal_anterior (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_anterior decimal(20,2),
cobranzareal_anterior decimal(20,2)
) server  options(schema 'FECXC', table 'FECXC_COB_CANAL_ANTERIOR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cob_canal_deldia (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_dia decimal(20,2)
) server  options(schema 'FECXC', table 'FECXC_COB_CANAL_DELDIA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_cob_canal_xmes (
e_codigo numeric(38),
segmento numeric(38),
codmoneda varchar(3),
mes numeric(38),
cobranza_mes decimal(20,2),
cobranzareal_mes decimal(20,2)
) server  options(schema 'FECXC', table 'FECXC_COB_CANAL_XMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_conceptos_x_tipo (
tipo_linea varchar(30) options (key 'true') not null,
cod_sec_tipcat numeric(38) options (key 'true') not null,
cod_sec_lin numeric(38) options (key 'true') not null,
visible_siono varchar(2)
) server  options(schema 'FECXC', table 'FECXC_CONCEPTOS_X_TIPO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_conciliacion_det_rep (
usuario varchar(50),
empresa varchar(60),
moneda varchar(40),
referencia varchar(10),
importe decimal(20,2),
folio numeric(10),
anno_rep numeric(4),
mes_rep varchar(20),
tipo varchar(30)
) server  options(schema 'FECXC', table 'FECXC_CONCILIACION_DET_REP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_conciliacion_rep (
usuario varchar(50),
secuencia numeric(38),
titulo varchar(50),
totaldercxc decimal(20,2),
totalizqcxc decimal(20,2),
totalderfe decimal(20,2),
totalizqfe decimal(20,2),
anno_rep numeric(4),
mes_rep varchar(20),
moneda varchar(40),
segrestar varchar(50)
) server  options(schema 'FECXC', table 'FECXC_CONCILIACION_REP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_dep_especiales (
no_empresa numeric(38) not null,
no_folio_det numeric(38) options (key 'true') not null,
fec_valor timestamp(0),
referencia varchar(30),
id_banco numeric(38),
id_banco_benef numeric(38),
id_chequera varchar(20),
concepto varchar(100),
tipo_cambio decimal(20,11),
importe decimal(20,2),
no_cheque numeric(38),
id_tipo_operacion_set numeric(38) options (key 'true') not null,
id_forma_pago numeric(38),
id_divisa varchar(3),
fec_valor_original timestamp(0),
id_status_mov varchar(1) options (key 'true') not null,
beneficiario varchar(60),
descripcion varchar(30),
secuencia_dep_especiales numeric(38),
no_cliente varchar(15),
periodo numeric(38),
cve_operacion numeric(38),
origen_movimiento varchar(3),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
plataforma varchar(1),
nom_empresa varchar(100),
no_cuenta numeric(38),
folio_ref numeric(38),
fecha_actualizacion timestamp(0),
nom_empresa_rel varchar(100),
procesado numeric(38),
aperturadoar numeric(38)
) server  options(schema 'FECXC', table 'FECXC_DEP_ESPECIALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_dep_especiales_d (
secuencia_det_dep_esp numeric(38) not null,
secuencia_dep_especiales numeric(38) not null,
code_combination numeric(38),
importe_linea decimal(20,4),
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXC_DEP_ESPECIALES_D', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_dep_especiales_e (
no_empresa numeric(38) options (key 'true') not null,
no_folio_det numeric(38) options (key 'true') not null,
fec_valor timestamp(0),
referencia varchar(10),
id_banco numeric(38),
id_banco_benef numeric(38),
id_chequera varchar(20),
concepto varchar(40),
tipo_cambio decimal(20,11),
importe decimal(20,2),
no_cheque numeric(38),
id_tipo_operacion_set numeric(38),
id_forma_pago numeric(38),
id_divisa varchar(3),
fec_valor_original timestamp(0),
id_status_mov varchar(1),
beneficiario varchar(60)
) server  options(schema 'FECXC', table 'FECXC_DEP_ESPECIALES_E', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_catalogos (
cod_sec_tipcat numeric(38) options (key 'true') not null,
cod_sec_lin numeric(38) options (key 'true') not null,
tipo_cat varchar(10) not null,
cod_valor varchar(10) not null,
desc_valor varchar(100) not null,
rep_edit_ext numeric(2)
) server  options(schema 'FECXC', table 'FECXC_DET_CATALOGOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_clasfecxc (
cod_sec_catclas numeric(38) options (key 'true') not null,
cod_sec_det numeric(38) options (key 'true') not null,
tipo_linea varchar(30),
codclasif varchar(10) not null,
cod_subclasif varchar(10) not null,
sub_descrip varchar(40) not null,
nopara_flujo numeric(38) not null,
excluir_enreportes varchar(2)
) server  options(schema 'FECXC', table 'FECXC_DET_CLASFECXC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_clasificados (
e_codigo numeric(38) options (key 'true') not null,
cod_sec_clasifica numeric(38) options (key 'true') not null,
n_linea_clas numeric(38) options (key 'true') not null,
cod_sec_catclas numeric(38),
cod_sec_det numeric(38),
importe decimal(20,2) not null,
f_ingreso timestamp(0) not null,
usu_regi varchar(30),
reference_1 varchar(10),
reference_2 varchar(10),
reference_3 varchar(30),
reference_4 varchar(150),
segmento1 numeric(38),
segmento2 numeric(38),
segmento3 numeric(38),
segmento4 numeric(38),
segmento5 numeric(38),
segmento6 numeric(38),
segmento7 numeric(38),
segmento8 numeric(38),
segmento9 numeric(38),
segmento10 numeric(38),
codcps varchar(30)
) server  options(schema 'FECXC', table 'FECXC_DET_CLASIFICADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_comm_mon_pdf (
id_formato_pdf varchar(20) options (key 'true') not null,
id_usuario varchar(30) options (key 'true') not null,
id_moneda varchar(3) options (key 'true') not null,
tipo_empresa varchar(2) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_DET_COMM_MON_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_comm_seg_pdf (
id_formato_pdf varchar(20) options (key 'true') not null,
id_usuario varchar(30) options (key 'true') not null,
id_seg_pdf numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_DET_COMM_SEG_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_impges (
e_codigo numeric(38) options (key 'true') not null,
cod_sec_importa numeric(38) options (key 'true') not null,
n_linea numeric(38) options (key 'true') not null,
cod_sec_catclas numeric(38),
cod_sec_det numeric(38),
importe decimal(20,2) not null,
f_ingreso timestamp(0) not null,
reference_1 varchar(10),
reference_2 varchar(10),
reference_3 varchar(30),
reference_4 varchar(150),
segmento1 numeric(38),
segmento2 numeric(38),
segmento3 numeric(38),
segmento4 numeric(38),
segmento5 numeric(38),
segmento6 numeric(38),
segmento7 numeric(38),
segmento8 numeric(38),
segmento9 numeric(38),
segmento10 numeric(38),
codcps varchar(30)
) server  options(schema 'FECXC', table 'FECXC_DET_IMPGES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_det_pres_diario (
sec_presup numeric(38) options (key 'true') not null,
sec_pres_dia numeric(38) options (key 'true') not null,
diario timestamp(0) not null,
segmento1 numeric(38),
segmento2 numeric(38),
segmento3 numeric(38),
segmento4 numeric(38),
segmento5 numeric(38),
segmento6 numeric(38),
segmento7 numeric(38),
segmento8 numeric(38),
segmento9 numeric(38),
segmento10 numeric(38),
importe decimal(20,2) not null
) server  options(schema 'FECXC', table 'FECXC_DET_PRES_DIARIO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_divxperiodo_tab (
id_order numeric,
des_canal varchar(100),
des_periodo varchar(200),
num_real numeric,
num_ppto numeric,
num_anio_ant numeric,
num_var_ppto numeric,
num_var_anio_ant numeric,
por_var_ppto numeric,
por_var_anio_ant numeric,
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'FECXC_DIVXPERIODO_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_editext_det_rep (
division numeric(38),
concepto numeric(38),
codmoneda varchar(3),
cobranza_dia decimal(20,4),
cobranza_mes decimal(20,4),
presup_mes decimal(20,4),
varia_mes decimal(20,4),
perc_mes decimal(20,4),
cobranza_alafecha decimal(20,4),
presup_alafecha decimal(20,4),
varia_alafecha decimal(20,4),
perc_alafecha decimal(20,2),
cobranza_anterior decimal(20,4),
varia_anterior decimal(20,4),
perc_anterior decimal(20,4),
division_desc varchar(100),
concepto_desc varchar(100)
) server  options(schema 'FECXC', table 'FECXC_EDITEXT_DET_REP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_empresas (
e_codigo numeric(38) options (key 'true') not null,
des_empresa varchar(100) not null,
tipoempresa varchar(2) not null,
permite_captura varchar(1),
tipopresup varchar(1),
cual_erp varchar(1),
e_codigo_soin varchar(5)
) server  options(schema 'FECXC', table 'FECXC_EMPRESAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_emp_x_segmento (
id_segmento numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_EMP_X_SEGMENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_catalogos (
cod_sec_tipcat numeric(38) options (key 'true') not null,
tipo_cat varchar(10) not null,
tipo_des varchar(15) not null,
es_nivel char(2)
) server  options(schema 'FECXC', table 'FECXC_ENC_CATALOGOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_clasfecxc (
cod_sec_catclas numeric(38) options (key 'true') not null,
codclasif varchar(10) not null,
sub_descrip varchar(40) not null
) server  options(schema 'FECXC', table 'FECXC_ENC_CLASFECXC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_clasificados (
e_codigo numeric(38) options (key 'true') not null,
cod_sec_clasifica numeric(38) options (key 'true') not null,
secmoneda numeric(38),
codfolio numeric(38) not null,
f_ingreso timestamp(0) not null,
f_deposito timestamp(0) not null,
f_real_dep timestamp(0) not null,
codcliente varchar(15),
tipocliente varchar(4),
refecliente varchar(10),
codbancoe numeric(20),
codbancor numeric(20),
numcheque varchar(20),
formapago varchar(10),
nchequera varchar(20),
concepto varchar(40) not null,
nom_bene varchar(255),
tipocambio double precision not null,
importe decimal(20,2) not null,
usu_gest varchar(30) not null,
clasificado_xreg numeric(38),
anoplan2 numeric(38),
codcps2 varchar(30),
tipoplan varchar(10),
codoperacion numeric(38),
customer_id numeric(38),
fec_valor timestamp(0),
fec_valor_original timestamp(0),
id_estatus_mov varchar(1)
) server  options(schema 'FECXC', table 'FECXC_ENC_CLASIFICADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_comments_pdf (
id_formato_pdf varchar(20) options (key 'true') not null,
id_usuario varchar(30) options (key 'true') not null,
comentario varchar(100) not null,
comentario_corto varchar(10) not null,
estatus_comm varchar(1) not null
) server  options(schema 'FECXC', table 'FECXC_ENC_COMMENTS_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_de_presu (
sec_presup numeric(38) options (key 'true') not null,
secmoneda numeric(38),
codanno numeric(38) not null,
fecha timestamp(0) not null,
usu_pres varchar(30) not null
) server  options(schema 'FECXC', table 'FECXC_ENC_DE_PRESU', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_enc_impges (
e_codigo numeric(38) options (key 'true') not null,
cod_sec_importa numeric(38) options (key 'true') not null,
secmoneda numeric(38),
codfolio numeric(38) not null,
f_ingreso timestamp(0) not null,
f_deposito timestamp(0) not null,
f_real_dep timestamp(0) not null,
codcliente varchar(15),
tipocliente varchar(4),
refecliente varchar(10),
codbancoe numeric(20),
codbancor numeric(20),
numcheque varchar(20),
formapago varchar(10),
nchequera varchar(20),
concepto varchar(40) not null,
nom_bene varchar(255),
tipocambio double precision not null,
importe decimal(20,2) not null,
usu_gest varchar(30),
codcps varchar(30),
tipoplan varchar(10),
anoplan numeric(38),
codoperacion numeric(38),
customer_id numeric(38),
fec_valor timestamp(0),
fec_valor_original timestamp(0),
id_estatus_mov varchar(1)
) server  options(schema 'FECXC', table 'FECXC_ENC_IMPGES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_excepciones (
e_codigo numeric(38) options (key 'true') not null,
fecha_excepcion timestamp(0) options (key 'true') not null,
dia_excepcion numeric(38),
hora_excepcion varchar(5)
) server  options(schema 'FECXC', table 'FECXC_EXCEPCIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmanual_out2_tab (
cod_sec_clasifica numeric not null,
id_orden numeric,
num_folio_real numeric,
num_ecodigo numeric,
fec_f_ingreso timestamp(0),
num_folio_manual numeric,
num_monto_folio numeric,
num_otros numeric,
num_iva numeric,
nom_cliente varchar(150),
num_imp_folio_real numeric,
des_segmento varchar(150),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'FECXC_FMANUAL_OUT2_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmanual_out3_tab (
cod_sec_clasifica numeric not null,
id_orden numeric,
num_folio_real numeric,
num_ecodigo numeric,
fec_f_ingreso timestamp(0),
num_folio_manual numeric,
num_monto_folio numeric,
num_otros numeric,
num_iva numeric,
nom_cliente varchar(150),
num_imp_folio_real numeric,
des_segmento varchar(150),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'FECXC_FMANUAL_OUT3_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmanual_out4_tab (
cod_sec_clasifica numeric not null,
id_orden numeric,
num_folio_real numeric,
num_ecodigo numeric,
fec_f_ingreso timestamp(0),
num_folio_manual numeric,
num_monto_folio numeric,
num_otros numeric,
num_iva numeric,
nom_cliente varchar(150),
num_imp_folio_real numeric,
des_segmento varchar(150),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'FECXC_FMANUAL_OUT4_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmanual_out_tab (
cod_sec_clasifica numeric not null,
id_orden numeric,
num_folio_real numeric,
num_ecodigo numeric,
fec_f_ingreso timestamp(0),
num_folio_manual numeric,
num_monto_folio numeric,
num_otros numeric,
num_iva numeric,
nom_cliente varchar(150),
num_imp_folio_real numeric,
des_segmento varchar(150),
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'FECXC_FMANUAL_OUT_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmt_monedas_pdf (
id_session varchar(100) not null,
nombre_del_formato varchar(20) not null,
codmoneda varchar(3) not null,
id_titulo_1 numeric,
id_titulo_2 numeric,
id_titulo_combinado numeric
) server  options(schema 'FECXC', table 'FECXC_FMT_MONEDAS_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmt_segmentos_pdf (
id_session varchar(100) not null,
nombre_del_formato varchar(20) not null,
id_segmento_pdf numeric(38) not null,
id_titulo_1 numeric,
id_titulo_2 numeric,
id_titulo_combinado numeric
) server  options(schema 'FECXC', table 'FECXC_FMT_SEGMENTOS_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_fmt_tipo_pdf (
id_session varchar(100) not null,
nombre_del_formato varchar(20) not null,
tipo_de_formato varchar(30) not null
) server  options(schema 'FECXC', table 'FECXC_FMT_TIPO_PDF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_inpc (
sec_inpc numeric(38) options (key 'true') not null,
ano_inpc numeric(38) not null,
mes_inpc numeric(38) not null,
inpc_estimado decimal(20,11) not null,
inpc_actual decimal(20,11) not null,
inpc_factorac decimal(20,11) not null
) server  options(schema 'FECXC', table 'FECXC_INPC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_iva (
id_iva numeric options (key 'true') not null,
porcent_iva numeric options (key 'true') not null,
desc_iva varchar(500)
) server  options(schema 'FECXC', table 'FECXC_IVA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_iva_det (
n_linea numeric options (key 'true') not null,
porcent_iva numeric not null,
desc_iva varchar(500)
) server  options(schema 'FECXC', table 'FECXC_IVA_DET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_mapeo_flujo (
cod_sec_tipcat numeric(38) options (key 'true') not null,
cod_sec_lin numeric(38) options (key 'true') not null,
cod_sec_catclas numeric(38) options (key 'true') not null,
cod_sec_det numeric(38) options (key 'true') not null,
sec_concepto_tipocat numeric(38) options (key 'true') not null,
sec_concepto_detcat numeric(38) options (key 'true') not null,
sec_flujo_tipocat numeric(38) not null,
sec_flujo_detcat numeric(38) not null,
rel_contable varchar(40)
) server  options(schema 'FECXC', table 'FECXC_MAPEO_FLUJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_mapeo_fl_opera (
cod_sec_tipcat numeric(38) options (key 'true') not null,
cod_sec_lin numeric(38) options (key 'true') not null,
id_tipo_operacion numeric(38) options (key 'true') not null,
rel_contable varchar(40)
) server  options(schema 'FECXC', table 'FECXC_MAPEO_FL_OPERA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_monedas (
secmoneda numeric(38) options (key 'true') not null,
codmoneda varchar(3),
desmoneda varchar(40),
es_moneda_loccal numeric(38)
) server  options(schema 'FECXC', table 'FECXC_MONEDAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_operaciones_it (
id_tipo_operacion numeric(38) options (key 'true') not null,
tipo_operacion varchar(30)
) server  options(schema 'FECXC', table 'FECXC_OPERACIONES_IT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_parametros (
dias numeric(38) not null,
hora varchar(5) not null
) server  options(schema 'FECXC', table 'FECXC_PARAMETROS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_parametros_canales (
anio numeric(38),
mes numeric(38),
fecha timestamp(0),
actualizado varchar(30)
) server  options(schema 'FECXC', table 'FECXC_PARAMETROS_CANALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_parametros_intermex (
anio numeric(38),
mes numeric(38),
fecha timestamp(0),
actualizado varchar(30)
) server  options(schema 'FECXC', table 'FECXC_PARAMETROS_INTERMEX', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_parametros_tvlocal (
anio numeric(38),
mes numeric(38),
fecha timestamp(0),
actualizado varchar(30)
) server  options(schema 'FECXC', table 'FECXC_PARAMETROS_TVLOCAL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_presup_alafecha (
segmento numeric(38),
codmoneda varchar(3),
presup_alafecha decimal(20,4),
presupreal_alafecha decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_PRESUP_ALAFECHA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_presup_canal_delmes (
segmento numeric(38),
codmoneda varchar(3),
mes numeric(38),
presup_mes decimal(20,2),
presupreal_mes decimal(20,2)
) server  options(schema 'FECXC', table 'FECXC_PRESUP_CANAL_DELMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_presup_delmes (
segmento numeric(38),
codmoneda varchar(3),
presup_mes decimal(20,4),
presupreal_mes decimal(20,4)
) server  options(schema 'FECXC', table 'FECXC_PRESUP_DELMES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_resta_segmentos (
cod_sec_tipcat numeric(38),
cod_sec_lin numeric(38)
) server  options(schema 'FECXC', table 'FECXC_RESTA_SEGMENTOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_roles (
id_rol numeric(38) options (key 'true') not null,
desc_rol varchar(100)
) server  options(schema 'FECXC', table 'FECXC_ROLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_roles_xempresa (
id_rol numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_ROLES_XEMPRESA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_roles_x_usuario (
id_rol numeric(38) options (key 'true') not null,
codusuario varchar(40) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_ROLES_X_USUARIO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_segmentos_flujo (
id_segmento numeric(38) options (key 'true') not null,
des_segmento varchar(80)
) server  options(schema 'FECXC', table 'FECXC_SEGMENTOS_FLUJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_segmultimon (
sec_seg numeric(38) options (key 'true') not null,
cod_sec_tipcat numeric(38),
cod_sec_lin numeric(38),
secmoneda numeric(38)
) server  options(schema 'FECXC', table 'FECXC_SEGMULTIMON', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_tipos_linea (
tipo_linea varchar(30) options (key 'true') not null,
visible_siono varchar(2)
) server  options(schema 'FECXC', table 'FECXC_TIPOS_LINEA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_tpc (
sec_tpc numeric(38) options (key 'true') not null,
secmoneda numeric(38),
fecha_tpc timestamp(0),
tipo_cambio decimal(20,11),
tipo_cambio_dls decimal(20,11)
) server  options(schema 'FECXC', table 'FECXC_TPC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxc_valores_nivxemp (
e_codigo numeric(38) options (key 'true') not null,
cod_nivel numeric(38) options (key 'true') not null,
cod_sec_tipcat numeric(38) options (key 'true') not null,
cod_sec_lin numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXC_VALORES_NIVXEMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ajustes_saldos_finales (
tipo_dato varchar(1),
e_codigo numeric(38),
importe decimal(20,4),
moneda varchar(3),
mes numeric(38)
) server  options(schema 'FECXC', table 'FECXP_AJUSTES_SALDOS_FINALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ajustes_saldos_finalesd (
tipo_dato varchar(1),
e_codigo numeric(38),
importe decimal(20,4),
moneda varchar(3),
fecha timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_AJUSTES_SALDOS_FINALESD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ape_det_tmp (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
secuencia_pagos_erp numeric(38) not null,
secuencia_cont_din_aper_det numeric(38) not null
) server  options(schema 'FECXC', table 'FECXP_APE_DET_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bitacora_errores (
id_sesion varchar(256),
mensaje varchar(256)
) server  options(schema 'FECXC', table 'FECXP_BITACORA_ERRORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bitacora_historicos (
proceso_id numeric(38),
proceso_nombre varchar(255),
created_by varchar(255),
date_created timestamp(0),
id_version numeric(38),
desc_version varchar(255),
periodo numeric(38),
mes numeric(38),
comentario varchar(255),
tipo_operacion varchar(50)
) server  options(schema 'FECXC', table 'FECXP_BITACORA_HISTORICOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bitacora_procesamiento (
id_ejecucion numeric(38) options (key 'true') not null,
usuario varchar(25),
fecha timestamp(0),
parametros varchar(100),
estatus_terminado varchar(25),
v_error varchar(255),
proceso varchar(35)
) server  options(schema 'FECXC', table 'FECXP_BITACORA_PROCESAMIENTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_cont_din_aper_det (
secuencia_pagos_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
secuencia_cont_din_aper_det numeric(38) options (key 'true') not null,
importe_set decimal(20,2),
importe_ap decimal(20,2),
fec_ejecucion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_BIT_CONT_DIN_APER_DET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_cont_din_aper_enc (
secuencia_pagos_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
folio_set varchar(150) not null,
moneda varchar(3),
fecha_aplicacion timestamp(0),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
estatus_movimiento varchar(1),
id_chequera varchar(11),
concepto varchar(100),
beneficiario varchar(60),
importe_set decimal(20,2),
estatus_cont_din_aper varchar(1),
fec_primera_ejecucion timestamp(0),
fec_ultima_ejecucion timestamp(0),
dias_vigencia_apertura numeric(38)
) server  options(schema 'FECXC', table 'FECXP_BIT_CONT_DIN_APER_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_cont_din_folios_ap (
secuencia_pagos_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
secuencia_cont_din_aper_det numeric(38) options (key 'true') not null,
ap_invoice_id numeric(15) options (key 'true') not null,
ap_invoice_amount numeric
) server  options(schema 'FECXC', table 'FECXP_BIT_CONT_DIN_FOLIOS_AP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_err_ns (
id_sesion varchar(256),
mensaje varchar(256)
) server  options(schema 'FECXC', table 'FECXP_BIT_ERR_NS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_ingr_cc (
secuencia_dep_especiales numeric(38) options (key 'true') not null,
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
id_status_mov varchar(1),
tipo_cuenta varchar(20),
estatus_din_cc varchar(1),
fec_primera_ejecucion timestamp(0),
fec_ultima_ejecucion timestamp(0),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
id_divisa varchar(3),
fec_valor timestamp(0),
importe decimal(20,2),
dias_vigencia_apertura numeric(38)
) server  options(schema 'FECXC', table 'FECXP_BIT_INGR_CC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_ingr_fact (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15) options (key 'true') not null,
customer_trx_id numeric(15) options (key 'true') not null,
customer_trx_line_id numeric(15) options (key 'true') not null,
status_recibo varchar(30),
secuencia_dep_especiales numeric(38) options (key 'true') not null,
id_divisa varchar(3),
importe decimal(20,2),
importe_recibo decimal(20,2),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_BIT_INGR_FACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_bit_ingr_misc (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
receivables_trx_id numeric(15),
status_recibo varchar(30),
secuencia_dep_especiales numeric(38) options (key 'true') not null,
id_divisa varchar(3),
importe decimal(20,2),
importe_recibo decimal(20,2),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_BIT_INGR_MISC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_det_clasificacion_fe (
version_id numeric(38) options (key 'true') not null,
cla_fe_id varchar(25) options (key 'true') not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38)
) server  options(schema 'FECXC', table 'FECXP_B_DET_CLASIFICACION_FE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_det_politicas_erp (
version_id numeric(38) options (key 'true') not null,
politica_erp_id numeric(38) options (key 'true') not null,
cla_fe_id varchar(25) options (key 'true') not null,
prioridad numeric(38),
oracle_segmento1_ini varchar(25),
oracle_segmento1_fin varchar(25),
oracle_segmento2_ini varchar(25),
oracle_segmento2_fin varchar(25),
oracle_segmento3_ini varchar(25),
oracle_segmento3_fin varchar(25),
oracle_segmento4_ini varchar(25),
oracle_segmento4_fin varchar(25),
oracle_segmento5_ini varchar(25),
oracle_segmento5_fin varchar(25),
oracle_segmento6_ini varchar(25),
oracle_segmento6_fin varchar(25),
oracle_segmento7_ini varchar(25),
oracle_segmento7_fin varchar(25),
activa_regla numeric(38) not null,
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20)
) server  options(schema 'FECXC', table 'FECXP_B_DET_POLITICAS_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_det_politicas_soin (
version_id numeric(38) options (key 'true') not null,
cla_fe_id varchar(25) options (key 'true') not null,
politica_soin_id numeric(38) options (key 'true') not null,
prioridad numeric(38),
e_codigo_ini numeric(38),
e_codigo_fin numeric(38),
ctam01_ini varchar(3),
ctam01_fin varchar(3),
ctam02_ini varchar(3),
ctam02_fin varchar(3),
ctam03_ini varchar(3),
ctam03_fin varchar(3),
tipo_ini varchar(1),
tipo_fin varchar(1),
division_ini numeric(38),
division_fin numeric(38),
rubro_ini numeric(38),
rubro_fin numeric(38),
activa_regla numeric(38) not null,
ctacr1_ini varchar(3),
ctacr1_fin varchar(3),
ctacr2_ini varchar(4),
ctacr2_fin varchar(4),
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20)
) server  options(schema 'FECXC', table 'FECXP_B_DET_POLITICAS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_ejecucion_proceso (
id_proceso numeric(38) options (key 'true') not null,
proceso_nombre varchar(100) options (key 'true') not null,
catalogo_nombre varchar(100) options (key 'true') not null,
version_id numeric(38) options (key 'true') not null,
accion varchar(25) options (key 'true') not null,
usuario_id varchar(30) not null,
fecha_creacion timestamp(0) not null
) server  options(schema 'FECXC', table 'FECXP_B_EJECUCION_PROCESO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_enc_clasificacion_fe (
version_id numeric(38) options (key 'true') not null,
usuario_id varchar(30),
fecha_creacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_B_ENC_CLASIFICACION_FE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_enc_politicas_erp (
version_id numeric(38) options (key 'true') not null,
usuario_id varchar(30),
fecha_creacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_B_ENC_POLITICAS_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_b_enc_politicas_soin (
version_id numeric(38) options (key 'true') not null,
usuario_id varchar(30),
fecha_creacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_B_ENC_POLITICAS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cancelados_sincambios (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38),
secuencia_aplicada numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CANCELADOS_SINCAMBIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cancelados_sin_aplicado (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CANCELADOS_SIN_APLICADO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cat_cuentas_soin (
e_codigo numeric(38) options (key 'true') not null,
ctam01 varchar(3) options (key 'true') not null,
ctam02 varchar(3) options (key 'true') not null,
ctam03 varchar(3) options (key 'true') not null,
cg13di numeric(38),
cg13gr numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) server  options(schema 'FECXC', table 'FECXP_CAT_CUENTAS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cat_operaciones (
cve_operacion numeric(38),
estatus_movto varchar(1),
activo numeric
) server  options(schema 'FECXC', table 'FECXP_CAT_OPERACIONES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cat_subcodigo (
secuencia_cod_sub numeric(38),
no_empresa numeric(38) options (key 'true') not null,
id_codigo varchar(2) options (key 'true') not null,
id_subcodigo varchar(3) options (key 'true') not null,
desc_subcodigo varchar(40),
cla_fe_id varchar(25),
estatus varchar(25),
fecha_modificacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_CAT_SUBCODIGO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_clasificacion_fe (
cla_fe_id varchar(25) options (key 'true') not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38),
version_id numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CLASIFICACION_FE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cla_fe_nochequera (
cla_fe_id varchar(25) options (key 'true') not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38),
version_id numeric(38),
tipo_operacion numeric(38) options (key 'true') not null,
id_tipo_movto varchar(1) options (key 'true') not null,
tipo_clave varchar(2) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_CLA_FE_NOCHEQUERA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_cod_sub_bitacora (
secuencia_cod_sub_bit numeric(38),
ins_no_empresa numeric(38),
ins_id_codigo varchar(2),
ins_id_subcodigo varchar(3),
ins_desc_subcodigo varchar(40),
del_no_empresa numeric(38),
del_id_codigo varchar(2),
del_id_subcodigo varchar(3),
del_desc_subcodigo varchar(40),
accion varchar(40),
usuario varchar(40),
fecha_sincronizacion timestamp(0),
fecha_modificacion timestamp(0),
sincronizado_fe varchar(2),
comentario_sincronizado_fe varchar(255)
) server  options(schema 'FECXC', table 'FECXP_COD_SUB_BITACORA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_crear_aperturados (
e_codigo numeric(38) options (key 'true') not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38) options (key 'true') not null,
secuencia_aplicada numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CREAR_APERTURADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_crear_fact (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_dep_especiales numeric(38),
secuencia_aplicada numeric(38),
estatus_din_cc_apli varchar(1)
) server  options(schema 'FECXC', table 'FECXP_CREAR_FACT', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_crear_miscelaneos (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_dep_especiales numeric(38),
secuencia_aplicada numeric(38),
estatus_din_cc_apli varchar(1)
) server  options(schema 'FECXC', table 'FECXP_CREAR_MISCELANEOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_ppto_erp (
cla_fe_id varchar(25),
e_codigo numeric(38),
code_combination_id numeric(38),
oracle_segmento1 varchar(25) options (key 'true') not null,
oracle_segmento2 varchar(25) options (key 'true') not null,
oracle_segmento3 varchar(25) options (key 'true') not null,
oracle_segmento4 varchar(25) options (key 'true') not null,
oracle_segmento5 varchar(25) options (key 'true') not null,
oracle_segmento6 varchar(25) options (key 'true') not null,
oracle_segmento7 varchar(25) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_PPTO_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_ppto_soin (
cla_fe_id varchar(25),
e_codigo numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4)
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_PPTO_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_real_erp (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
id_banco numeric(38),
id_chequera varchar(20)
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_REAL_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_real_erp_h (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
id_banco numeric(38),
id_chequera varchar(20),
periodo numeric(38),
mes numeric(38),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_REAL_ERP_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_real_soin (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
id_banco numeric(38),
id_chequera varchar(20)
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_REAL_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_clasif_real_soin_h (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
id_banco numeric(38),
id_chequera varchar(20),
periodo numeric(38),
mes numeric(38),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_CTAS_CLASIF_REAL_SOIN_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_erp_clasificadas (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
moneda varchar(3),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_CTAS_ERP_CLASIFICADAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_soin_caratula (
cla_fe_id varchar(25),
e_codigo numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
moneda varchar(3),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_CTAS_SOIN_CARATULA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ctas_soin_clasificadas (
cla_fe_id varchar(25),
e_codigo numeric(38),
tipo_operacion numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
moneda varchar(3),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_CTAS_SOIN_CLASIFICADAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_del_clasif_real_soin (
e_codigo numeric(38),
tipo_operacion numeric(38),
id_banco numeric(38),
id_chequera varchar(20),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
ctacr1 varchar(3),
ctacr2 varchar(4)
) server  options(schema 'FECXC', table 'FECXP_DEL_CLASIF_REAL_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_del_ctas_real_erp (
e_codigo numeric(38),
tipo_operacion numeric(38),
id_banco numeric(38),
id_chequera varchar(20),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_DEL_CTAS_REAL_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_del_ppto_com_cta_erp (
e_codigo numeric(38),
code_combination_id numeric not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_DEL_PPTO_COM_CTA_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_del_soin_caratula (
e_codigo numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
ctacr1 varchar(3),
ctacr2 varchar(4)
) server  options(schema 'FECXC', table 'FECXP_DEL_SOIN_CARATULA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_cont_version_fe (
proceso varchar(100),
version_fe numeric(38),
fecha_actualizacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_DET_CONT_VERSION_FE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_pagos_erp (
secuencia_det_pagos_erp numeric(38) options (key 'true') not null,
secuencia_pagos_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
numero_de_partida_erp numeric(38) options (key 'true') not null,
code_combination numeric(38),
importe_linea decimal(20,4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_DET_PAGOS_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_pagos_erp_tmp (
no_empresa numeric(38),
no_folio_det numeric(38),
icia_rneg varchar(25)
) server  options(schema 'FECXC', table 'FECXP_DET_PAGOS_ERP_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_pagos_procesados (
e_codigo numeric(38) options (key 'true') not null,
secuencia_pagos_erp numeric(38) options (key 'true') not null,
secuencia_det_pagos_erp numeric(38) options (key 'true') not null,
numero_de_partida_erp numeric(38) options (key 'true') not null,
sec_det_pag_proc numeric(38) options (key 'true') not null,
code_combination numeric(38),
importe_linea decimal(20,4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_DET_PAGOS_PROCESADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_pagos_soin (
secuencia_det_pagos_soin numeric(38) options (key 'true') not null,
secuencia_pagos_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
numero_de_partida numeric(38) options (key 'true') not null,
importe_linea decimal(20,4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3)
) server  options(schema 'FECXC', table 'FECXP_DET_PAGOS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_reales_coinversion (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
secuencia_id numeric(38),
cla_fe_id varchar(25),
cla_fe_des varchar(50),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
id_tipo_movto varchar(1),
tipo_erp varchar(1)
) server  options(schema 'FECXC', table 'FECXP_DET_REALES_COINVERSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_reales_coinversion_h (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
secuencia_id numeric(38),
cla_fe_id varchar(25),
cla_fe_des varchar(50),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
id_tipo_movto varchar(1),
tipo_erp varchar(1),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_DET_REALES_COINVERSION_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_reales_inversion (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
secuencia_id numeric(38),
cla_fe_id varchar(25),
cla_fe_des varchar(50),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
id_tipo_movto varchar(1),
tipo_erp varchar(1)
) server  options(schema 'FECXC', table 'FECXP_DET_REALES_INVERSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_det_reales_inversion_h (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
secuencia_id numeric(38),
cla_fe_id varchar(25),
cla_fe_des varchar(50),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
id_tipo_movto varchar(1),
tipo_erp varchar(1),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_DET_REALES_INVERSION_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_emp_no_set (
id_emp numeric options (key 'true') not null,
desc_emp varchar(500),
tipo_empresa varchar(10),
id_emp_old numeric,
comentarios2 varchar(400),
comentarios varchar(400),
cambio_set_no_set varchar(1)
) server  options(schema 'FECXC', table 'FECXP_EMP_NO_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_emp_x_segmento_no_set (
id_segmento numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
tipo_empresa varchar(10)
) server  options(schema 'FECXC', table 'FECXP_EMP_X_SEGMENTO_NO_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_enc_pagos_erp (
secuencia_pagos_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
secmoneda numeric(38),
folio_set varchar(150) not null,
periodo numeric(38),
cve_operacion numeric(38),
estatus_movimiento varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe decimal(20,2),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
estatus_de_ingreso varchar(1),
procesado numeric(38),
tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
concepto varchar(100),
beneficiario varchar(60),
fecha_actualizacion timestamp(0),
nom_empresa varchar(100),
no_cuenta numeric(38),
folio_ref numeric(38),
nom_empresa_rel varchar(100),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_ENC_PAGOS_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_enc_pagos_erp_tmp (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null
) server  options(schema 'FECXC', table 'FECXP_ENC_PAGOS_ERP_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_enc_pagos_soin (
secuencia_pagos_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
secmoneda numeric(38),
folio_set varchar(150) not null,
periodo numeric(38),
cve_operacion numeric(38),
estatus_movimiento varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe decimal(20,2),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
concepto varchar(100),
beneficiario varchar(60),
fecha_actualizacion timestamp(0),
nom_empresa varchar(100),
no_cuenta numeric(38),
folio_ref numeric(38),
nom_empresa_rel varchar(100),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_ENC_PAGOS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_enc_replicas_proc_tmp (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
fecha_aplicacion timestamp(0),
importe decimal(20,2),
estatus_movimiento varchar(1),
estatus_de_ingreso varchar(1),
procesado numeric(38)
) server  options(schema 'FECXC', table 'FECXP_ENC_REPLICAS_PROC_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_extraccion_egr_tab (
no_empresa numeric(38),
no_folio_det numeric(38),
c_periodo numeric(38),
cperiodoapli numeric(38),
id_cve_operacion numeric(38),
id_estatus_mov varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe numeric,
id_forma_pago numeric(38),
fec_flujo timestamp(0),
fec_modif timestamp(0),
id_divisa varchar(3),
tipo_cambio numeric,
origen_mov varchar(3),
id_tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
plataforma varchar(1),
actualizado varchar(1),
nom_empresa varchar(80),
nom_empresa_rel varchar(80),
no_cuenta numeric(38),
folio_ref numeric(38),
id_tipo_movto varchar(1),
no_lote_ent numeric(38),
no_partida numeric(38),
cia varchar(4),
neg varchar(2),
cta varchar(3),
scta char(6),
cc varchar(8),
icia char(4),
top varchar(1),
importe_partida numeric,
codecombination numeric,
concepto varchar(100),
beneficiario varchar(60),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_EXTRACCION_EGR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_extraccion_ingrsbc_tab (
no_empresa numeric(38),
no_folio_det numeric(38),
c_periodo numeric(38),
cperiodoapli numeric(38),
id_cve_operacion numeric(38),
id_estatus_mov varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe numeric,
id_forma_pago numeric(38),
fec_flujo timestamp(0),
fec_modif timestamp(0),
id_divisa varchar(3),
tipo_cambio numeric,
origen_mov varchar(3),
id_tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
plataforma varchar(1),
actualizado varchar(1),
nom_empresa varchar(80),
nom_empresa_rel varchar(80),
no_cuenta numeric(38),
folio_ref numeric(38),
id_tipo_movto varchar(1),
concepto varchar(100),
beneficiario varchar(60),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_EXTRACCION_INGRSBC_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_extraccion_ingr_tab (
no_empresa numeric(38),
no_folio_det numeric(38),
c_periodo numeric(38),
cperiodoapli numeric(38),
id_cve_operacion numeric(38),
id_estatus_mov varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe numeric,
id_forma_pago numeric(38),
fec_flujo timestamp(0),
fec_modif timestamp(0),
id_divisa varchar(3),
tipo_cambio numeric,
origen_mov varchar(3),
id_tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
plataforma varchar(1),
actualizado varchar(1),
nom_empresa varchar(80),
nom_empresa_rel varchar(80),
no_cuenta numeric(38),
folio_ref numeric(38),
id_tipo_movto varchar(1),
concepto varchar(100),
beneficiario varchar(60),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_EXTRACCION_INGR_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_fact_folios_var (
no_folio_det numeric(38) not null,
cuantos numeric(38)
) server  options(schema 'FECXC', table 'FECXP_FACT_FOLIOS_VAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_fact_grp1 (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
secuencia_dep_especiales numeric(38) options (key 'true') not null,
id_divisa varchar(3),
importe decimal(20,2),
code_combination numeric(38) options (key 'true') not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
es_repetido numeric(38)
) server  options(schema 'FECXC', table 'FECXP_FACT_GRP1', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_fact_ini (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
customer_trx_id numeric(15),
customer_trx_line_id numeric(15),
status_recibo varchar(30),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20,2),
importe_recibo decimal(20,2),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_FACT_INI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_fact_var (
no_folio_det numeric(38) not null,
receipt_number varchar(30),
cash_receipt_id numeric(15),
customer_trx_id numeric(15),
customer_trx_line_id numeric(15),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_FACT_VAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_folios_prov_checks (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
ap_check_id numeric(15)
) server  options(schema 'FECXC', table 'FECXP_FOLIOS_PROV_CHECKS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_folios_prov_det (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
fecxp_importe decimal(20,2),
ap_invoice_id numeric(15),
ap_invoice_amount numeric,
ap_distribution_line_number numeric(15),
ap_distribution_amount numeric,
ap_dist_code_combination_id numeric(15),
ap_cuenta varchar(150),
segmento1 varchar(25),
segmento2 varchar(25),
segmento3 varchar(25),
segmento4 varchar(25),
segmento5 varchar(25),
segmento6 varchar(25),
segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_FOLIOS_PROV_DET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_folios_prov_enc (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
fecxp_importe decimal(20,2),
ap_invoice_id numeric(15),
ap_invoice_amount numeric
) server  options(schema 'FECXC', table 'FECXP_FOLIOS_PROV_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_folios_prov_invoices (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
ap_check_id numeric(15),
ap_invoice_id numeric(15)
) server  options(schema 'FECXC', table 'FECXP_FOLIOS_PROV_INVOICES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_folios_reaperturables (
folio_set varchar(150) not null,
e_codigo numeric(38) not null
) server  options(schema 'FECXC', table 'FECXP_FOLIOS_REAPERTURABLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_fol_ap_tmp (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
secuencia_pagos_erp numeric(38) not null,
secuencia_cont_din_aper_det numeric(38) not null,
ap_invoice_id numeric(15),
ap_invoice_amount numeric
) server  options(schema 'FECXC', table 'FECXP_FOL_AP_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_forecast_h (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20,4),
estatus varchar(25),
tipo_caratula varchar(2),
id_version numeric(38) not null,
tipo_ppto_real varchar(1),
id_version_forecast numeric(38)
) server  options(schema 'FECXC', table 'FECXP_FORECAST_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_forecast_ns (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20,4),
estatus varchar(25),
tipo_caratula varchar(2),
id_version varchar(100) not null,
tipo_ppto_real varchar(1),
tipo_empresa varchar(10)
) server  options(schema 'FECXC', table 'FECXP_FORECAST_NS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_gastos_set_erp (
secuencia_pagos_erp numeric(38) options (key 'true') not null,
secuencia_gastos_set_erp numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
check_id numeric(15) not null,
invoice_id numeric(15) not null,
invoice_distrib_line_number numeric(15) not null,
invoice_distrib_line_amount numeric not null,
po_physical_header_id varchar(20),
po_physical_line_id numeric,
po_header_id numeric,
po_line_id numeric,
po_distribution_id_number numeric,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
atributo_11 varchar(150) not null
) server  options(schema 'FECXC', table 'FECXP_GASTOS_SET_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_gl_je_sources (
je_source_name varchar(25) options (key 'true') not null,
user_je_source_name varchar(25),
description varchar(240),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
context varchar(150),
flag_origen_mc numeric(38)
) server  options(schema 'FECXC', table 'FECXP_GL_JE_SOURCES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos (
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
e_empresa_des varchar(100),
cla_fe_des varchar(50),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(4),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(4),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos_hist (
tipo_empresa_imp varchar(2) not null,
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(4),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(4),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
e_empresa_des varchar(100),
cla_fe_des varchar(50),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS_HIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos_hist_h (
tipo_empresa_imp varchar(2) not null,
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
id_version numeric(38),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(4),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(4),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
e_empresa_des varchar(100),
cla_fe_des varchar(50),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS_HIST_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos_hist_r (
tipo_empresa_imp varchar(2) not null,
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
id_version numeric(38),
e_empresa_des varchar(100),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(4),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(4),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
cla_fe_des varchar(50),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS_HIST_R', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos_ns (
tipo_importacion varchar(2),
id_segmento numeric,
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
utilizar_reporte varchar(1)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS_NS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_importacion_datos_params (
tipo_empresa_imp varchar(2) not null,
tipoempresa varchar(2),
tipo_importacion varchar(2),
permite_importacion varchar(1),
estatus_origen varchar(25)
) server  options(schema 'FECXC', table 'FECXP_IMPORTACION_DATOS_PARAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_imp_datos_bitacora (
tipo_empresa_imp varchar(2) not null,
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
accion varchar(5),
fecha_accion timestamp(0),
e_empresa_des varchar(100),
cla_fe_des varchar(50),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(1),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(3),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
code_combination numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMP_DATOS_BITACORA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_imp_datos_bit_ns (
tipo_empresa_imp varchar(2),
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
accion varchar(5),
fecha_accion timestamp(0),
utilizar_reporte varchar(1)
) server  options(schema 'FECXC', table 'FECXP_IMP_DATOS_BIT_NS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_imp_dat_hist (
tipo_empresa_imp varchar(2),
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20,4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25),
utilizar_reporte varchar(1),
procesado numeric(38)
) server  options(schema 'FECXC', table 'FECXP_IMP_DAT_HIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ingresos_clasif (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
concepto varchar(100),
beneficiario varchar(60),
id_status_mov varchar(1),
id_chequera varchar(20),
id_banco numeric(38),
id_forma_pago numeric(38),
referencia varchar(30),
importe_linea decimal(20,4),
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
cual_erp varchar(1),
tipo_clasificacion varchar(20),
no_cliente varchar(15),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_INGRESOS_CLASIF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ingresos_clasificados (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
importe_linea decimal(20,4)
) server  options(schema 'FECXC', table 'FECXP_INGRESOS_CLASIFICADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ingresos_clasif_h (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe decimal(20,2),
concepto varchar(100),
beneficiario varchar(60),
id_status_mov varchar(1),
id_chequera varchar(20),
id_banco numeric(38),
id_forma_pago numeric(38),
referencia varchar(30),
importe_linea decimal(20,4),
ora_soin_segmento1 varchar(25),
ora_soin_segmento2 varchar(25),
ora_soin_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
cual_erp varchar(1),
tipo_clasificacion varchar(20),
no_cliente varchar(15),
descripcion varchar(30),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_INGRESOS_CLASIF_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_iva_interempresas_tbl (
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50) not null,
cia varchar(25) not null,
neg varchar(25) not null,
cta varchar(25) not null,
scta varchar(25) not null,
cc varchar(25) not null,
icia varchar(25) not null,
top varchar(25) not null,
last_update_date timestamp(0) not null,
last_updated_by varchar(25) not null
) server  options(schema 'FECXC', table 'FECXP_IVA_INTEREMPRESAS_TBL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_iva_inter_activity_tbl (
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50) not null,
cia varchar(25) not null,
neg varchar(25) not null,
cta varchar(25) not null,
scta varchar(25) not null,
cc varchar(25) not null,
icia varchar(25) not null,
top varchar(25) not null,
last_update_date timestamp(0) not null,
last_updated_by varchar(25) not null
) server  options(schema 'FECXC', table 'FECXP_IVA_INTER_ACTIVITY_TBL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_layout_noset_log (
created_by numeric(15) not null,
creation_date timestamp(0) not null,
id_version numeric(38),
nombre_version varchar(400),
comentarios varchar(1000)
) server  options(schema 'FECXC', table 'FECXP_LAYOUT_NOSET_LOG', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_misc_folios_repe (
no_folio_det numeric(38) not null,
cuantos numeric(38)
) server  options(schema 'FECXC', table 'FECXP_MISC_FOLIOS_REPE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_misc_ini (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
receivables_trx_id numeric(15),
status_recibo varchar(30),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20,2),
importe_recibo decimal(20,2),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
es_repetido numeric(38)
) server  options(schema 'FECXC', table 'FECXP_MISC_INI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_misc_repe (
no_folio_det numeric(38) not null,
receipt_number varchar(30),
cash_receipt_id numeric(15)
) server  options(schema 'FECXC', table 'FECXP_MISC_REPE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_monedas (
mon_sybase varchar(3) not null,
mon_oracle varchar(3) not null,
des_sybase varchar(40) not null,
des_oracle varchar(80) not null,
mon_set varchar(3) options (key 'true') not null,
tipo_cambio decimal(20,11) not null,
fec_ingreso timestamp(0) not null,
mes numeric(38) options (key 'true') not null,
periodo numeric(38) options (key 'true') not null,
des_set varchar(20),
atributo1 varchar(255),
fecha_actualizacion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_MONEDAS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_monedas_no_set (
mon_sybase varchar(3),
mon_oracle varchar(3),
des_sybase varchar(40),
des_oracle varchar(80),
mon_set varchar(3),
tipo_cambio decimal(20,11) not null,
fec_ingreso timestamp(0) not null,
mes numeric(38) not null,
periodo numeric(38),
des_set varchar(20),
atributo1 varchar(255),
fecha_actualizacion timestamp(0),
mon_no_set varchar(5),
des_no_set varchar(255),
tipo_empresa varchar(10)
) server  options(schema 'FECXC', table 'FECXP_MONEDAS_NO_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_monedas_oracle (
mon_oracle varchar(3) options (key 'true') not null,
des_oracle varchar(80) not null,
fec_ingreso timestamp(0) not null
) server  options(schema 'FECXC', table 'FECXP_MONEDAS_ORACLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_monedas_set (
mon_set varchar(3) options (key 'true') not null,
des_set varchar(20) not null,
mon_oracle varchar(3),
mon_sybase varchar(3),
fec_ingreso timestamp(0) not null
) server  options(schema 'FECXC', table 'FECXP_MONEDAS_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_movs_coinversion (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
secuencia_id numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
importe decimal(20,4),
importe_linea decimal(20,4),
id_tipo_movto varchar(1),
des_empresa varchar(100),
id_status_mov varchar(1),
periodo numeric(38),
mes numeric(38),
tipo_cambio decimal(20,11),
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250)
) server  options(schema 'FECXC', table 'FECXP_MOVS_COINVERSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_movs_inversion (
cla_fe_id varchar(25),
e_codigo numeric(38),
folio_set numeric(38),
secuencia_id numeric(38),
tipo_operacion numeric(38),
fecha timestamp(0),
moneda varchar(3),
importe decimal(20,4),
importe_linea decimal(20,4),
id_tipo_movto varchar(1),
des_empresa varchar(100),
id_status_mov varchar(1),
periodo numeric(38),
mes numeric(38),
tipo_cambio decimal(20,11),
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250)
) server  options(schema 'FECXC', table 'FECXP_MOVS_INVERSION', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_mov_comple_opera_erp (
secuencia_mc_erp numeric(38) options (key 'true') not null,
origen_poliza varchar(25) not null,
je_header_id varchar(15) not null,
moneda varchar(3),
fecha_efectiva timestamp(0),
importe_linea decimal(20,4),
monto_deb_mon_orig numeric,
monto_cre_mon_orig numeric,
monto_deb_mon_conv numeric,
monto_cre_mon_conv numeric,
libro_id numeric(15),
code_combination_id numeric,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_MOV_COMPLE_OPERA_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_mov_comple_soin (
secuencia_mov_comple_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
cg5con numeric(38) not null,
cgbbat numeric(38) not null,
cgbfec timestamp(0) not null,
cg17va numeric(38) not null,
ctam01 varchar(3) not null,
ctam02 varchar(3) not null,
ctam03 varchar(3) not null,
cgtmon decimal(20,4) not null,
cgtmoe decimal(20,4) not null,
moneda varchar(3) not null,
cgttip varchar(1) not null,
tipo_cambio decimal(20,11) not null,
mov_estatus varchar(20) not null
) server  options(schema 'FECXC', table 'FECXP_MOV_COMPLE_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_org_inv_flujo (
secuencia_org_fe numeric(38) options (key 'true') not null,
organization_id numeric(38) options (key 'true') not null,
cla_fe_id varchar(25) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_ORG_INV_FLUJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_cuentas_apertura (
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
comentario varchar(255)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_CUENTAS_APERTURA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_erp_clasif (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
sec_det_pag_proc numeric(38),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_ERP_CLASIF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_erp_clasif_h (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
des_empresa varchar(100),
no_cuenta numeric(38),
sec_det_pag_proc numeric(38),
referencia varchar(30),
descripcion varchar(30),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_ERP_CLASIF_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_erp_oi (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
importe decimal(20,2),
numero_de_partida_erp numeric(38) not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
cla_fe_id_pol varchar(25),
cla_fe_des_pol varchar(60),
cla_fe_id_oi varchar(25),
cla_fe_des_oi varchar(60),
organization_id numeric(38),
name varchar(240),
no_cliente varchar(15)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_ERP_OI', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_soin_clasif (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
importe decimal(20,2),
numero_de_partida_soin numeric(38) not null,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
secuencia_det_pagos_soin numeric(38),
referencia varchar(30),
descripcion varchar(30)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_SOIN_CLASIF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pagos_soin_clasif_h (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
origen_movimiento varchar(3),
importe decimal(20,2),
numero_de_partida_soin numeric(38) not null,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
importe_linea decimal(20,4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
des_empresa varchar(100),
no_cuenta numeric(38),
secuencia_det_pagos_soin numeric(38),
referencia varchar(30),
descripcion varchar(30),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PAGOS_SOIN_CLASIF_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_param_ext_mc (
diaeje numeric(38) not null,
meseje numeric(38) not null,
diaini numeric(38) not null,
mesini numeric(38) not null,
diafin numeric(38) not null,
mesfin numeric(38) not null
) server  options(schema 'FECXC', table 'FECXP_PARAM_EXT_MC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_pend_recibos (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
status_recibo varchar(30),
tipo_recibo varchar(20),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20,2),
importe_recibo decimal(20,2)
) server  options(schema 'FECXC', table 'FECXP_PEND_RECIBOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_politicas_erp (
cla_fe_id varchar(25) options (key 'true') not null,
politica_erp_id numeric(38) options (key 'true') not null,
prioridad numeric(38),
oracle_segmento1_ini varchar(25),
oracle_segmento1_fin varchar(25),
oracle_segmento2_ini varchar(25),
oracle_segmento2_fin varchar(25),
oracle_segmento3_ini varchar(25),
oracle_segmento3_fin varchar(25),
oracle_segmento4_ini varchar(25),
oracle_segmento4_fin varchar(25),
oracle_segmento5_ini varchar(25),
oracle_segmento5_fin varchar(25),
oracle_segmento6_ini varchar(25),
oracle_segmento6_fin varchar(25),
oracle_segmento7_ini varchar(25),
oracle_segmento7_fin varchar(25),
activa_regla numeric(38) not null,
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20),
version_id numeric(38)
) server  options(schema 'FECXC', table 'FECXP_POLITICAS_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_politicas_soin (
cla_fe_id varchar(25) options (key 'true') not null,
politica_soin_id numeric(38) options (key 'true') not null,
prioridad numeric(38),
e_codigo_ini numeric(38),
e_codigo_fin numeric(38),
ctam01_ini varchar(3),
ctam01_fin varchar(3),
ctam02_ini varchar(3),
ctam02_fin varchar(3),
ctam03_ini varchar(3),
ctam03_fin varchar(3),
tipo_ini varchar(1),
tipo_fin varchar(1),
division_ini numeric(38),
division_fin numeric(38),
rubro_ini numeric(38),
rubro_fin numeric(38),
activa_regla numeric(38) not null,
ctacr1_ini varchar(3),
ctacr1_fin varchar(3),
ctacr2_ini varchar(4),
ctacr2_fin varchar(4),
tipo_operacion_ini numeric(38),
tipo_operacion_fin numeric(38),
id_tipo_movto varchar(1),
id_banco_ini numeric(38),
id_banco_fin numeric(38),
id_chequera_ini varchar(20),
id_chequera_fin varchar(20),
version_id numeric(38)
) server  options(schema 'FECXC', table 'FECXP_POLITICAS_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_posteo (
orden numeric(38),
xml_doc varchar(28),
xml_string varchar(255),
sesion varchar(100)
) server  options(schema 'FECXC', table 'FECXP_POSTEO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_bitacora_procesos (
sec_ext_bitacora numeric(38),
proceso_id numeric(38),
fecha_ext_ult_ejecucion timestamp(0),
estatus_ext_ult_ejecucion varchar(255),
periodo_ppto_ult_ejecucion numeric(38),
version_ppto_ult_ejecucion numeric(38),
estatus_ppto_ult_ejecucion varchar(255),
version_ppto_generado numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_BITACORA_PROCESOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_caratula (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_pc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(25) not null,
importe_linea decimal(20,4),
estatus varchar(25)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CARATULA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_caratula_h (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_pc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(25) not null,
importe_linea decimal(20,4),
estatus varchar(25),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CARATULA_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_caratula_impns (
e_codigo numeric not null,
des_empresa varchar(100) not null,
id_sesion_pc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(25) not null,
importe_linea decimal(20,4),
estatus varchar(25),
id_version varchar(100),
utilizar_reporte varchar(1),
id_linea varchar(240),
procesado numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CARATULA_IMPNS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_erp (
e_codigo numeric(38) options (key 'true') not null,
secuencia_ptto_conversion numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mes numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20,11) not null,
code_combination numeric(38) not null,
importe_linea decimal(20,4) not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
periodo_extraccion numeric(15) not null,
mes_extraccion numeric(38) not null,
presupuesto_estatus varchar(20) not null,
version_fe numeric(38) options (key 'true') not null,
mon_func varchar(3),
mon_orig varchar(3)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_erp_enc (
version_fe numeric(38),
comentario varchar(255),
usuario_id varchar(15),
fecha_extraccion timestamp(0),
version_reglas numeric(38),
fecha_version_reglas timestamp(0),
periodo_origen numeric(38),
version_origen numeric(38),
estatus_origen varchar(255),
version_fe_origen numeric(38),
mes_extraccion numeric(38),
periodo_extraccion numeric(38),
estatus_fe varchar(25)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_ERP_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_erp_h (
e_codigo numeric(38) not null,
secuencia_ptto_conversion numeric(38) not null,
periodo numeric(38) not null,
mes numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20,11) not null,
code_combination numeric(38) not null,
importe_linea decimal(20,4) not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
periodo_extraccion numeric(15) not null,
mes_extraccion numeric(38) not null,
presupuesto_estatus varchar(20) not null,
version_fe numeric(38),
mon_func varchar(3),
mon_orig varchar(3),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_ERP_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_soin (
e_codigo numeric(38) options (key 'true') not null,
secuencia_ppto_operativo_soin numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20,4) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20,11) not null,
periodo_extraccion numeric(15),
mes_extraccion numeric(38),
presupuesto_estatus varchar(20),
version_fe numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_soin_enc (
version_fe numeric(38),
comentario varchar(255),
usuario_id varchar(15),
fecha_extraccion timestamp(0),
version_reglas numeric(38),
fecha_version_reglas timestamp(0),
periodo_origen numeric(38),
version_origen numeric(38),
estatus_origen varchar(255),
version_fe_origen numeric(38),
mes_extraccion numeric(38),
periodo_extraccion numeric(38),
estatus_fe varchar(25)
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_SOIN_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_conversion_soin_h (
e_codigo numeric(38) options (key 'true') not null,
secuencia_ppto_operativo_soin numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20,4) not null,
moneda varchar(3) not null,
tipo_cambio decimal(20,11) not null,
periodo_extraccion numeric(15),
mes_extraccion numeric(38),
presupuesto_estatus varchar(20),
version_fe numeric(38) options (key 'true') not null,
id_version numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_PPTO_CONVERSION_SOIN_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_extraccion_params (
proceso_id numeric(38),
proceso_nombre varchar(255),
fecha_ext_sig_ejecucion timestamp(0),
version_fe_sig_ejecucion numeric(38),
periodo_ppto_sig_ejecucion numeric(38),
version_ppto_sig_ejecucion numeric(38),
estatus_ppto_sig_ejecucion varchar(255),
usuario_ppto_sig_ejecucion varchar(25),
fecha_ext_ult_ejecucion timestamp(0),
estatus_ext_ult_ejecucion varchar(255),
version_fe_ult_ejecucion numeric(38),
periodo_ppto_ult_ejecucion numeric(38),
version_ppto_ult_ejecucion numeric(38),
estatus_ppto_ult_ejecucion varchar(255),
usuario_ppto_ult_ejecucion varchar(25),
atributo1 varchar(255),
estatus_proceso varchar(255),
fec_ini timestamp(0),
fec_fin timestamp(0),
alertar numeric(38),
atributo2 varchar(255)
) server  options(schema 'FECXC', table 'FECXP_PPTO_EXTRACCION_PARAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_operativo_soin (
secuencia_ppto_operativo_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20,4) not null,
moneda varchar(3) not null,
periodo_extraccion numeric(15),
mes_extraccion numeric(38),
tipo_cambio decimal(20,11) not null,
version_fe numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERATIVO_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_operativo_soin_enc (
version_fe numeric(38),
comentario varchar(255),
usuario_id varchar(15),
fecha_extraccion timestamp(0),
version_reglas numeric(38),
fecha_version_reglas timestamp(0),
periodo_origen numeric(38),
version_origen numeric(38),
estatus_origen varchar(255),
version_fe_origen numeric(38),
mes_extraccion numeric(38),
periodo_extraccion numeric(38),
estatus_fe varchar(25)
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERATIVO_SOIN_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_operativo_soin_h (
secuencia_ppto_operativo_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
arsmap varchar(3) not null,
aejmap varchar(3) not null,
cncmap varchar(3) not null,
ctacr1 varchar(3),
ctacr2 varchar(4),
importe_linea decimal(20,4) not null,
moneda varchar(3) not null,
periodo_extraccion numeric(15),
mes_extraccion numeric(38),
tipo_cambio decimal(20,11) not null,
version_fe numeric(38) options (key 'true') not null,
id_version numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERATIVO_SOIN_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_opera_erp (
e_codigo numeric(38) options (key 'true') not null,
secuencia_ptto_oracle numeric(38) options (key 'true') not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
ppto_01 numeric not null,
pss_01 numeric not null,
usd_01 numeric not null,
eur_01 numeric not null,
ppto_02 numeric not null,
pss_02 numeric not null,
usd_02 numeric not null,
eur_02 numeric not null,
ppto_03 numeric not null,
pss_03 numeric not null,
usd_03 numeric not null,
eur_03 numeric not null,
ppto_04 numeric not null,
pss_04 numeric not null,
usd_04 numeric not null,
eur_04 numeric not null,
ppto_05 numeric not null,
pss_05 numeric not null,
usd_05 numeric not null,
eur_05 numeric not null,
ppto_06 numeric not null,
pss_06 numeric not null,
usd_06 numeric not null,
eur_06 numeric not null,
ppto_07 numeric not null,
pss_07 numeric not null,
usd_07 numeric not null,
eur_07 numeric not null,
ppto_08 numeric not null,
pss_08 numeric not null,
usd_08 numeric not null,
eur_08 numeric not null,
ppto_09 numeric not null,
pss_09 numeric not null,
usd_09 numeric not null,
eur_09 numeric not null,
ppto_10 numeric not null,
pss_10 numeric not null,
usd_10 numeric not null,
eur_10 numeric not null,
ppto_11 numeric not null,
pss_11 numeric not null,
usd_11 numeric not null,
eur_11 numeric not null,
ppto_12 numeric not null,
pss_12 numeric not null,
usd_12 numeric not null,
eur_12 numeric not null,
version_fe numeric(38) options (key 'true') not null,
tc_01 numeric,
tc_02 numeric,
tc_03 numeric,
tc_04 numeric,
tc_05 numeric,
tc_06 numeric,
tc_07 numeric,
tc_08 numeric,
tc_09 numeric,
tc_10 numeric,
tc_11 numeric,
tc_12 numeric,
mon_func varchar(3),
mon_orig varchar(3)
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERA_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_opera_erp_enc (
version_fe numeric(38),
comentario varchar(255),
usuario_id varchar(15),
fecha_extraccion timestamp(0),
version_reglas numeric(38),
fecha_version_reglas timestamp(0),
periodo_origen numeric(38),
version_origen numeric(38),
estatus_origen varchar(255),
version_fe_origen numeric(38),
mes_extraccion numeric(38),
periodo_extraccion numeric(38),
estatus_fe varchar(25)
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERA_ERP_ENC', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_opera_erp_h (
e_codigo numeric(38) options (key 'true') not null,
secuencia_ptto_oracle numeric(38) options (key 'true') not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
ppto_01 numeric not null,
pss_01 numeric not null,
usd_01 numeric not null,
eur_01 numeric not null,
ppto_02 numeric not null,
pss_02 numeric not null,
usd_02 numeric not null,
eur_02 numeric not null,
ppto_03 numeric not null,
pss_03 numeric not null,
usd_03 numeric not null,
eur_03 numeric not null,
ppto_04 numeric not null,
pss_04 numeric not null,
usd_04 numeric not null,
eur_04 numeric not null,
ppto_05 numeric not null,
pss_05 numeric not null,
usd_05 numeric not null,
eur_05 numeric not null,
ppto_06 numeric not null,
pss_06 numeric not null,
usd_06 numeric not null,
eur_06 numeric not null,
ppto_07 numeric not null,
pss_07 numeric not null,
usd_07 numeric not null,
eur_07 numeric not null,
ppto_08 numeric not null,
pss_08 numeric not null,
usd_08 numeric not null,
eur_08 numeric not null,
ppto_09 numeric not null,
pss_09 numeric not null,
usd_09 numeric not null,
eur_09 numeric not null,
ppto_10 numeric not null,
pss_10 numeric not null,
usd_10 numeric not null,
eur_10 numeric not null,
ppto_11 numeric not null,
pss_11 numeric not null,
usd_11 numeric not null,
eur_11 numeric not null,
ppto_12 numeric not null,
pss_12 numeric not null,
usd_12 numeric not null,
eur_12 numeric not null,
version_fe numeric(38) options (key 'true') not null,
tc_01 numeric,
tc_02 numeric,
tc_03 numeric,
tc_04 numeric,
tc_05 numeric,
tc_06 numeric,
tc_07 numeric,
tc_08 numeric,
tc_09 numeric,
tc_10 numeric,
tc_11 numeric,
tc_12 numeric,
mon_func varchar(3),
mon_orig varchar(3),
id_version numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERA_ERP_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_opera_erp_tmp (
periodo_extraccion numeric(15) not null,
mes_extraccion numeric(15) not null,
yyyy numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
cia varchar(25) not null,
neg varchar(25) not null,
cta varchar(25) not null,
scta varchar(25) not null,
cc varchar(25) not null,
icia varchar(25) not null,
top varchar(25) not null,
ppto_01 numeric not null,
ppto_02 numeric not null,
ppto_03 numeric not null,
ppto_04 numeric not null,
ppto_05 numeric not null,
ppto_06 numeric not null,
ppto_07 numeric not null,
ppto_08 numeric not null,
ppto_09 numeric not null,
ppto_10 numeric not null,
ppto_11 numeric not null,
ppto_12 numeric not null,
tc_01 numeric not null,
tc_02 numeric not null,
tc_03 numeric not null,
tc_04 numeric not null,
tc_05 numeric not null,
tc_06 numeric not null,
tc_07 numeric not null,
tc_08 numeric not null,
tc_09 numeric not null,
tc_10 numeric not null,
tc_11 numeric not null,
tc_12 numeric not null,
mf varchar(3),
mo varchar(3),
version_fe numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_OPERA_ERP_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_ppto_versiones_params (
cual_erp varchar(1),
version_fe_cantidad numeric(38)
) server  options(schema 'FECXC', table 'FECXP_PPTO_VERSIONES_PARAMS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_presupuesto_soin (
secuencia_presupuesto_soin numeric(38) options (key 'true') not null,
secmoneda numeric(38),
periodo numeric(38),
prscod numeric(38),
mescod numeric(38),
moneda varchar(3),
arsmap varchar(3),
aejmap varchar(3),
cncmap varchar(3),
importe decimal(20,2)
) server  options(schema 'FECXC', table 'FECXP_PRESUPUESTO_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_real_caratula (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20,4),
estatus varchar(25),
tipo_caratula varchar(2)
) server  options(schema 'FECXC', table 'FECXP_REAL_CARATULA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_real_caratulad (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
fecha timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(38,4),
estatus varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REAL_CARATULAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_real_caratula_h (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20,4),
estatus varchar(25),
tipo_caratula varchar(2),
id_version numeric(38)
) server  options(schema 'FECXC', table 'FECXP_REAL_CARATULA_H', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_real_caratula_impns (
e_codigo numeric not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(20,4),
estatus varchar(25),
tipo_caratula varchar(2),
id_version varchar(100),
utilizar_reporte varchar(1),
id_linea varchar(240),
procesado numeric(38)
) server  options(schema 'FECXC', table 'FECXP_REAL_CARATULA_IMPNS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_referencias_flujo (
referencia_id numeric(38) not null,
referencia_des varchar(10) not null,
cla_fe_id varchar(25) not null
) server  options(schema 'FECXC', table 'FECXP_REFERENCIAS_FLUJO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_reglas_conversion_ppto (
regla_id_conversion numeric(38) options (key 'true') not null,
plataforma varchar(25),
reg_segmento1_ini varchar(25),
reg_segmento1_fin varchar(25),
reg_segmento2_ini varchar(25),
reg_segmento2_fin varchar(25),
reg_segmento3_ini varchar(25),
reg_segmento3_fin varchar(25),
reg_segmento4_ini varchar(25),
reg_segmento4_fin varchar(25),
reg_segmento5_ini varchar(25),
reg_segmento5_fin varchar(25),
reg_segmento6_ini varchar(25),
reg_segmento6_fin varchar(25),
reg_segmento7_ini varchar(25),
reg_segmento7_fin varchar(25),
periodo numeric(38),
mes_ini numeric(38),
mes_fin numeric(38),
reg_segmento8_ini varchar(25),
reg_segmento8_fin varchar(25),
mes_acumulacion numeric(38)
) server  options(schema 'FECXC', table 'FECXP_REGLAS_CONVERSION_PPTO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_replicas_por_cerrar (
e_codigo numeric(38) options (key 'true') not null,
folio_set numeric(38) options (key 'true') not null,
secuencia_pagos_erp numeric(38),
secuencia_aplicada numeric(38)
) server  options(schema 'FECXC', table 'FECXP_REPLICAS_POR_CERRAR', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_bit_cont_din_aper_d (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
ap_invoice_id numeric(15),
ap_distribution_line_number numeric(15) not null,
ap_distribution_amount numeric,
cla_fe_id char(25),
cla_fe_des char(50),
tipo_operacion numeric(38),
id_banco numeric(38),
id_chequera varchar(11),
oracle_segmento1 char(25),
oracle_segmento2 char(25),
oracle_segmento3 char(25),
oracle_segmento4 char(25),
oracle_segmento5 char(25),
oracle_segmento6 char(25),
oracle_segmento7 char(25),
origen_registro char(20)
) server  options(schema 'FECXC', table 'FECXP_REP_BIT_CONT_DIN_APER_D', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_bit_cont_din_aper_e (
id_segmento numeric(38) not null,
des_segmento varchar(80),
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
folio_set varchar(150) not null,
mon_oracle varchar(3) not null,
fecha_aplicacion timestamp(0),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(11),
estatus_movimiento varchar(1),
concepto varchar(100),
beneficiario varchar(60),
importe_set decimal(20,2),
ap_invoice_amount numeric,
ap_invoice_id numeric(15),
estatus_ultima_apertura varchar(11),
fec_ultima_ejecucion timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_REP_BIT_CONT_DIN_APER_E', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_conciliacion_erp (
cla_id_fe varchar(25),
cla_fe_des varchar(25),
concepto varchar(40),
moneda varchar(3),
importe_linea decimal(20,4),
tipo_cambio decimal(20,11),
fecha_aplicacion timestamp(0),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
oracle_segmento1_des varchar(240),
oracle_segmento2_des varchar(240),
oracle_segmento3_des varchar(240),
oracle_segmento4_des varchar(240),
oracle_segmento5_des varchar(240),
oracle_segmento6_des varchar(240),
oracle_segmento7_des varchar(240),
estatus varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_CONCILIACION_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_conciliacion_soin (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
concepto varchar(40),
moneda varchar(3),
importe_linea decimal(20,4),
tipo_cambio decimal(20,11),
fecha_aplicacion timestamp(0),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3)
) server  options(schema 'FECXC', table 'FECXP_REP_CONCILIACION_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_forecast (
cla_fe_id varchar(25) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
tipo_dato varchar(2),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_linea decimal(20,4),
cla_fe_des varchar(100),
des_empresa varchar(100),
id_sesion_rc varchar(256),
estatus varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_FORECAST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_mvcomp_erp (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_debito decimal(20,4),
importe_credito decimal(20,4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_MVCOMP_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_mvcomp_soin (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_debito decimal(20,4),
importe_credito decimal(20,4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
cg13gr numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) server  options(schema 'FECXC', table 'FECXP_REP_MVCOMP_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_comp_c_erp (
e_codigo numeric(38) not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
ppto_01 numeric,
ppto_02 numeric,
ppto_03 numeric,
ppto_04 numeric,
ppto_05 numeric,
ppto_06 numeric,
ppto_07 numeric,
ppto_08 numeric,
ppto_09 numeric,
ppto_10 numeric,
ppto_11 numeric,
ppto_12 numeric,
presupuesto_estatus varchar(20) not null
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_COMP_C_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_comp_o_erp (
e_codigo numeric(38) not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
periodo_ppto numeric(38) not null,
libro_id numeric(15) not null,
version_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
ppto_01 numeric not null,
pss_01 numeric not null,
usd_01 numeric not null,
eur_01 numeric not null,
tipo_cambio_01 numeric,
ppto_02 numeric not null,
pss_02 numeric not null,
usd_02 numeric not null,
eur_02 numeric not null,
tipo_cambio_02 numeric,
ppto_03 numeric not null,
pss_03 numeric not null,
usd_03 numeric not null,
eur_03 numeric not null,
tipo_cambio_03 numeric,
ppto_04 numeric not null,
pss_04 numeric not null,
usd_04 numeric not null,
eur_04 numeric not null,
tipo_cambio_04 numeric,
ppto_05 numeric not null,
pss_05 numeric not null,
usd_05 numeric not null,
eur_05 numeric not null,
tipo_cambio_05 numeric,
ppto_06 numeric not null,
pss_06 numeric not null,
usd_06 numeric not null,
eur_06 numeric not null,
tipo_cambio_06 numeric,
ppto_07 numeric not null,
pss_07 numeric not null,
usd_07 numeric not null,
eur_07 numeric not null,
tipo_cambio_07 numeric,
ppto_08 numeric not null,
pss_08 numeric not null,
usd_08 numeric not null,
eur_08 numeric not null,
tipo_cambio_08 numeric,
ppto_09 numeric not null,
pss_09 numeric not null,
usd_09 numeric not null,
eur_09 numeric not null,
tipo_cambio_09 numeric,
ppto_10 numeric not null,
pss_10 numeric not null,
usd_10 numeric not null,
eur_10 numeric not null,
tipo_cambio_10 numeric,
ppto_11 numeric not null,
pss_11 numeric not null,
usd_11 numeric not null,
eur_11 numeric not null,
tipo_cambio_11 numeric,
ppto_12 numeric not null,
pss_12 numeric not null,
usd_12 numeric not null,
eur_12 numeric not null,
tipo_cambio_12 numeric
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_COMP_O_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_com_cta_erp (
cla_fe_id varchar(25),
e_codigo numeric(38),
code_combination_id numeric not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
moneda varchar(3),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_COM_CTA_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_com_ver_erp (
version_id numeric(38),
version_fe numeric(38),
e_codigo numeric(38),
cla_fe_id varchar(25),
code_combination_id numeric not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
importe_linea decimal(20,4),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_COM_VER_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_com_ver_soin (
version_id numeric(38),
version_fe numeric(38),
cla_fe_id varchar(25),
e_codigo numeric(38),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
tipo varchar(1),
division numeric(38),
rubro numeric(38),
ctacr1 varchar(3),
ctacr2 varchar(4),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
importe_linea decimal(20,4),
id_sesion varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_COM_VER_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_erp (
cod_empresa numeric(38),
des_empresa varchar(100),
rubro varchar(25),
orden_id numeric(38),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
id_sesion numeric(38),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_linea decimal(20,4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_soin (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
id_sesion numeric(38),
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_linea decimal(20,4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
cg13di numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_ppto_ver (
linea_id numeric(38),
version_fe numeric(38),
tipo_dato varchar(1),
cual_erp varchar(1)
) server  options(schema 'FECXC', table 'FECXP_REP_PPTO_VER', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_real_erp (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
id_sesion varchar(256),
periodo numeric(38),
mes numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_linea decimal(20,4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) server  options(schema 'FECXC', table 'FECXP_REP_REAL_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_rep_real_soin (
cod_empresa numeric(38),
des_empresa varchar(100),
cla_id_fe varchar(25),
cla_fe_des varchar(25),
rubro varchar(25),
orden_id numeric(38),
id_sesion numeric(38),
periodo numeric(38),
mes numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20,11),
importe_linea decimal(20,4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
cg13gr numeric(38),
cg13ru numeric(38),
ctatip varchar(1)
) server  options(schema 'FECXC', table 'FECXP_REP_REAL_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_saldos_finales_clasif (
cla_fe_id varchar(25),
atributo_4 varchar(256)
) server  options(schema 'FECXC', table 'FECXP_SALDOS_FINALES_CLASIF', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_saldos_finales_set (
e_codigo numeric(38),
importe decimal(20,4),
moneda varchar(3),
mes numeric(38),
periodo numeric(38)
) server  options(schema 'FECXC', table 'FECXP_SALDOS_FINALES_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_saldos_finales_setd (
e_codigo numeric(38),
importe decimal(20,4),
moneda varchar(3),
fecha timestamp(0)
) server  options(schema 'FECXC', table 'FECXP_SALDOS_FINALES_SETD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_saldos_operativo_erp (
secuencia_saldos_opera_erp numeric(38) options (key 'true') not null,
periodo numeric(38),
mes numeric(38),
e_codigo numeric(38) options (key 'true') not null,
periodo_extraccion numeric(15) not null,
mes_de_extraccion numeric(15) not null,
libro_id numeric(15) not null,
moneda varchar(3) not null,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
saldo_inicial_mo decimal(20,2) not null,
debito_inicial_mo decimal(20,2) not null,
credito_inicial_mo decimal(20,2) not null,
saldo_final_mo decimal(20,2) not null,
saldo_inicial_me decimal(20,2) not null,
debito_inicial_me decimal(20,2) not null,
credito_inicial_me decimal(20,2) not null,
saldo_final_me decimal(20,2) not null
) server  options(schema 'FECXC', table 'FECXP_SALDOS_OPERATIVO_ERP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_saldos_operativo_soin (
secuencia_saldos_opera_soin numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
moneda varchar(3),
periodo numeric(38),
mes numeric(38),
saldo_inicial_mo decimal(20,2),
debito_inicial_mo decimal(20,2),
credito_inicial_mo decimal(20,2),
saldo_inicial_me decimal(20,2),
debito_inicial_me decimal(20,2),
credito_inicial_me decimal(20,2),
mes_extraccion numeric(38),
periodo_extraccion numeric(15)
) server  options(schema 'FECXC', table 'FECXP_SALDOS_OPERATIVO_SOIN', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fecxp_seg_no_set (
id_seg numeric options (key 'true') not null,
desc_seg varchar(500) not null,
tipo_empresa varchar(10)
) server  options(schema 'FECXC', table 'FECXP_SEG_NO_SET', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table fe_extrae_folios (
folio numeric(15) not null,
no_empresa numeric(15) not null,
id_banco numeric(15) not null,
id_chequera varchar(80) not null,
id_divisa varchar(3) not null,
fecha timestamp(0),
ingresos numeric(15),
egresos numeric(15),
tipo_operacion char(1)
) server  options(schema 'FECXC', table 'FE_EXTRAE_FOLIOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table plan_table (
statement_id varchar(30),
timestamp timestamp(0),
remarks varchar(80),
operation varchar(30),
options varchar(255),
object_node varchar(128),
object_owner varchar(30),
object_name varchar(30),
object_instance numeric(38),
object_type varchar(30),
optimizer varchar(255),
search_columns numeric,
id numeric(38),
parent_id numeric(38),
position numeric(38),
cost numeric(38),
cardinality numeric(38),
bytes numeric(38),
other_tag varchar(255),
partition_start varchar(255),
partition_stop varchar(255),
partition_id numeric(38),
other text,
distribution varchar(30),
cpu_cost numeric(38),
io_cost numeric(38),
temp_space numeric(38)
) server  options(schema 'FECXC', table 'PLAN_TABLE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table prp002 (
prp2per numeric(38) options (key 'true') not null,
prp2form varchar(1) not null,
prp2est numeric(38),
prp7ide numeric(38) not null,
prp2sub numeric(38) not null,
prp2tipo char(1),
prp2can numeric(38) not null,
prp2fec timestamp not null,
prp2fecf timestamp not null,
prp2fece timestamp,
prp2fecr timestamp not null,
prp2fecl timestamp not null,
prpconci numeric(38),
prpconce numeric(38),
prpconct numeric(38),
prpconex numeric(38),
prpconaj numeric(38) not null,
prp2nap numeric(38),
cge1cod char(5) not null,
cge5cod varchar(5) not null,
prp2npr numeric(38),
prp2nep numeric(38),
timestamp timestamp,
prp2mce numeric(38)
) server  options(schema 'FECXC', table 'PRP002', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table queries (
entidad varchar(30) options (key 'true') not null,
nombre varchar(50) options (key 'true') not null,
usuario varchar(30) options (key 'true') not null,
condicion varchar(255) not null,
ordenamiento varchar(255) not null,
timestamp timestamp
) server  options(schema 'FECXC', table 'QUERIES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_asoc_fact_cheq (
id_sec_cheque numeric(38) options (key 'true') not null,
customer_trx_id numeric(38) options (key 'true') not null,
e_codigo numeric(38),
id_estado_cheque numeric(38),
monto decimal(20,2),
moneda varchar(3),
tipo_cambio decimal(20,4),
org_id numeric(38),
trx_number varchar(20),
no_cheque numeric(38)
) server  options(schema 'FECXC', table 'XXCHK_ASOC_FACT_CHEQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_asoc_fact_cheq_syb (
id_sec_cheque numeric(38) options (key 'true') not null,
fam01cod varchar(4) options (key 'true') not null,
fax01ntr numeric(38) options (key 'true') not null,
facdoc varchar(15) options (key 'true') not null,
id_estado_cheque numeric(38),
e_codigo numeric(38),
clinom varchar(50),
clicod varchar(15),
monto decimal(20,2),
moneda varchar(3),
tipo_cambio decimal(20,4),
depref varchar(22) not null,
empresa_sy varchar(3) not null,
no_cheque numeric(38),
ttrcod varchar(2)
) server  options(schema 'FECXC', table 'XXCHK_ASOC_FACT_CHEQ_SYB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_bit_errores (
codigo_error varchar(3),
desc_error varchar(30),
id_cheque numeric(38),
code_combination varchar(50),
compania numeric(38),
status_cheque varchar(30)
) server  options(schema 'FECXC', table 'XXCHK_BIT_ERRORES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_captura_cheques (
id_sec_cheque numeric(38) options (key 'true') not null,
e_codigo numeric(38),
id_banco numeric(38),
id_estado_cheque numeric(38),
no_cheque numeric(38) not null,
referencia_cliente varchar(50),
id_cliente varchar(50) not null,
cheque_repuesto numeric(38),
no_cheque_reemplazo numeric(38),
fecha_emision timestamp(0) not null,
fecha_cobro timestamp(0),
date_created timestamp(0) not null,
last_modified_date timestamp(0),
created_by varchar(30) not null,
modified_by varchar(30),
importe decimal(20,2) not null,
moneda varchar(3) not null,
entregado_por varchar(30) not null,
expide varchar(50) not null,
imagen varchar(120) not null,
vencido numeric(38),
desc_cliente varchar(80),
procesado numeric(38),
id_banco_rep numeric(38),
folio varchar(30),
en_recibo_ar varchar(1)
) server  options(schema 'FECXC', table 'XXCHK_CAPTURA_CHEQUES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_catalogo_bancos (
id_banco numeric(38) options (key 'true') not null,
descripcion_banco varchar(50) not null
) server  options(schema 'FECXC', table 'XXCHK_CATALOGO_BANCOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_cat_cambios_estado (
id_estado_cheque numeric(38) options (key 'true') not null,
id_estado_b numeric(38) options (key 'true') not null,
descripcion varchar(100) not null
) server  options(schema 'FECXC', table 'XXCHK_CAT_CAMBIOS_ESTADO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_cat_edos (
id_estado_cheque numeric(38) options (key 'true') not null,
descripcion varchar(100) not null,
tipo_operacion varchar(20),
date_created timestamp(0)
) server  options(schema 'FECXC', table 'XXCHK_CAT_EDOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_cat_edo_cheque (
e_codigo numeric(38) options (key 'true') not null,
id_estado_cheque numeric(38) options (key 'true') not null,
c_cargo_erp numeric(38),
c_abono_erp numeric(38),
c_cargo_soin varchar(4),
sc_cargo_soin varchar(4),
ssc_cargo_soin varchar(4),
cr_cargo_soin varchar(3),
cr_cargo_soin2 varchar(4),
c_abono_soin varchar(4),
sc_abono_soin varchar(4),
ssc_abono_soin varchar(4),
cr_abono_soin varchar(3),
cr_abono_soin2 varchar(4),
contabiliza numeric(1),
envia_correo numeric(1)
) server  options(schema 'FECXC', table 'XXCHK_CAT_EDO_CHEQUE', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_cheques_all (
e_codigo numeric(38) options (key 'true') not null,
no_folio_det numeric(38) options (key 'true') not null,
id_status_mov varchar(2) options (key 'true') not null,
id_banco numeric(38),
id_tipo_operacion_set numeric(38) not null,
fec_valor timestamp(0),
referencia_cliente varchar(50) not null,
id_chequera varchar(20),
concepto varchar(100),
tipo_cambio decimal(20,4),
importe decimal(20,2),
id_cheque_set numeric(38),
id_forma_pago numeric(38),
moneda varchar(3),
fec_valor_original timestamp(0) not null,
beneficiario varchar(60),
procesado numeric(38),
id_cheque_sel numeric(38),
chk_orden numeric(38)
) server  options(schema 'FECXC', table 'XXCHK_CHEQUES_ALL', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_cheq_all_hist (
id_estado_cheque numeric(38),
id_sec_cheque numeric(38),
e_codigo numeric(38),
no_folio_det numeric(38),
id_status_mov varchar(2),
date_created timestamp(0) not null,
modified_by varchar(30) not null,
tipo_cheq varchar(15) not null,
referencia_cliente varchar(50) not null,
id_tipo_operacion_set numeric(38),
no_cheque numeric(38),
procesado numeric(38),
group_id numeric
) server  options(schema 'FECXC', table 'XXCHK_CHEQ_ALL_HIST', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_gl_interface_chk (
id_estado_cheque numeric(38) not null,
id_sec_cheque numeric(38) not null,
status varchar(50) not null,
set_of_books_id numeric not null,
accounting_date timestamp(0) not null,
currency_code varchar(3) not null,
currency_conversion_date timestamp(0),
user_currency_conversion_type varchar(30),
currency_conversion_rate numeric,
actual_flag varchar(1) not null,
user_je_category_name varchar(25) not null,
user_je_source_name varchar(25) not null,
segment1 varchar(25),
segment2 varchar(25),
segment3 varchar(25),
segment4 varchar(25),
segment5 varchar(25),
segment6 varchar(25),
segment7 varchar(25),
entered_dr numeric,
entered_cr numeric,
accounted_dr numeric,
accounted_cr numeric,
reference1 varchar(100),
period_name varchar(25),
code_combination_id numeric,
group_id numeric not null,
procesado numeric(38),
date_created timestamp(0) not null,
created_by varchar(30) not null
) server  options(schema 'FECXC', table 'XXCHK_GL_INTERFACE_CHK', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_intarc_ora (
e_codigo numeric(38) options (key 'true') not null,
intbat varchar(50),
intori varchar(2),
intsub varchar(2),
intrel numeric(38),
intdoc varchar(12),
intref varchar(12),
intmon numeric,
intmoe numeric,
inttip varchar(1),
intdes varchar(40),
intdia varchar(2),
intfec varchar(8),
intcam numeric,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(4),
ctam04 varchar(4),
ctam05 varchar(3),
ctam06 varchar(3),
moncod varchar(2),
impfpo varchar(8),
tv6prd numeric(38),
impref2 varchar(30),
tv9ide varchar(20),
date_created timestamp(0),
created_by varchar(30),
procesado numeric(38)
) server  options(schema 'FECXC', table 'XXCHK_INTARC_ORA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_mapeo_de_estados (
id_estado_cheque numeric(38),
id_tipo_operacion_set numeric(38) not null,
descripcion varchar(100) not null,
date_created timestamp(0)
) server  options(schema 'FECXC', table 'XXCHK_MAPEO_DE_ESTADOS', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_parametros_generales (
antiguedad numeric not null,
rechazos_maximos numeric not null,
usuario_autoriza varchar(30) not null,
estado_inicial_chk numeric(38) not null,
edo_entregado_cli numeric(38) not null,
e_codigo varchar(10),
e_codigo_d varchar(75)
) server  options(schema 'FECXC', table 'XXCHK_PARAMETROS_GENERALES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_roles (
id_rol numeric(38) options (key 'true') not null,
desc_rol varchar(100)
) server  options(schema 'FECXC', table 'XXCHK_ROLES', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_roles_actividad (
id_rol numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null,
id_estado_cheque numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'XXCHK_ROLES_ACTIVIDAD', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_roles_xempresa (
id_rol numeric(38) options (key 'true') not null,
e_codigo numeric(38) options (key 'true') not null
) server  options(schema 'FECXC', table 'XXCHK_ROLES_XEMPRESA', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxchk_roles_x_usuario (
id_rol numeric(38) options (key 'true') not null,
codusuario varchar(40) options (key 'true') not null
) server  options(schema 'FECXC', table 'XXCHK_ROLES_X_USUARIO', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxfecxc_tit_rep_comer_tab (
id_titulo numeric,
des_titulo varchar(200),
ind_titulo_activo numeric,
ind_elije_titulo numeric,
attribute1 varchar(250),
attribute2 varchar(250),
attribute3 varchar(250),
attribute4 varchar(250),
attribute5 varchar(250),
attribute6 varchar(250),
attribute7 varchar(250),
attribute8 varchar(250),
attribute9 varchar(250),
attribute10 varchar(250),
attribute11 varchar(250),
attribute12 varchar(250),
attribute13 varchar(250),
attribute14 varchar(250),
attribute15 varchar(250),
fec_creation_date timestamp(0),
last_login numeric,
num_created_by numeric(15),
num_last_updated_by numeric(15),
fec_last_update_date timestamp(0),
num_last_update_login numeric(15)
) server  options(schema 'FECXC', table 'XXFECXC_TIT_REP_COMER_TAB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table xxfnc_debug_tbl_tmp (
consecutivo numeric,
fecha_registro timestamp(0),
l_place varchar(100),
l_calling_module varchar(100),
l_msg varchar(500)
) server  options(schema 'FECXC', table 'XXFNC_DEBUG_TBL_TMP', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table secuencia_soin (
noparche varchar(8),
sistem varchar(15),
nopdesa varchar(15),
fecha timestamp,
timestamp timestamp
) server  options(schema 'FECXC', table 'secuencia_soin', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table tmp_xxchk_asoc_fact_cheq (
id_sec_cheque numeric(38) not null,
customer_trx_id numeric(38) not null,
e_codigo numeric(38),
monto decimal(20,2),
moneda varchar(3),
tipo_cambio decimal(20,4),
org_id numeric(38),
trx_number varchar(20)
) server  options(schema 'FECXC', table 'tmp_XXCHK_ASOC_FACT_CHEQ', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table tmp_xxchk_asoc_fact_cheq_syb (
id_sec_cheque numeric(38) not null,
fam01cod varchar(4) not null,
fax01ntr numeric(38) not null,
facdoc varchar(15) not null,
clinom varchar(50),
clicod varchar(15),
monto decimal(20,2),
moneda varchar(3),
tipo_cambio decimal(20,4),
depref varchar(22) not null,
empresa_sy varchar(3) not null
) server  options(schema 'FECXC', table 'tmp_XXCHK_ASOC_FACT_CHEQ_SYB', readonly 'true');
-- dmap_object_gen_tag : type : fdw name : table
set search_path = fecxc,oracle,dmap_extension,public;
create foreign  table tmp_xxchk_gl_interface_chk (
status varchar(50) not null,
set_of_books_id numeric not null,
accounting_date timestamp(0) not null,
currency_code varchar(3) not null,
currency_conversion_date timestamp(0),
user_currency_conversion_type varchar(30),
currency_conversion_rate numeric,
actual_flag varchar(1) not null,
user_je_category_name varchar(25) not null,
user_je_source_name varchar(25) not null,
segment1 varchar(25),
segment2 varchar(25),
segment3 varchar(25),
segment4 varchar(25),
segment5 varchar(25),
segment6 varchar(25),
segment7 varchar(25),
entered_dr numeric,
entered_cr numeric,
accounted_dr numeric,
accounted_cr numeric,
reference1 varchar(100),
period_name varchar(2),
code_combination_id numeric,
group_id numeric not null,
procesado numeric(38),
date_created timestamp(0) not null,
created_by varchar(30) not null
) server  options(schema 'FECXC', table 'tmp_XXCHK_GL_INTERFACE_CHK', readonly 'true');
