-- dmap_object_gen_tag : type : table name : pploccxv
set search_path = labppto,oracle,dmap_extension,public;
create table "pploccxv"  (
ccx_keycia varchar(4) not null,
ccx_keyvic numeric(38) not null,
ccx_keycen varchar(16) not null,
ccx_keyame numeric(38),
ccx_descri varchar(50) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pploccxv
set search_path = labppto,oracle,dmap_extension,public;
alter table pploccxv alter column ccx_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pploccxv
set search_path = labppto,oracle,dmap_extension,public;
alter table pploccxv alter column ccx_keyvic set not null;
-- dmap_object_gen_tag : type : alter table name : pploccxv
set search_path = labppto,oracle,dmap_extension,public;
alter table pploccxv alter column ccx_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : pploccxv
set search_path = labppto,oracle,dmap_extension,public;
alter table pploccxv alter column ccx_descri set not null;
