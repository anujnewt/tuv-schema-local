-- dmap_object_gen_tag : type : table name : xxlmk_razons_cancel_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_razons_cancel_spt_tab"  (
id_razon_cancel numeric(38) not null,
des_razon_cancel varchar(200),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_razons_cancel_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_razons_cancel_spt_tab add primary key (id_razon_cancel);
-- dmap_object_gen_tag : type : alter table name : xxlmk_razons_cancel_spt_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_razons_cancel_spt_tab alter column id_razon_cancel set not null;
