-- dmap_object_gen_tag : type : table name : catdepartamento
set search_path = pppt,oracle,dmap_extension,public;
create table "catdepartamento"  (
iddepartamento numeric(38) not null default 0,
departamento varchar(100) not null,
idarea numeric(38),
idempresa numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : catdepartamento
set search_path = pppt,oracle,dmap_extension,public;
alter table catdepartamento alter column iddepartamento set not null;
-- dmap_object_gen_tag : type : alter table name : catdepartamento
set search_path = pppt,oracle,dmap_extension,public;
alter table catdepartamento alter column departamento set not null;
