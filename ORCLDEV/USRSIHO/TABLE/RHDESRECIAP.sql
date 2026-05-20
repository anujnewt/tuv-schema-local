-- dmap_object_gen_tag : type : table name : rhdesreciap
set search_path = usrsiho,oracle,dmap_extension,public;
create table "rhdesreciap"  (
iap_keysec numeric(10) not null,
iap_descap varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : rhdesreciap
set search_path = usrsiho,oracle,dmap_extension,public;
alter table rhdesreciap alter column iap_keysec set not null;
