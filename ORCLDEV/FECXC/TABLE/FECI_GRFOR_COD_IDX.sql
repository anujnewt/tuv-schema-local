-- dmap_object_gen_tag : type : index name : feci_grfor_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_grfor_cod_idx on feci_grupo_forecast_cat (cod_grupo_forecast);
