-- dmap_object_gen_tag : type : index name : operacion_idx
set search_path = feci,oracle,dmap_extension,public;
create index operacion_idx on feci_operacion_tab (cod_operacion, ind_estado);
