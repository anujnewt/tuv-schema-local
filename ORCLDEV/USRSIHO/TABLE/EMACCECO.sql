-- dmap_object_gen_tag : type : table name : emacceco
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emacceco"  (
cco_keyusu numeric(10) not null,
cco_keydep varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emacceco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emacceco alter column cco_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : emacceco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emacceco alter column cco_keydep set not null;
