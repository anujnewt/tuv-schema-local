-- dmap_object_gen_tag : type : table name : personalpassword
set search_path = pppt,oracle,dmap_extension,public;
create table "personalpassword"  (
idprefijo numeric(38) not null,
folio numeric(38) not null,
"password" varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : personalpassword
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpassword alter column idprefijo set not null;
-- dmap_object_gen_tag : type : alter table name : personalpassword
set search_path = pppt,oracle,dmap_extension,public;
alter table personalpassword alter column folio set not null;
