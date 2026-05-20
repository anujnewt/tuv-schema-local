-- dmap_object_gen_tag : type : table name : co_personalestadistica
set search_path = pppt,oracle,dmap_extension,public;
create table "co_personalestadistica"  (
idpersonal numeric(38) not null,
anio numeric(38) not null,
valor1 numeric not null,
valor2 numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : co_personalestadistica
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalestadistica alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalestadistica
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalestadistica alter column anio set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalestadistica
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalestadistica alter column valor1 set not null;
-- dmap_object_gen_tag : type : alter table name : co_personalestadistica
set search_path = pppt,oracle,dmap_extension,public;
alter table co_personalestadistica alter column valor2 set not null;
