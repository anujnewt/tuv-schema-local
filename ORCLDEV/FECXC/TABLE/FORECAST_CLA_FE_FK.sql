-- dmap_object_gen_tag : type : index name : forecast_cla_fe_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index forecast_cla_fe_fk on fecxp_rep_forecast (cla_fe_id);
