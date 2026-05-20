-- dmap_object_gen_tag : type : table name : fecxp_det_cont_version_fe
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_det_cont_version_fe"  (
proceso varchar(100) default ('X'),
version_fe numeric(38) default (0),
fecha_actualizacion timestamp(0) default (statement_timestamp())
) ;
