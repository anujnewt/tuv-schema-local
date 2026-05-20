-- dmap_object_gen_tag : type : table name : sexo
set search_path = pppt,oracle,dmap_extension,public;
create table "sexo"  (
idsexo numeric(38) not null,
sexo varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : sexo
set search_path = pppt,oracle,dmap_extension,public;
alter table sexo alter column idsexo set not null;
