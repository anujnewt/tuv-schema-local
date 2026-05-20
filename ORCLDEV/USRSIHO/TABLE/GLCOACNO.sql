-- dmap_object_gen_tag : type : table name : glcoacno
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoacno"  (
acn_keynom numeric(5) not null,
acn_keyusu numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : glcoacno
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacno add constraint pk_gacno primary key (acn_keynom,acn_keyusu);
-- dmap_object_gen_tag : type : alter table name : glcoacno
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacno alter column acn_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : glcoacno
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacno alter column acn_keyusu set not null;
