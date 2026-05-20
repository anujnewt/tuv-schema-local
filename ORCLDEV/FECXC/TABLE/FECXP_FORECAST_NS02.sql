-- dmap_object_gen_tag : type : index name : fecxp_forecast_ns02
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_forecast_ns02 on fecxp_forecast_ns (periodo, mes, moneda);
