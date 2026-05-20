-- dmap_object_gen_tag : type : table name : recibos_generacion
set search_path = labprod,oracle,dmap_extension,public;
create table "recibos_generacion"  (
id numeric(38),
eje_feceje timestamp not null,
eje_mensaj varchar(4000),
eje_error numeric(1) not null default 0,
eje_keypro numeric(5),
eje_keyper varchar(7)
) ;
-- dmap_object_gen_tag : type : alter table name : recibos_generacion
set search_path = labprod,oracle,dmap_extension,public;
alter table recibos_generacion alter column eje_feceje set not null;
-- dmap_object_gen_tag : type : alter table name : recibos_generacion
set search_path = labprod,oracle,dmap_extension,public;
alter table recibos_generacion alter column eje_error set not null;
