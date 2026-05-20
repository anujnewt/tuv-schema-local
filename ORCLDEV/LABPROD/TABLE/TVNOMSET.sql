-- dmap_object_gen_tag : type : table name : tvnomset
set search_path = labprod,oracle,dmap_extension,public;
create table "tvnomset"  (
mse_keylot varchar(15),
mse_keypro numeric(38),
mse_keyper varchar(7),
mse_keyemp numeric(38),
mse_nomemp varchar(120),
mse_cvebco varchar(5),
mse_ctaemp varchar(18),
mse_import decimal(16, 2),
mse_ctapag varchar(18),
mse_fecdep timestamp(0),
mse_cvecia varchar(4),
mse_descia varchar(60),
mse_status varchar(1),
mse_fecgen timestamp(0),
mse_horgen varchar(8),
mse_dayset varchar(12),
mse_bcosel varchar(10),
mse_tipemp varchar(1),
mse_auxca1 varchar(60),
mse_auxca2 varchar(60),
mse_auxnu1 numeric(38),
mse_auxnu2 numeric(38)
) ;
