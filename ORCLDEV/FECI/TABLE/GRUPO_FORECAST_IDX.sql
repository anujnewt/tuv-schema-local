-- dmap_object_gen_tag : type : index name : grupo_forecast_idx
set search_path = feci,oracle,dmap_extension,public;
create index grupo_forecast_idx on feci_grupo_forecast_cat (cod_grupo_forecast, ind_estado);
