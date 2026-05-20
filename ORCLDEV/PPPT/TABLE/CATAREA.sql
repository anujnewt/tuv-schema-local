-- dmap_object_gen_tag : type : table name : catarea
set search_path = pppt,oracle,dmap_extension,public;
create table "catarea"  (
idarea numeric(38) not null default 0,
area varchar(200),
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catarea
set search_path = pppt,oracle,dmap_extension,public;
alter table catarea alter column idarea set not null;
-- dmap_object_gen_tag : type : alter table name : catarea
set search_path = pppt,oracle,dmap_extension,public;
alter table catarea alter column idempresa set not null;
