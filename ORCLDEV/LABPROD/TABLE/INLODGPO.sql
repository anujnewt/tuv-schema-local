-- dmap_object_gen_tag : type : table name : inlodgpo
set search_path = labprod,oracle,dmap_extension,public;
create table "inlodgpo"  (
dgp_keygpo numeric(5),
dgp_keycur varchar(8),
dgp_keyemp numeric(5),
dgp_rfcemp varchar(14),
dgp_tipasi varchar(6),
dgp_fecalt timestamp(0),
dgp_obseva varchar(1),
dgp_obscur varchar(1),
dgp_obsins varchar(1),
dgp_cveapr varchar(6),
dgp_status varchar(2),
dgp_fecsta timestamp(0)
) ;
