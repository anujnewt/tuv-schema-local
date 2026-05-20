-- dmap_object_gen_tag : type : table name : personalpruebapermiso
set search_path = pppt,oracle,dmap_extension,public;
create table "personalpruebapermiso"  (
idpersonal numeric(38) not null,
idprueba numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : personalpruebapermiso
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebapermiso alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalpruebapermiso
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpruebapermiso alter column idprueba set not null;
