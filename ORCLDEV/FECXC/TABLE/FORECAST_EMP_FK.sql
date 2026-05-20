-- dmap_object_gen_tag : type : index name : forecast_emp_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index forecast_emp_fk on fecxp_rep_forecast (e_codigo);
