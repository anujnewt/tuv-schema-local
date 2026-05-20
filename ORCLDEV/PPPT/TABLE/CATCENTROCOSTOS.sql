-- dmap_object_gen_tag : type : table name : catcentrocostos
set search_path = pppt,oracle,dmap_extension,public;
create table "catcentrocostos"  (
idcentrocostos numeric(38) not null default 0,
centrocostos varchar(100) not null,
idseccion numeric(38) not null default 0,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catcentrocostos
set search_path = pppt,oracle,dmap_extension,public;
alter table catcentrocostos alter column idcentrocostos set not null;
-- dmap_object_gen_tag : type : alter table name : catcentrocostos
set search_path = pppt,oracle,dmap_extension,public;
alter table catcentrocostos alter column centrocostos set not null;
-- dmap_object_gen_tag : type : alter table name : catcentrocostos
set search_path = pppt,oracle,dmap_extension,public;
alter table catcentrocostos alter column idseccion set not null;
-- dmap_object_gen_tag : type : alter table name : catcentrocostos
set search_path = pppt,oracle,dmap_extension,public;
alter table catcentrocostos alter column idempresa set not null;
