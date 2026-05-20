-- dmap_object_gen_tag : type : table name : xxmor_log_errores_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_log_errores_tab"  (
id_error numeric not null,
desc_error varchar(4000),
archivo_error varchar(350),
metodo_error varchar(1000),
hora_error timestamp(0) default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_log_errores_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_errores_tab add constraint xxmor_log_errores_tab_pk primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxmor_log_errores_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_log_errores_tab alter column id_error set not null;
