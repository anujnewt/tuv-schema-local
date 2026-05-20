-- dmap_object_gen_tag : type : table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
create table "grupoentidadestadisticas360"  (
idgrupo numeric(38) not null,
tipoentidad numeric(38) not null,
idcompetencia numeric(38) not null,
idpersonal numeric(38) not null,
desvstd numeric not null,
moda numeric not null,
media numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column idgrupo set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column tipoentidad set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column desvstd set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column moda set not null;
-- dmap_object_gen_tag : type : alter table name : grupoentidadestadisticas360
set search_path = pppt,oracle,dmap_extension,public;
alter table grupoentidadestadisticas360 alter column media set not null;
