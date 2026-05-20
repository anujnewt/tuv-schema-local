-- dmap_object_gen_tag : type : table name : inlohisc
set search_path = labprod,oracle,dmap_extension,public;
create table "inlohisc"  (
inh_keyemp numeric(5),
inh_rfcemp varchar(14),
inh_keypro numeric(5),
inh_keydep varchar(16),
inh_keypue varchar(16),
inh_keycur varchar(8),
inh_keygpo varchar(4),
inh_cosalm decimal(10, 2),
inh_evaalm decimal(5, 2),
inh_evacur decimal(5, 2),
inh_evains decimal(5, 2),
inh_cveapr varchar(6),
inh_tipasi varchar(6)
) ;
