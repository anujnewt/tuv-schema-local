-- dmap_object_gen_tag : type : table name : pllopcel
set search_path = labconf,oracle,dmap_extension,public;
create table "pllopcel"  (
pce_keymin varchar(5),
pce_keypnl varchar(5),
pce_keyhoj varchar(5),
pce_keypcl varchar(10),
pce_keypcn varchar(10),
pce_formul varchar(800),
pce_fomato varchar(25),
pce_color varchar(1),
pce_natura varchar(1),
pce_stadel varchar(1)
) ;
