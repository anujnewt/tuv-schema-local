-- dmap_object_gen_tag : type : table name : plloinfo
set search_path = labconf,oracle,dmap_extension,public;
create table "plloinfo"  (
inf_keymin varchar(5),
inf_keyest varchar(3),
inf_keydep varchar(18),
inf_keylib varchar(5),
inf_keyhoj varchar(5),
inf_keycon varchar(10),
inf_keycol varchar(10),
inf_keyper numeric(10),
inf_keyver varchar(5),
inf_valinf decimal(18, 2),
inf_status varchar(2)
) ;
