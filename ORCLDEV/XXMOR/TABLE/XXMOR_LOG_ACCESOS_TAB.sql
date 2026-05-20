-- dmap_object_gen_tag : type : table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_log_accesos_tab"  (
id_log_acceso numeric not null,
id_seg_neg numeric,
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_accesos_tab add constraint xxmor_log_accesos_tab_pk primary key (id_log_acceso);
-- dmap_object_gen_tag : type : alter table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_accesos_tab alter column id_log_acceso set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_accesos_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_accesos_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_accesos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_accesos_tab add constraint fk_xxmor_lo_fk_log_ac_xxmor_se foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
