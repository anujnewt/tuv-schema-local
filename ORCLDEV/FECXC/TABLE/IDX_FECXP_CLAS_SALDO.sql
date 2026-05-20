-- dmap_object_gen_tag : type : index name : idx_fecxp_clas_saldo
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_clas_saldo on fecxp_clasificacion_fe (genera_saldo);
