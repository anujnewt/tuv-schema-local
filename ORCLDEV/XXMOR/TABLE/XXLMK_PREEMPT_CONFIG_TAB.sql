-- dmap_object_gen_tag : type : table name : xxlmk_preempt_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_preempt_config_tab"  (
id_config numeric(38) not null,
id_tipo_servicio numeric not null,
num_preemptor_status numeric(38),
num_preemption_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_config_tab add primary key (id_config);
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_config_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_config_tab alter column id_tipo_servicio set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_config_tab add constraint xxlmkpreemptconfigtab_fk1 foreign key (id_tipo_servicio) references xxmor_cat_tipo_serv_tab(id_tipo_servicio) on delete no action not deferrable initially immediate;
