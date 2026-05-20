-- dmap_object_gen_tag : type : table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_fzas_vtas_tab"  (
id_seg_neg numeric not null,
id_fza_ventas numeric not null,
ident_fza_ventas varchar(6),
nombre_fza_ventas varchar(50) not null,
region varchar(4),
copys_x_orden char(1),
copys_x_fecha char(1),
multifuerza char(1),
rtcrd_auth_aut char(1),
aut_x_correo char(1),
mercadotecnia char(1),
div_x_canal char(1),
condiciones_comerciales varchar(4000),
activa char(1),
notificacion_ext_int char(1),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp(),
updated_by varchar(20),
updated_date timestamp(0),
matloc char(2),
aut_tolerancia decimal(10, 2),
get_rate char(2),
matloc_null char(1),
matloc_busqueda varchar(2),
mkt_version_ws char(1) default '0',
esquema_factur varchar(50),
id_empresa_erp numeric(15),
empresa_erp varchar(240),
seg_neg_erp varchar(30),
respeta_canal varchar(1),
comp_empresa varchar(400),
por_iva numeric,
usar_buyunit_mkt varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab add constraint xxmor_fzas_vtas_tab_pk primary key (id_seg_neg,id_fza_ventas);
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab alter column id_seg_neg set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab alter column id_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab alter column nombre_fza_ventas set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_fzas_vtas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_fzas_vtas_tab add constraint fk_fzas_vtas_segm_neg foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
