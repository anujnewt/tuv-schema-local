-- dmap_object_gen_tag : type : index name : fecxp_imprtacn_datos_hist02_r
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_imprtacn_datos_hist02_r on fecxp_importacion_datos_hist_r (tipo_importacion);
