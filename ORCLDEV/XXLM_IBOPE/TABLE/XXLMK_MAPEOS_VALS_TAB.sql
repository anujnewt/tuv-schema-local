-- dmap_object_gen_tag : type : table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_mapeos_vals_tab"  (
id_mapeo_val numeric not null,
id_mapeo_fk numeric,
des_ibope varchar(200) not null,
des_landmark varchar(200) not null,
ind_orden numeric,
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100) not null,
num_ibope_ws numeric(38),
cve_plataforma varchar(5),
ind_tipo_arch numeric(38),
ind_targ_spoteo numeric(38),
ind_rating_fijo numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab add primary key (id_mapeo_val);
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab alter column id_mapeo_val set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab alter column des_ibope set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab alter column des_landmark set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_mapeos_vals_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_mapeos_vals_tab alter column cve_actualizado_por set not null;
