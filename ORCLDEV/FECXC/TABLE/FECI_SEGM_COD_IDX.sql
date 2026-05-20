-- dmap_object_gen_tag : type : index name : feci_segm_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_segm_cod_idx on feci_segmento_cat (cod_segmento);
