-- dmap_object_gen_tag : type : index name : feci_moneda_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_moneda_cod_idx on feci_moneda_cat (cod_moneda);
