-- dmap_object_gen_tag : type : table name : cathabilidadtipo
set search_path = pppt,oracle,dmap_extension,public;
create table "cathabilidadtipo"  (
idhabilidadtipo numeric(38) not null default 0,
habilidadtipo varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : cathabilidadtipo
set search_path = pppt,oracle,dmap_extension,public;
alter table cathabilidadtipo alter column idhabilidadtipo set not null;
