-- dmap_object_gen_tag : type : table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_errores_lectura_arch_tab"  (
id_error numeric(15) not null,
id_archivo numeric(15) not null,
cod_tipo_archivo varchar(10) not null,
nom_orden varchar(35),
cve_posicion varchar(1) not null,
num_linea numeric(38),
des_aux1 varchar(240),
des_aux2 varchar(240),
des_aux3 varchar(240),
des_aux4 varchar(240),
des_aux5 varchar(240),
fec_creacion timestamp(0) not null default statement_timestamp(),
cve_creado_por varchar(20),
fec_actualizacion timestamp(0) not null default statement_timestamp(),
cve_actualizado_por varchar(20),
des_error varchar(4000) not null default '0'
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab add constraint xxmor_errores_lectura_pk primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column id_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column cod_tipo_archivo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column cve_posicion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column fec_actualizacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_errores_lectura_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_errores_lectura_arch_tab alter column des_error set not null;
