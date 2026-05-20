-- dmap_object_gen_tag : type : table name : evacatopcion
set search_path = pppt,oracle,dmap_extension,public;
create table "evacatopcion"  (
idopcion numeric(38) not null default 0,
idpregunta numeric(38) not null,
puntos numeric(38) not null default 0,
opcion varchar(4000) not null
) ;
-- dmap_object_gen_tag : type : alter table name : evacatopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatopcion alter column idopcion set not null;
-- dmap_object_gen_tag : type : alter table name : evacatopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatopcion alter column idpregunta set not null;
-- dmap_object_gen_tag : type : alter table name : evacatopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatopcion alter column puntos set not null;
-- dmap_object_gen_tag : type : alter table name : evacatopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table evacatopcion alter column opcion set not null;
