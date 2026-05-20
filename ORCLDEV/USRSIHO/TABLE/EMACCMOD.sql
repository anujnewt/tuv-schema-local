-- dmap_object_gen_tag : type : table name : emaccmod
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emaccmod"  (
acc_keyusu numeric(10) not null,
acc_keymod numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emaccmod
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emaccmod alter column acc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : emaccmod
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emaccmod alter column acc_keymod set not null;
