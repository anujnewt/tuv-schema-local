-- dmap_object_gen_tag : type : table name : puestoobjetivo360
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoobjetivo360"  (
idpuestoobjetivo numeric(38) not null default 0,
idpuesto numeric(38),
nombre varchar(255),
peso numeric(38),
indicador numeric,
objetivo varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : puestoobjetivo360
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoobjetivo360 alter column idpuestoobjetivo set not null;
