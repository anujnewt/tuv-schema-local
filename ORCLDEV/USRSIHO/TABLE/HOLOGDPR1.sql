-- dmap_object_gen_tag : type : table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hologdpr1"  (
gdp_keysec numeric(10) not null,
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
gdp_cosuni numeric not null,
gdp_keysue varchar(4),
gdp_keytco numeric(5),
gdp_keyfol numeric(10),
gdp_keyusu numeric(10),
gdp_minleg numeric(10),
gdp_minsal numeric(10),
gdp_minext numeric(10),
gdp_mincom numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 add constraint pk_hgdpr1 primary key (gdp_keysec);
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keysec set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keyrph set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_fechag set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_capini set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_capfin set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_numcap set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_marcon set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_marcos set not null;
-- dmap_object_gen_tag : type : alter table name : hologdpr1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologdpr1 alter column gdp_cosuni set not null;
