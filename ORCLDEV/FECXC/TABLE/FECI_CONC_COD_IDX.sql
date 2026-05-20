-- dmap_object_gen_tag : type : index name : feci_conc_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_conc_cod_idx on feci_concepto_cat (cod_concepto);
