-- dmap_object_gen_tag : type : index name : empresa_idx
set search_path = feci,oracle,dmap_extension,public;
create index empresa_idx on feci_empresa_cat (cod_empresa, ind_estado);
