-- dmap_object_gen_tag : type : table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_log_movimientos_tab"  (
id_seg_neg numeric,
id_solicitud numeric,
id_log_movimiento numeric not null,
nom_tabla varchar(50) not null,
nom_campo varchar(50) not null,
valor_antiguo varchar(1000),
valor_nuevo varchar(1000),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab add constraint xxmor_log_movimientos_tab_pk primary key (id_log_movimiento);
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab alter column id_log_movimiento set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab alter column nom_tabla set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab alter column nom_campo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab add constraint fk_xxmor_lo_fk_log_ca_xxmor_so foreign key (id_solicitud) references xxmor_solicitudes_enc_tab(id_solicitud) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_movimientos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_movimientos_tab add constraint fk_xxmor_lo_fk_log_mo_xxmor_se foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
