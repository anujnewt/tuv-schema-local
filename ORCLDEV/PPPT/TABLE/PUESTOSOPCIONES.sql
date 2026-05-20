-- dmap_object_gen_tag : type : table name : puestosopciones
set search_path = pppt,oracle,dmap_extension,public;
create table "puestosopciones"  (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
idopcion numeric(38) not null,
valor numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestosopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosopciones alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestosopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosopciones alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : puestosopciones
set search_path = pppt,oracle,dmap_extension,public;
alter table puestosopciones alter column idopcion set not null;
