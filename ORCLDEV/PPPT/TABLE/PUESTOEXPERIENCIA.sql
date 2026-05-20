-- dmap_object_gen_tag : type : table name : puestoexperiencia
set search_path = pppt,oracle,dmap_extension,public;
create table "puestoexperiencia"  (
idpuesto numeric(38) not null,
idexperiencia numeric(38) not null,
peso numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestoexperiencia
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoexperiencia alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestoexperiencia
set search_path = pppt,oracle,dmap_extension,public;
alter table puestoexperiencia alter column idexperiencia set not null;
