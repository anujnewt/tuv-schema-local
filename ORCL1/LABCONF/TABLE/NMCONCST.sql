-- dmap_object_gen_tag : type : table name : nmconcst
set search_path = labconf,oracle,dmap_extension,public;
create table "nmconcst"  (
cst_keycve numeric(38) not null,
cst_keycon char(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmconcst
set search_path = labconf,oracle,dmap_extension,public;
alter table nmconcst alter column cst_keycve set not null;
-- dmap_object_gen_tag : type : alter table name : nmconcst
set search_path = labconf,oracle,dmap_extension,public;
alter table nmconcst alter column cst_keycon set not null;
