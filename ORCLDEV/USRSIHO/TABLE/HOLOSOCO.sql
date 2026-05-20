-- dmap_object_gen_tag : type : table name : holosoco
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holosoco"  (
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
) ;
-- dmap_object_gen_tag : type : alter table name : holosoco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holosoco alter column soc_keysol set not null;
-- dmap_object_gen_tag : type : alter table name : holosoco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holosoco alter column soc_fecsol set not null;
-- dmap_object_gen_tag : type : alter table name : holosoco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holosoco alter column soc_nomemp set not null;
-- dmap_object_gen_tag : type : alter table name : holosoco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holosoco alter column soc_regrfc set not null;
