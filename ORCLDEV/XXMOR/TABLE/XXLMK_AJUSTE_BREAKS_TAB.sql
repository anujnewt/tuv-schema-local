-- dmap_object_gen_tag : type : table name : xxlmk_ajuste_breaks_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ajuste_breaks_tab"  (
id_ajuste_breaks numeric(38) not null,
fec_inicio timestamp(0),
fec_fin timestamp(0),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_estatus numeric(38),
des_estatus varchar(1000),
ind_rep_only numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajuste_breaks_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajuste_breaks_tab add primary key (id_ajuste_breaks);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajuste_breaks_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajuste_breaks_tab alter column id_ajuste_breaks set not null;
