-- dmap_object_gen_tag : type : table name : xxlmk_agrupadores_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_agrupadores_psp_tab"  (
id_agrupador_psp numeric not null,
nom_agrupador varchar(20) not null,
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_agrupadores_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agrupadores_psp_tab add primary key (id_agrupador_psp);
-- dmap_object_gen_tag : type : alter table name : xxlmk_agrupadores_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agrupadores_psp_tab alter column id_agrupador_psp set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_agrupadores_psp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agrupadores_psp_tab alter column nom_agrupador set not null;
