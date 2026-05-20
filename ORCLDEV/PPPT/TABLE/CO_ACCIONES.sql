-- dmap_object_gen_tag : type : table name : co_acciones
set search_path = pppt,oracle,dmap_extension,public;
create table "co_acciones"  (
idaccion numeric(38) not null default 0,
accion varchar(255),
responsable varchar(255),
avance numeric(38),
inicio timestamp(0),
fin timestamp(0),
status numeric(38),
alta timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : co_acciones
set search_path = pppt,oracle,dmap_extension,public;
alter table co_acciones alter column idaccion set not null;
