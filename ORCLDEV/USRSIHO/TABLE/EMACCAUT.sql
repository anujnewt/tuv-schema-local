-- dmap_object_gen_tag : type : table name : emaccaut
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emaccaut"  (
acc_keyusu numeric(10) not null,
acc_passwd varchar(10) not null,
acc_nombre varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emaccaut
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emaccaut alter column acc_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : emaccaut
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emaccaut alter column acc_passwd set not null;
-- dmap_object_gen_tag : type : alter table name : emaccaut
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emaccaut alter column acc_nombre set not null;
