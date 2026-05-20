-- dmap_object_gen_tag : type : table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_conf_ord_urg_tab"  (
id_conf numeric(38) not null,
id_seg_neg numeric(38),
id_fza_vtas numeric(38),
num_dia numeric(38),
num_dia_cierre numeric(38),
num_hora_cierre numeric(38),
num_minuto_cierre numeric(38),
fec_creacion timestamp(0) not null,
cve_creado_por varchar(100) not null,
fec_actualizacion timestamp(0) not null,
cve_actualizado_por varchar(100) not null,
ind_tipo_orden numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab add primary key (id_conf);
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab alter column id_conf set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab alter column cve_creado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab alter column fec_actualizacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_conf_ord_urg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_conf_ord_urg_tab alter column cve_actualizado_por set not null;
