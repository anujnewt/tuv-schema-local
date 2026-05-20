-- dmap_object_gen_tag : type : table name : puestoactividad360
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoactividad360"  (
idpuestoactividad numeric(38) not null default 0,
idpuesto numeric(38),
nombre varchar(255),
peso numeric(38),
actividad varchar(4000),
idpuestoobjetivo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestoactividad360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoactividad360 alter column idpuestoactividad set not null;
