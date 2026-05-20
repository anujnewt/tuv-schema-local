-- dmap_object_gen_tag : type : index name : semanas_estimacion_idx
set search_path = feci,oracle,dmap_extension,public;
create index semanas_estimacion_idx on feci_semanas_estimacion_tab (num_anio, num_mes, ind_estado);
