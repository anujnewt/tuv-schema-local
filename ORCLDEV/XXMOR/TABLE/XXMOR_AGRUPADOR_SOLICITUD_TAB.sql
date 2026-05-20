-- dmap_object_gen_tag : type : table name : xxmor_agrupador_solicitud_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_agrupador_solicitud_tab"  (
id_solicitud numeric(15) not null,
agrupador varchar(10) not null,
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_agrupador_solicitud_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_agrupador_solicitud_tab add constraint xxmor_agrupador_sol_pk primary key (id_solicitud,agrupador);
-- dmap_object_gen_tag : type : alter table name : xxmor_agrupador_solicitud_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_agrupador_solicitud_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_agrupador_solicitud_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_agrupador_solicitud_tab alter column agrupador set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_agrupador_solicitud_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_agrupador_solicitud_tab alter column created_date set not null;
