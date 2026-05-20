-- dmap_object_gen_tag : type : table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_conf_tipo_srv_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
id_tipo_servicio numeric not null,
inclusion numeric(1),
sptchr varchar(2),
usrchr varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_tipo_srv_tab add constraint xxmor_conf_tipo_srv_tab_pk primary key (id_seg_neg,id_fza_ventas,id_tipo_servicio);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_tipo_srv_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_tipo_srv_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_tipo_srv_tab alter column id_tipo_servicio set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_tipo_srv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_tipo_srv_tab add constraint fk_fza_vtas_tipo_serv foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
