-- dmap_object_gen_tag : type : table name : xxlmk_preempt_cli_conf_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_preempt_cli_conf_tab"  (
id_config numeric(38) not null,
nom_cliente varchar(10) not null,
des_tipo_compra varchar(100),
num_preemptor_status numeric(38),
num_preemption_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_non_preemptible numeric(38) default 0,
num_plat numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_cli_conf_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_cli_conf_tab add primary key (id_config);
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_cli_conf_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_cli_conf_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preempt_cli_conf_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preempt_cli_conf_tab alter column nom_cliente set not null;
