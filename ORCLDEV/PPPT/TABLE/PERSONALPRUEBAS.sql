-- dmap_object_gen_tag : type : table name : personalpruebas
set search_path = pppt,oracle,dmap_extension,public;
create table "personalpruebas"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
fecha timestamp(0),
resultado numeric(38),
observaciones varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : personalpruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebas alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalpruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebas alter column idprueba set not null;
