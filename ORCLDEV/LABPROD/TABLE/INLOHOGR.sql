-- dmap_object_gen_tag : type : table name : inlohogr
set search_path = labprod,oracle,dmap_extension,public;
create table "inlohogr"  (
hog_keygpo numeric(5),
hog_keycur varchar(8),
hog_keylug varchar(8),
hog_fecdia timestamp(0),
hog_horini varchar(5),
hog_horfin varchar(5),
hog_status varchar(1),
hog_fecsta timestamp(0)
) ;
