-- dmap_object_gen_tag : type : table name : comparacion
set search_path = pppt,oracle,dmap_extension,public;
create table "comparacion"  (
idcomparacion numeric(38) not null default 0,
npuestos numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : comparacion
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacion alter column idcomparacion set not null;
