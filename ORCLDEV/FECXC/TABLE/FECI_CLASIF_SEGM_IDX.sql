-- dmap_object_gen_tag : type : index name : feci_clasif_segm_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_clasif_segm_idx on feci_clasificacion_tab (cod_segmento, cod_grupo_forecast);
