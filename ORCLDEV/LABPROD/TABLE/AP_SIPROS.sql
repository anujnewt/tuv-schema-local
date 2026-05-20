-- dmap_object_gen_tag : type : table name : ap_sipros
set search_path = labprod,oracle,dmap_extension,public;
create table "ap_sipros"  (
soi_keyemp numeric(38),
soi_keycon varchar(3),
soi_refere varchar(20),
soi_tipope varchar(1),
soi_import decimal(11, 2),
soi_fecope timestamp(0),
soi_tipmon varchar(1),
soi_tipcam decimal(11, 4),
soi_tipreg varchar(1),
soi_keypre decimal(16, 6),
soi_keypro numeric(38),
soi_status varchar(1),
soi_feccar timestamp(0),
soi_stacar varchar(1),
soi_refamo varchar(16),
soi_vennum varchar(30),
soi_vencod varchar(15)
) ;
