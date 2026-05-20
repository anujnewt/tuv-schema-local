-- dmap_object_gen_tag : type : table name : xxmor_ejecuciones_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_ejecuciones_prog_tab"  (
id_ejecucion numeric not null,
nombre_proceso varchar(50),
hora_ini_ejecucion timestamp(0) default statement_timestamp(),
status_ejecucion char(1),
hoa_fin_ejecucion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_ejecuciones_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ejecuciones_prog_tab add constraint xxmor_ejecuciones_prog_tab_pk primary key (id_ejecucion);
-- dmap_object_gen_tag : type : alter table name : xxmor_ejecuciones_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ejecuciones_prog_tab alter column id_ejecucion set not null;
