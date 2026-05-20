-- dmap_object_gen_tag : type : table name : glcoacim
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoacim"  (
aci_keyusu numeric(5) not null,
aci_keyimp varchar(15) not null
) ;
-- dmap_object_gen_tag : type : alter table name : glcoacim
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacim add constraint pk_hacim primary key (aci_keyusu,aci_keyimp);
-- dmap_object_gen_tag : type : alter table name : glcoacim
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacim alter column aci_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : glcoacim
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacim alter column aci_keyimp set not null;
