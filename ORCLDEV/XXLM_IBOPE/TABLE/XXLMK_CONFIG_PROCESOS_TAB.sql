-- dmap_object_gen_tag : type : table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_config_procesos_tab"  (
id_config numeric not null,
id_proceso numeric not null,
num_hora_ejec numeric not null,
num_minunto_ejec numeric not null,
num_ejec_cada numeric not null,
des_ejec_dias varchar(100),
nom_config varchar(100) not null,
des_config varchar(1000),
ind_estatus numeric default 0,
ind_time_unit numeric not null,
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab add primary key (id_config);
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column id_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column num_hora_ejec set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column num_minunto_ejec set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column num_ejec_cada set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column nom_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column ind_time_unit set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab alter column cve_actualizado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_procesos_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_config_procesos_tab add constraint xxlmk_config_procesos_tab_fk1 foreign key (id_proceso) references xxlmk_procesos_tab(id_proceso) on delete no action not deferrable initially immediate;
