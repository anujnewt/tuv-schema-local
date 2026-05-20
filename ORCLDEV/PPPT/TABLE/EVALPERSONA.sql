-- dmap_object_gen_tag : type : table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
create table "evalpersona"  (
idpersonaevaluacion numeric(38) not null default 0,
idpersona numeric(38) not null,
idevaluacion numeric(38) not null,
fecha timestamp(0) not null,
calificacion numeric not null default 0,
minutos numeric(38) not null default 0,
status numeric(38) not null default 0,
baprobado numeric(1) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column idpersonaevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column idpersona set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column idevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column fecha set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column calificacion set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column minutos set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column status set not null;
-- dmap_object_gen_tag : type : alter table name : evalpersona
set search_path = pppt,oracle,dmap_extension,public;
alter table evalpersona alter column baprobado set not null;
