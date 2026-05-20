-- dmap_object_gen_tag : type : index name : moneda_idx
set search_path = feci,oracle,dmap_extension,public;
create index moneda_idx on feci_moneda_cat (cod_moneda, ind_estado);
