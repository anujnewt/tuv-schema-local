-- dmap_object_gen_tag : type : table name : xxmor_mapeo_campos_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_mapeo_campos_tab"  (
id_seg_neg numeric not null,
id_obj numeric not null,
desc_obj varchar(50),
texto_obj varchar(50),
visible_obj char(1),
editable_obj char(1),
url_obj varchar(250),
posicion_pantalla varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_mapeo_campos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_mapeo_campos_tab add constraint xxmor_mapeo_campos_tab_pk primary key (id_seg_neg,id_obj);
-- dmap_object_gen_tag : type : alter table name : xxmor_mapeo_campos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_mapeo_campos_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_mapeo_campos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_mapeo_campos_tab alter column id_obj set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_mapeo_campos_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_mapeo_campos_tab add constraint fk_map_campos_segm_neg foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
