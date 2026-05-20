-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_canales_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
stnid_padre varchar(10) not null,
stnid_hijo varchar(10) not null,
stnid_porcentaje decimal(5, 2) not null,
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_date timestamp(0),
updated_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab add constraint xxmor_fzas_vtas_canales_tab_pk primary key (id_seg_neg,id_fza_ventas,stnid_padre,stnid_hijo);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column stnid_padre set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column stnid_hijo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column stnid_porcentaje set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_canales_tab add constraint fk_fza_vtas_canales_fza_vtas foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
