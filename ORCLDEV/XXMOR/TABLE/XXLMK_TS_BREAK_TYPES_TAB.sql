-- dmap_object_gen_tag : type : table name : xxlmk_ts_break_types_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ts_break_types_tab"  (
id_ts_break_type numeric(38) not null,
des_tipo_servicio varchar(200),
cve_break_type varchar(4),
num_business_type numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_ignora_aut_tm numeric(38),
num_int_breaks numeric(38),
ind_varios_ts numeric(38),
ind_preemptor numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ts_break_types_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ts_break_types_tab add primary key (id_ts_break_type);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ts_break_types_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ts_break_types_tab alter column id_ts_break_type set not null;
