-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_sistemas_tab"  (
id_sist numeric(3) not null,
id_seg_neg numeric not null,
id_fza_ventas numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab add constraint xxmor_fzas_vtas_sistemas_ta_pk primary key (id_seg_neg,id_sist,id_fza_ventas);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab alter column id_sist set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab add constraint fk_fza_vtas_sistemas foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_sistemas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_sistemas_tab add constraint fk_sistemas_fza_vtas foreign key (id_sist) references xxmor_sistemas_finales_tab(id_sist) on delete no action not deferrable initially immediate;
