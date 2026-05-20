-- dmap_object_gen_tag : type : table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_motivos_aut_rech_tab"  (
id_motivo numeric(15) not null,
descripcion varchar(240) not null,
tipo varchar(1) not null,
estatus varchar(1) not null,
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab add constraint xxmor_motivos_aut_rech_pk primary key (id_motivo);
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab alter column id_motivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab alter column estatus set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_motivos_aut_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_motivos_aut_rech_tab alter column created_date set not null;
