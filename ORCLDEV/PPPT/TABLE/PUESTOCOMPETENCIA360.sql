-- dmap_object_gen_tag : type : table name : puestocompetencia360
set search_path = pppt,oracle,dmap_extension,public;
create table "puestocompetencia360"  (
idpuesto numeric(38) not null,
idcompetencia numeric(38) not null,
peso numeric(38),
idpuestoactividad numeric(38) not null default 0,
idpuestocompetencia numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : puestocompetencia360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestocompetencia360 alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestocompetencia360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestocompetencia360 alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : puestocompetencia360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestocompetencia360 alter column idpuestoactividad set not null;
-- dmap_object_gen_tag : type : alter table name : puestocompetencia360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestocompetencia360 alter column idpuestocompetencia set not null;
