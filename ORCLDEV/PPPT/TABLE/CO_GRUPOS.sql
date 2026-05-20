-- dmap_object_gen_tag : type : table name : co_grupos
set search_path = pppt,oracle,dmap_extension,public;
create table "co_grupos"  (
idgrupo numeric(38) not null,
grupo varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : co_grupos
set search_path = pppt,oracle,dmap_extension,public;
alter table co_grupos alter column idgrupo set not null;
