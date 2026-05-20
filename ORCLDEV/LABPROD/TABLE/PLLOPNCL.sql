-- dmap_object_gen_tag : type : table name : pllopncl
set search_path = labprod,oracle,dmap_extension,public;
create table "pllopncl"  (
pcl_keymin varchar(5),
pcl_keypnl varchar(5),
pcl_keyhoj varchar(5),
pcl_keypcl varchar(10),
pcl_despcl varchar(20),
pcl_orden numeric(10),
pcl_origen varchar(1),
pcl_momppt varchar(1)
) ;
