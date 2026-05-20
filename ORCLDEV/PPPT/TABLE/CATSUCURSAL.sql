-- dmap_object_gen_tag : type : table name : catsucursal
set search_path = pppt,oracle,dmap_extension,public;
create table "catsucursal"  (
idsucursal numeric(38) not null default 0,
sucursal varchar(100),
idexterno numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : catsucursal
set search_path = pppt,oracle,dmap_extension,public;
alter table catsucursal alter column idsucursal set not null;
-- dmap_object_gen_tag : type : alter table name : catsucursal
set search_path = pppt,oracle,dmap_extension,public;
alter table catsucursal alter column idexterno set not null;
