-- dmap_object_gen_tag : type : table name : personalinactivo
set search_path = pppt,oracle,dmap_extension,public;
create table "personalinactivo"  (
idpersonal numeric(38) not null,
fecha timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : personalinactivo
set search_path = pppt,oracle,dmap_extension,public;
alter table personalinactivo alter column idpersonal set not null;
