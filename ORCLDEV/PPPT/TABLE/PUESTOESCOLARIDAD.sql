-- dmap_object_gen_tag : type : table name : puestoescolaridad
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoescolaridad"  (
idpuesto numeric(38) not null,
idescolaridad numeric(38) not null,
peso numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestoescolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoescolaridad alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestoescolaridad
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoescolaridad alter column idescolaridad set not null;
