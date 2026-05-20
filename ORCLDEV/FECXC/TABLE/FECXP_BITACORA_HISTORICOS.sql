-- dmap_object_gen_tag : type : table name : fecxp_bitacora_historicos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bitacora_historicos"  (
proceso_id numeric(38),
proceso_nombre varchar(255),
created_by varchar(255),
date_created timestamp(0),
id_version numeric(38) default (0),
desc_version varchar(255),
periodo numeric(38),
mes numeric(38),
comentario varchar(255),
tipo_operacion varchar(50)
) ;
