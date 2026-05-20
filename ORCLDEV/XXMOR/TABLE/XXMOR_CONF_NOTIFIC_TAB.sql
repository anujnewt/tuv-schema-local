-- dmap_object_gen_tag : type : table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_conf_notific_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
id_notificacion numeric not null,
usuario_interno char(1),
usuario_agencia char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_date timestamp(0),
updated_by varchar(20),
usuario_factur char(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab add constraint xxmor_admon_notific_tab_pk primary key (id_seg_neg,id_fza_ventas,id_notificacion);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab alter column id_notificacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_notific_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_notific_tab add constraint "fk_fza_vtas_admn notif" foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
