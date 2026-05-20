-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_ident_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
ident_fza_tipo char(1) not null,
ident_fza_val varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab add constraint xxmor_fzas_vtas_ident_tab_pk primary key (id_seg_neg,id_fza_ventas,ident_fza_tipo,ident_fza_val);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab alter column ident_fza_tipo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab alter column ident_fza_val set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_ident_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_ident_tab add constraint fk_identificadores_fza_vtas foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
