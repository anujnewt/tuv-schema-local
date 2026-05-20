-- dmap_object_gen_tag : type : table name : co_caracteristica
set search_path = pppt,oracle,dmap_extension,public;
create table "co_caracteristica"  (
idcaracteristica numeric(38) not null,
caracteristica varchar(100),
descripcion varchar(100),
idgrupo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : co_caracteristica
set search_path = pppt,oracle,dmap_extension,public;
alter table co_caracteristica alter column idcaracteristica set not null;
