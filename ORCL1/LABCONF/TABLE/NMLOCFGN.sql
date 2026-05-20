-- dmap_object_gen_tag : type : table name : nmlocfgn
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlocfgn"  (
cfg_keycfg varchar(5),
cfg_keycia varchar(2),
cfg_keypro numeric(10),
cfg_descfg varchar(30),
cfg_keynom numeric(5),
cfg_tablat varchar(2),
cfg_fecreg timestamp(0),
cfg_fecact timestamp(0)
) ;
