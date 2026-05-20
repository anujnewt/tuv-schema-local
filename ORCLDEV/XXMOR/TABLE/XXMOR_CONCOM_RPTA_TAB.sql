-- dmap_object_gen_tag : type : table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_concom_rpta_tab"  (
id_solicitud numeric not null,
id_rpta_concom numeric not null,
resultadogeneral varchar(50),
trackingid varchar(50),
desc_concom varchar(128),
posicion_concom varchar(15),
id_concom varchar(250),
numlinea_concom varchar(20),
estatus_concom varchar(20),
campo_concom varchar(2000),
detalle_concom varchar(2000),
accion_concom varchar(50),
tiporegla_concom varchar(50),
estatus_orduni char(2),
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20) not null,
updated_date timestamp(0),
updated_by varchar(20),
id_seg_neg numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab add constraint xxmor_concom_rpta_tab_pk primary key (id_solicitud,created_date,created_by,id_rpta_concom);
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab alter column id_rpta_concom set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_concom_rpta_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_concom_rpta_tab add constraint fk_rpta_concom_soldet foreign key (id_solicitud) references xxmor_solicitudes_enc_tab(id_solicitud) on delete no action not deferrable initially immediate;
