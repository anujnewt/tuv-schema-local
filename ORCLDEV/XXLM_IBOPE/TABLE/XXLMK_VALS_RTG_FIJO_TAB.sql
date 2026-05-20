-- dmap_object_gen_tag : type : table name : xxlmk_vals_rtg_fijo_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_vals_rtg_fijo_tab"  (
des_target varchar(200),
des_canal varchar(200),
num_year numeric(38),
num_month numeric(38),
des_franja_ini varchar(10),
des_franja_fin varchar(10),
num_ratings numeric,
num_unis numeric,
des_plataforma varchar(2),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
