-- dmap_object_gen_tag : type : index name : fecxp_forecast_h02
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_forecast_h02 on fecxp_forecast_h (periodo, mes, moneda);
