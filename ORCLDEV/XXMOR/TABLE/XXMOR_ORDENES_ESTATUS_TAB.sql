-- dmap_object_gen_tag : type : table name : xxmor_ordenes_estatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_ordenes_estatus_tab"  (
id_notificacion numeric not null,
desc_notificacion varchar(100),
id_seg_neg numeric not null,
tipo_estatus char(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_estatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_estatus_tab add constraint xxmor_ordenes_estatus_tab_pk primary key (id_seg_neg,id_notificacion);
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_estatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_estatus_tab alter column id_notificacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_estatus_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_estatus_tab alter column id_seg_neg set not null;
