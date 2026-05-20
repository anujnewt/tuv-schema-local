-- dmap_object_gen_tag : type : table name : pppempresaprueba
set search_path = pppt,oracle,dmap_extension,public;
create table "pppempresaprueba"  (
idempresa numeric(38) not null,
idprueba numeric(38) not null,
activa numeric(1) default 1
) ;
-- dmap_object_gen_tag : type : alter table name : pppempresaprueba
set search_path = pppt,oracle,dmap_extension,public;
alter table pppempresaprueba alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : pppempresaprueba
set search_path = pppt,oracle,dmap_extension,public;
alter table pppempresaprueba alter column idprueba set not null;
