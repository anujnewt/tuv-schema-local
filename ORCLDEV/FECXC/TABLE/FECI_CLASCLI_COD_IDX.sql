-- dmap_object_gen_tag : type : index name : feci_clascli_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_clascli_cod_idx on feci_clase_cliente_cat (cod_clase_cliente);
