-- dmap_object_gen_tag : type : table name : fucfdicomprobantepro
set search_path = labprod,oracle,dmap_extension,public;
create table "fucfdicomprobantepro"  (
idcomprobantepro numeric(38),
com_keypro numeric(38),
com_keyper varchar(7),
com_tipo varchar(1),
com_nomarc varchar(200),
com_regval numeric(38),
com_regenv numeric(38),
com_regtim numeric(38),
com_regerr numeric(38),
com_regcan numeric(38)
) ;
