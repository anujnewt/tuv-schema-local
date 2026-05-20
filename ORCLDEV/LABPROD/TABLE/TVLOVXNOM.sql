-- dmap_object_gen_tag : type : table name : tvlovxnom
set search_path = labprod,oracle,dmap_extension,public;
create table "tvlovxnom"  (
vxn_keynom numeric(9) not null,
vxn_keyver numeric(9) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvlovxnom
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlovxnom alter column vxn_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : tvlovxnom
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlovxnom alter column vxn_keyver set not null;
