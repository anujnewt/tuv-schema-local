-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_arch_tab"  (
id_seg_neg numeric not null,
id_archivo_sol numeric not null,
archivo_sol bytea not null,
nom_archivo_sol varchar(150) not null,
archivo_procesado char(1),
envio_ws char(1),
created_date timestamp(0) default statement_timestamp(),
created_by varchar(20),
num_ordenes numeric(15),
observaciones varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab add constraint xxmor_arch_solicitudes_tab_pk primary key (id_seg_neg,id_archivo_sol);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab alter column id_archivo_sol set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab alter column archivo_sol set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab alter column nom_archivo_sol set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_arch_tab add constraint fk_arch_sol_seg_neg foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
