-- dmap_object_gen_tag : type : table name : catempresa360
set search_path = pppt,oracle,dmap_extension,public;
create table "catempresa360"  (
idempresa numeric(38) not null default 0,
nombre varchar(100),
mision varchar(4000),
vision varchar(4000),
valores varchar(4000),
objetivos varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : catempresa360
set search_path = pppt,oracle,dmap_extension,public;
alter table catempresa360 alter column idempresa set not null;
