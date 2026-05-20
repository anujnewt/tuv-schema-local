-- dmap_object_gen_tag : type : table name : xxmor_esquemas_factur_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_esquemas_factur_tab"  (
id_esquema numeric(15) not null,
codigo varchar(50) not null,
descripcion varchar(240),
activo varchar(1) default 'Y',
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_esquemas_factur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_esquemas_factur_tab add constraint xxmor_esquemas_factur_pk primary key (id_esquema);
-- dmap_object_gen_tag : type : alter table name : xxmor_esquemas_factur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_esquemas_factur_tab alter column id_esquema set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_esquemas_factur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_esquemas_factur_tab alter column codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_esquemas_factur_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_esquemas_factur_tab alter column created_date set not null;
