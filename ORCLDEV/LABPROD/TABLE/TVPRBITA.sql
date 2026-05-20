-- dmap_object_gen_tag : type : table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
create table "tvprbita"  (
bit_keyusu numeric(38) not null,
bit_logusu char(15) not null,
bit_idepcc char(15) not null,
bit_fecmov timestamp(0) not null,
bit_hormov char(8) not null,
bit_tipmov char(2) not null,
bit_key001 char(18),
bit_key002 char(18) not null,
bit_key003 numeric(38) not null,
bit_val001 char(18),
bit_val002 char(18),
bit_val003 char(18),
bit_desmen char(36),
bit_ideniv numeric(38) not null,
bit_keypre decimal(16, 6),
bit_ca1aux numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_logusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_idepcc set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_fecmov set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_hormov set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_tipmov set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_key002 set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_key003 set not null;
-- dmap_object_gen_tag : type : alter table name : tvprbita
set search_path = labprod,oracle,dmap_extension,public;
alter table tvprbita alter column bit_ideniv set not null;
