-- dmap_object_gen_tag : type : table name : nmlolocp
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlolocp"  (
loc_keyloc varchar(16),
loc_desloc varchar(40),
loc_domloc varchar(36),
loc_colloc varchar(20),
loc_ciuloc varchar(6),
loc_estloc varchar(6),
loc_codpos varchar(6),
loc_lardis varchar(5),
loc_teluno varchar(10),
loc_teldos varchar(10),
loc_teltre varchar(10),
loc_cvezon numeric(5),
loc_reggeo varchar(10),
loc_keyban varchar(3),
loc_keysuc varchar(4),
loc_ca1aux varchar(10),
loc_ca2aux varchar(10),
loc_ca3aux varchar(10),
loc_ca4aux varchar(10),
loc_ca5aux varchar(10),
loc_refcon varchar(30)
) ;
