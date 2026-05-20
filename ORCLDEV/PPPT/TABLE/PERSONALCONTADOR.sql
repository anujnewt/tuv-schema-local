-- dmap_object_gen_tag : type : table name : personalcontador
set search_path = pppt,oracle,dmap_extension,public;
create table "personalcontador"  (
id numeric(38) not null,
contador numeric(38),
incremento numeric(38),
crc varchar(25),
fecha timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : personalcontador
set search_path = pppt,oracle,dmap_extension,public;
alter table personalcontador alter column id set not null;
