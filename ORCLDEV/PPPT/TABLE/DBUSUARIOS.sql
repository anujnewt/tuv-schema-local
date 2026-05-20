-- dmap_object_gen_tag : type : table name : dbusuarios
set search_path = pppt,oracle,dmap_extension,public;
create table "dbusuarios"  (
idusuario numeric(38) not null default 0,
usuario varchar(50),
"password" varchar(20),
admin numeric(38),
activo numeric(38),
readonly numeric(38),
filtropersonas varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : dbusuarios
set search_path = pppt,oracle,dmap_extension,public;
alter table dbusuarios alter column idusuario set not null;
