-- dmap_object_gen_tag : type : table name : cathabilidad
set search_path = pppt,oracle,dmap_extension,public;
create table "cathabilidad"  (
idhabilidad numeric(38) not null default 0,
habilidad varchar(100),
idhabilidadtipo numeric(38),
idprueba numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : cathabilidad
set search_path = pppt,oracle,dmap_extension,public;
alter table cathabilidad alter column idhabilidad set not null;
