-- dmap_object_gen_tag : type : table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_recol_spots_ctrl_tab"  (
id_spot numeric(38) not null,
num_spot numeric(38) not null,
num_sched_time_orig varchar(10),
ind_status_lmk_orig varchar(2),
ind_estatus_mov numeric(38),
id_razon_cancel numeric(38),
ind_cambio_status numeric(38),
ind_num_movs numeric(38),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_ctrl_tab add primary key (id_spot);
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_ctrl_tab alter column id_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_ctrl_tab alter column num_spot set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_ctrl_tab add constraint xxlmkrecolspotsctrltab_fk1 foreign key (id_razon_cancel) references xxlmk_razons_cancel_spt_tab(id_razon_cancel) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_recol_spots_ctrl_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_recol_spots_ctrl_tab add constraint xxlmkrecolspotsctrltab_fk2 foreign key (id_spot) references xxlmk_lineas_spots_tab(id_spot) on delete no action not deferrable initially immediate;
