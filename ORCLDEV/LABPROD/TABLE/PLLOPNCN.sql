-- dmap_object_gen_tag : type : table name : pllopncn
set search_path = labprod,oracle,dmap_extension,public;
create table "pllopncn"  (
pcn_keymin varchar(5),
pcn_keypnl varchar(5),
pcn_keyhoj varchar(5),
pcn_keypcn varchar(10),
pcn_despcn varchar(40),
pcn_orden numeric(10),
pcn_origen varchar(1)
) ;
