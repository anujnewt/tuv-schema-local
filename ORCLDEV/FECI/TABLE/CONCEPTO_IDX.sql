-- dmap_object_gen_tag : type : index name : concepto_idx
set search_path = feci,oracle,dmap_extension,public;
create index concepto_idx on feci_concepto_cat (cod_concepto, ind_estado);
