-- dmap_object_gen_tag : type : table name : hhpersonalfechas
set search_path = pppt,oracle,dmap_extension,public;
create table "hhpersonalfechas"  (
idpersonal numeric(38) not null,
fecharegistro timestamp(0),
fechaupdate timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : hhpersonalfechas
set search_path = pppt,oracle,dmap_extension,public;
alter table hhpersonalfechas alter column idpersonal set not null;
