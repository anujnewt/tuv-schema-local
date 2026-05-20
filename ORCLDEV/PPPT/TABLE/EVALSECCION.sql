-- dmap_object_gen_tag : type : table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
create table "evalseccion"  (
idseccion numeric(38) not null default 0,
seccion varchar(100) not null,
idevaluacion numeric(38) not null default 0,
numpreguntas numeric(38) not null default 0,
pesoseccion numeric(38) not null default 0,
maxminutos numeric(38) not null default 0,
idtema numeric(38) not null default 0,
idcompetencia numeric(38) not null default 0,
nivel numeric(38) not null default 0,
ordenseccion numeric(38) not null default 0,
bshownombre numeric(1) not null default 0,
bshowintro numeric(1) not null default 0,
introduccion varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column idseccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column seccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column idevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column numpreguntas set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column pesoseccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column maxminutos set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column idtema set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column idcompetencia set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column ordenseccion set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column bshownombre set not null;
-- dmap_object_gen_tag : type : alter table name : evalseccion
set search_path = pppt,oracle,dmap_extension,public;
alter table evalseccion alter column bshowintro set not null;
