-- dmap_object_gen_tag : type : table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
create table "capcurso"  (
idcurso numeric(38) not null default 0,
curso varchar(100) not null,
duracion numeric(38) not null default 0,
cupo numeric(38) not null default 0,
frecuencia numeric(38) not null default 0,
costopersonatipo numeric(38) not null default 0,
costopersonavalor numeric not null default 0,
costopersonaobs varchar(255),
contacto varchar(255),
idempresa numeric(38) not null default 0,
descripcion varchar(4000),
objetivo varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column idcurso set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column curso set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column duracion set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column cupo set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column frecuencia set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column costopersonatipo set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column costopersonavalor set not null;
-- dmap_object_gen_tag : type : alter table name : capcurso
set search_path = pppt,oracle,dmap_extension,public;
alter table capcurso alter column idempresa set not null;
