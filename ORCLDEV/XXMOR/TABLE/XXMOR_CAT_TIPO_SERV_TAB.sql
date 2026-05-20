-- dmap_object_gen_tag : type : table name : xxmor_cat_tipo_serv_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_cat_tipo_serv_tab"  (
id_tipo_servicio numeric not null,
desc_tipo_servicio varchar(200) not null,
spt_chr varchar(2),
usr_chr varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_tipo_serv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_tipo_serv_tab add constraint xxmor_cat_tipo_serv_tab_pk primary key (id_tipo_servicio);
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_tipo_serv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_tipo_serv_tab alter column id_tipo_servicio set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_tipo_serv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_tipo_serv_tab alter column desc_tipo_servicio set not null;
