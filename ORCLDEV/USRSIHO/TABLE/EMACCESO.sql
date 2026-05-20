-- dmap_object_gen_tag : type : table name : emacceso
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emacceso"  (
acc_keyusu numeric(10) not null,
acc_keyobj numeric(10) not null,
acc_tipmov varchar(4) not null,
acc_tipacc varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : emacceso
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emacceso alter column acc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : emacceso
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emacceso alter column acc_keyobj set not null;
-- dmap_object_gen_tag : type : alter table name : emacceso
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emacceso alter column acc_tipmov set not null;
