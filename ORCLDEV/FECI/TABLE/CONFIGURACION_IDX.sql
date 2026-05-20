-- dmap_object_gen_tag : type : index name : configuracion_idx
set search_path = feci,oracle,dmap_extension,public;
create index configuracion_idx on feci_configuracion_cat (cod_configuracion, ind_estado);
