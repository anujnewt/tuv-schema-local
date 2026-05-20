-- dmap_object_gen_tag : type : table name : inlohigr
set search_path = labconf,oracle,dmap_extension,public;
create table "inlohigr"  (
hig_keycur varchar(8),
hig_keygpo numeric(5),
hig_durcur varchar(5),
hig_fecini timestamp(0),
hig_fecfin timestamp(0),
hig_tipfte varchar(1),
hig_rfcfte varchar(14),
hig_evains decimal(5, 2),
hig_coscur decimal(10, 2),
hig_status varchar(2)
) ;
