-- dmap_object_gen_tag : type : table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
create table "compatibilidadnivelperfil"  (
idpersona numeric(38) not null,
idnivel numeric(38) not null,
idempresa numeric(38) not null,
compatibilidad0 numeric not null,
compatibilidad1 numeric not null,
compatibilidad2 numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column idpersona set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column idnivel set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column compatibilidad0 set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column compatibilidad1 set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadnivelperfil
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadnivelperfil alter column compatibilidad2 set not null;
