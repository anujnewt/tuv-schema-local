-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_est_rep_tab"  (
id_solicitud numeric not null,
linea numeric not null,
id_sist numeric(3) not null,
estat_rep char(2),
estat_id_foraneo varchar(25),
estat_reintento numeric(2) default 0,
created_date timestamp(0) default statement_timestamp(),
updated_date timestamp(0),
rotid varchar(20),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
estat_error_msg varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab add constraint xxmor_solicitudes_est_rep_t_pk primary key (id_solicitud,linea,id_sist);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab alter column linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab alter column id_sist set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab add constraint fk_estatus_detalle foreign key (id_solicitud,linea) references xxmor_solicitudes_det_tab(id_solicitud,linea) on delete no action not deferrable initially immediate not valid;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab add constraint fk_estatus_enc foreign key (id_solicitud) references xxmor_solicitudes_enc_tab(id_solicitud) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_est_rep_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_est_rep_tab add constraint fk_estatus_fza_vtas_rep foreign key (id_sist) references xxmor_sistemas_finales_tab(id_sist) on delete no action not deferrable initially immediate;
