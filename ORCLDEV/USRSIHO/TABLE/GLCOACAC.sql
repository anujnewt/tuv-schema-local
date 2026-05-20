-- dmap_object_gen_tag : type : table name : glcoacac
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoacac"  (
aca_keyusu numeric(10) not null,
aca_keypue varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : glcoacac
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacac add constraint pk_hacac primary key (aca_keyusu,aca_keypue);
