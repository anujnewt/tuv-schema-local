-- dmap_object_gen_tag : type : table name : api_locpago
set search_path = labprod,oracle,dmap_extension,public;
create table "api_locpago"  (
id_transaccion varchar(30) not null,
loc_keyloc varchar(16) not null,
loc_desloc varchar(255) not null,
loc_domloc varchar(255),
loc_colloc varchar(255),
loc_ciuloc varchar(10),
loc_estloc varchar(10),
loc_codpos varchar(10),
loc_lardis varchar(10),
loc_teluno varchar(10),
loc_teldos varchar(10),
loc_teltre varchar(10),
loc_cvezon numeric,
loc_reggeo varchar(10),
loc_keyban varchar(255),
loc_keysuc varchar(10),
loc_ca1aux varchar(10),
loc_ca2aux varchar(10),
loc_ca3aux varchar(10),
loc_ca4aux varchar(10),
loc_ca5aux varchar(10),
loc_refcon varchar(10),
status varchar(40),
code varchar(150),
message varchar(150),
fecha timestamp(0),
fecha_insert timestamp(0),
fecha_proc timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : api_locpago
set search_path = labprod,oracle,dmap_extension,public;
alter table api_locpago alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_locpago
set search_path = labprod,oracle,dmap_extension,public;
alter table api_locpago alter column loc_keyloc set not null;
-- dmap_object_gen_tag : type : alter table name : api_locpago
set search_path = labprod,oracle,dmap_extension,public;
alter table api_locpago alter column loc_desloc set not null;
