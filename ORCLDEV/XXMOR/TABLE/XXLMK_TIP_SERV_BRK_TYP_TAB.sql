-- dmap_object_gen_tag : type : table name : xxlmk_tip_serv_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_tip_serv_brk_typ_tab"  (
id_tipo_servicio_psp numeric(38) not null,
des_break_type varchar(6) not null,
ind_prioridad numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tip_serv_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tip_serv_brk_typ_tab add primary key (id_tipo_servicio_psp,des_break_type);
-- dmap_object_gen_tag : type : alter table name : xxlmk_tip_serv_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tip_serv_brk_typ_tab alter column id_tipo_servicio_psp set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tip_serv_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tip_serv_brk_typ_tab alter column des_break_type set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_tip_serv_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_tip_serv_brk_typ_tab add constraint xxlmktipservbrktyptab_fk1 foreign key (id_tipo_servicio_psp) references xxlmk_tipos_serv_psp_tab(id_tipo_servicio_psp) on delete no action not deferrable initially immediate;
