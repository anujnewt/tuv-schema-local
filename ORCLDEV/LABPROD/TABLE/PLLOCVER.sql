-- dmap_object_gen_tag : type : table name : pllocver
set search_path = labprod,oracle,dmap_extension,public;
create table "pllocver"  (
cve_keymin varchar(5),
cve_keyper numeric(10),
cve_keyver varchar(5),
cve_modcal varchar(4)
) ;
