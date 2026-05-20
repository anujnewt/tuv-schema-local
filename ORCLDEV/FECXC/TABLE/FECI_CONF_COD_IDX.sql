-- dmap_object_gen_tag : type : index name : feci_conf_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_conf_cod_idx on feci_configuracion_cat (cod_configuracion);
