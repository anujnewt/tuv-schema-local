-- dmap_object_gen_tag : type : index name : segmento_idx
set search_path = feci,oracle,dmap_extension,public;
create index segmento_idx on feci_segmento_cat (cod_segmento, cod_moneda, ind_estado);
