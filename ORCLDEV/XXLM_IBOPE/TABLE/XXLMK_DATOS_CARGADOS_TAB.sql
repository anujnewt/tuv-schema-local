-- dmap_object_gen_tag : type : table name : xxlmk_datos_cargados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create table "xxlmk_datos_cargados_tab"  (
id_datos numeric not null,
fec_datos timestamp(0),
num_regs numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizado_por timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_datos_cargados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_datos_cargados_tab add primary key (id_datos);
-- dmap_object_gen_tag : type : alter table name : xxlmk_datos_cargados_tab
set search_path = xxlm_ibope,oracle,dmap_extension,public;
alter table xxlmk_datos_cargados_tab alter column id_datos set not null;
