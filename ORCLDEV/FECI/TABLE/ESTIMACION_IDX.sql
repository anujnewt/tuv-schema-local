-- dmap_object_gen_tag : type : index name : estimacion_idx
set search_path = feci,oracle,dmap_extension,public;
create index estimacion_idx on feci_estimacion_tab (cod_segmento, cod_grupo_forecast, num_anio, num_semana);
