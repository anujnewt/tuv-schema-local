-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_usuarios_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
id_user varchar(20) not null,
administrador char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_by varchar(20),
updated_date timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab add constraint xxmor_fzas_vtas_usuarios_ta_pk primary key (id_seg_neg,id_fza_ventas,id_user);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab alter column id_user set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_usuarios_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_usuarios_tab add constraint fk_fza_vtas_usuarios_fza_vtas foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
