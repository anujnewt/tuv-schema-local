-- dmap_object_gen_tag : type : table name : factura_ter
set search_path = usrsiho,oracle,dmap_extension,public;
create table "factura_ter"  (
poliza numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : factura_ter
set search_path = usrsiho,oracle,dmap_extension,public;
alter table factura_ter alter column poliza set not null;
