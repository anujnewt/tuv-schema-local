-- dmap_object_gen_tag : type : index name : feci_pais_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_pais_cod_idx on feci_pais_cat (cod_pais);
