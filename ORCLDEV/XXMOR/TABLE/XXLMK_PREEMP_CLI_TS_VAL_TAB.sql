-- dmap_object_gen_tag : type : table name : xxlmk_preemp_cli_ts_val_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_preemp_cli_ts_val_tab"  (
id_preemp_cli_val numeric(38) not null,
business_type varchar(200),
fec_creacion timestamp(0) default statement_timestamp(),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0) default statement_timestamp(),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_preemp_cli_ts_val_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_preemp_cli_ts_val_tab alter column id_preemp_cli_val set not null;
