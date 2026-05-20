-- dmap_object_gen_tag : type : table name : molodcal
set search_path = labconf,oracle,dmap_extension,public;
create table "molodcal"  (
dca_dborig numeric(5),
dca_dboper numeric(5),
dca_keycal numeric(5),
dca_fecdia timestamp(0),
dca_tipdia varchar(3),
dca_tabcam varchar(20),
dca_valor varchar(16)
) ;
