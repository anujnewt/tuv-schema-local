-- dmap_object_gen_tag : type : table name : pllovxen
set search_path = labprod,oracle,dmap_extension,public;
create table "pllovxen"  (
vxe_keyvar varchar(5),
vxe_keymin varchar(5),
vxe_keyest varchar(3),
vxe_keydep varchar(16),
vxe_keyper numeric(10),
vxe_keyver varchar(5),
vxe_valvar decimal(12, 6)
) ;
