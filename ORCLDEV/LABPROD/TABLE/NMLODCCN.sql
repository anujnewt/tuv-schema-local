-- dmap_object_gen_tag : type : table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlodccn"  (
dcc_keycia varchar(5) not null,
dcc_keyper varchar(7) not null,
dcc_keyrub varchar(3) not null,
dcc_codimp varchar(2) not null,
dcc_keycon varchar(3) not null,
dcc_tipope varchar(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_keyrub set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_codimp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : nmlodccn
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlodccn alter column dcc_tipope set not null;
