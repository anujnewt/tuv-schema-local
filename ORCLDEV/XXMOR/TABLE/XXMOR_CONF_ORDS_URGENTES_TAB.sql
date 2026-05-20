-- dmap_object_gen_tag : type : table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_conf_ords_urgentes_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
dia numeric(1) not null,
dia_cierre numeric(1) not null,
hora_cierre timestamp(0) not null,
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_date timestamp(0),
updated_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab add constraint xxmor_conf_ords_urgentes_ta_pk primary key (id_seg_neg,id_fza_ventas,dia,dia_cierre);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab add constraint ckc_dia_cierre_xxmor_co check (dia_cierre between 1 and 7);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab add constraint ckc_dia_xxmor_co check (dia between 1 and 7);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column dia set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column dia_cierre set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column hora_cierre set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_ords_urgentes_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_ords_urgentes_tab add constraint fk_fza_vtas_ord_urg foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
