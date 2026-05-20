-- dmap_object_gen_tag : type : table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
create table "compatibilidadcompetencias"  (
idpersona numeric(38) not null,
idperfil numeric(38) not null,
idcompetencia numeric(38) not null,
compatibilidad0 numeric not null,
compatibilidad1 numeric not null,
compatibilidad2 numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column idpersona set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column idperfil set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column compatibilidad0 set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column compatibilidad1 set not null;
-- dmap_object_gen_tag : type : alter table name : compatibilidadcompetencias
set search_path = pppt,oracle,dmap_extension,public;
alter table compatibilidadcompetencias alter column compatibilidad2 set not null;
