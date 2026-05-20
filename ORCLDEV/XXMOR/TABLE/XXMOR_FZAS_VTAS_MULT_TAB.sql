-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_mult_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
id_seg_neg_hijo numeric,
id_fza_ventas_hija numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_mult_tab add constraint xxmor_fzas_vtas_mult_tab_pk primary key (id_seg_neg,id_fza_ventas);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_mult_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_mult_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_mult_tab add constraint fk_fza_ventas_mult foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_mult_tab add constraint fk_fzas_ventas_mult_2 foreign key (id_seg_neg_hijo,id_fza_ventas_hija) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
