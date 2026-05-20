-- dmap_object_gen_tag : type : table name : nmcocper
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcocper"  (
cpe_keypro numeric(5),
cpe_perori varchar(7),
cpe_keyemp numeric(10),
cpe_pernue varchar(7),
cpe_keyinc decimal(16, 6),
cpe_keycon varchar(3),
cpe_cantid decimal(16, 6),
cpe_import decimal(12, 2),
cpe_status numeric(5),
cpe_fecreg timestamp(0),
cpe_horreg varchar(8),
cpe_keyusu numeric(10)
) ;
