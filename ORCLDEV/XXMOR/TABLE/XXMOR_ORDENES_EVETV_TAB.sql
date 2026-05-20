-- dmap_object_gen_tag : type : table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_ordenes_evetv_tab"  (
id_orden numeric not null,
des_fuerza_ventas varchar(100),
num_orden numeric not null,
ind_proc_por_linea varchar(5),
ind_garantizado varchar(5),
ind_apo_rep varchar(5),
cve_cliente varchar(100) not null,
des_cps_mcontract varchar(100),
des_email_resp varchar(100),
des_ref_folio varchar(100),
cve_enc_cli_agencia varchar(100),
des_marca varchar(100),
nom_tarifa varchar(100),
des_comentarios varchar(500),
ind_canal_x_ord varchar(5),
des_cat_prod varchar(100),
can_total_spots numeric,
val_total_ord_sd numeric,
val_total_ord_cd numeric,
nom_dir_merca varchar(100),
ind_tipo_factur varchar(100),
des_target varchar(100),
fec_inicio timestamp(0),
fec_fin timestamp(0),
val_total_orden numeric not null,
des_seg_neg varchar(100),
ind_estatus varchar(2),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
ind_rechazo_gestor char(2),
id_motivo_ar_cc numeric,
des_coment_ar_cc varchar(500),
num_carga numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_evetv_tab add primary key (id_orden);
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_evetv_tab alter column id_orden set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_evetv_tab alter column num_orden set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_evetv_tab alter column cve_cliente set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_ordenes_evetv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_ordenes_evetv_tab alter column val_total_orden set not null;
