-- dmap_object_gen_tag : type : index name : pais_idx
set search_path = feci,oracle,dmap_extension,public;
create index pais_idx on feci_pais_cat (cod_pais, ind_estado);
