-- dmap_object_gen_tag : type : table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
create table "ttcopcion"  (
idopcion numeric(38) not null default 0,
opcion varchar(255) not null,
puntaje numeric(38) not null,
secuencia numeric(38) not null,
idpregunta numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcopcion alter column idopcion set not null;
-- dmap_object_gen_tag : type : alter table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcopcion alter column opcion set not null;
-- dmap_object_gen_tag : type : alter table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcopcion alter column puntaje set not null;
-- dmap_object_gen_tag : type : alter table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcopcion alter column secuencia set not null;
-- dmap_object_gen_tag : type : alter table name : ttcopcion
set search_path = pppt,oracle,dmap_extension,public;
alter table ttcopcion alter column idpregunta set not null;
