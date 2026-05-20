-- dmap_object_gen_tag : type : index name : clase_cliente_idx
set search_path = feci,oracle,dmap_extension,public;
create index clase_cliente_idx on feci_clase_cliente_cat (cod_clase_cliente, ind_estado);
