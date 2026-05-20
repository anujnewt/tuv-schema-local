-- dmap_object_gen_tag : type : table name : personalpruebaho
set search_path = pppt,oracle,dmap_extension,public;
create table "personalpruebaho"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null,
resultado numeric(38),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : personalpruebaho
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebaho alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalpruebaho
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebaho alter column idprueba set not null;
