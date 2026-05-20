-- dmap_object_gen_tag : type : index name : feci_regn_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_regn_cod_idx on feci_region_cat (cod_region);
