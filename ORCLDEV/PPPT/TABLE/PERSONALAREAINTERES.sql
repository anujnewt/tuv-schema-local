-- dmap_object_gen_tag : type : table name : personalareainteres
set search_path = pppt,oracle,dmap_extension,public;
create table "personalareainteres"  (
idpersonal numeric(38) not null,
idareainteres numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : personalareainteres
set search_path = pppt,oracle,dmap_extension,public;
alter table personalareainteres alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalareainteres
set search_path = pppt,oracle,dmap_extension,public;
alter table personalareainteres alter column idareainteres set not null;
