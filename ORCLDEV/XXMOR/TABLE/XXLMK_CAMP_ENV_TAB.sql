-- dmap_object_gen_tag : type : table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_camp_env_tab"  (
id_camp_env numeric not null,
id_ordhdr numeric not null,
num_camp numeric not null,
ind_estatus varchar(10),
des_tipo_servicio varchar(200),
"fec creacion" timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_aprov_key_id numeric(38),
num_deal numeric(38),
fec_ini_camp timestamp(0),
fec_fin_camp timestamp(0),
num_product numeric(38),
des_camp_req text,
val_rev_budget numeric,
val_budget_no_col numeric(38),
num_preemption_status numeric(38),
num_preemptor_status numeric(38),
num_user_preempts numeric(38),
ind_acciones_especiales numeric(38) default 0,
ind_non_preemptible numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab add constraint xxlmk_camp_env_tab_ix2 unique (num_camp);
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab add primary key (id_camp_env);
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab alter column id_camp_env set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab alter column num_camp set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_env_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_env_tab add constraint xxlmk_camp_env_tab_fk_01 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
