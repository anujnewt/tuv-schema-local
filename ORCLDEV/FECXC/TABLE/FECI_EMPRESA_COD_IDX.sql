-- dmap_object_gen_tag : type : index name : feci_empresa_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_empresa_cod_idx on feci_empresa_cat (cod_empresa);
