-- dmap_object_gen_tag : type : table name : tvlosete
set search_path = labprod,oracle,dmap_extension,public;
create table "tvlosete"  (
enc_keylot varchar(15),
enc_keypro numeric(38),
enc_keyper varchar(7),
enc_keyban varchar(10),
enc_banpri varchar(1),
enc_ctapag varchar(20),
enc_tipemp varchar(1),
enc_numreg numeric(10),
enc_import decimal(16, 2),
enc_status varchar(1),
enc_fecgen timestamp(0),
enc_horgen varchar(8),
enc_keyusu numeric(10),
enc_feclib timestamp(0),
enc_horlib varchar(8),
enc_usulib numeric(10),
enc_fecdep timestamp(0),
enc_fecapl timestamp(0)
) ;
