-- dmap_object_gen_tag : type : table name : xxlmk_tipos_serv_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_tipos_serv_psp_tab"  (
id_tipo_servicio_psp numeric not null,
id_tipo_servicio numeric not null,
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_inc_br_evesp_tm numeric(38),
num_business_type numeric(38),
ind_acciones_esp numeric(38),
ind_enviar_fmt_asig numeric(38),
ind_business_primary numeric(38),
nom_business_type varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tipos_serv_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tipos_serv_psp_tab add primary key (id_tipo_servicio_psp);
-- dmap_object_gen_tag : type : alter table name : xxlmk_tipos_serv_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tipos_serv_psp_tab alter column id_tipo_servicio_psp set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tipos_serv_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tipos_serv_psp_tab alter column id_tipo_servicio set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tipos_serv_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tipos_serv_psp_tab add constraint xxlmk_tipos_serv_psp_fk_01 foreign key (id_tipo_servicio) references xxmor_cat_tipo_serv_tab(id_tipo_servicio) on delete no action not deferrable initially immediate;
