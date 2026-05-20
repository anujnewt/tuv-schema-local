-- dmap_object_gen_tag : type : table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge020"  (
cge20cod numeric(38) not null,
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
) ;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 add primary key (cge20cod);
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20pas set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20nol set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20est set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20cre set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20act set not null;
-- dmap_object_gen_tag : type : alter table name : cge020
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge020 alter column cge20ifu set not null;
