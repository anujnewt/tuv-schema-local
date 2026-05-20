-- dmap_object_gen_tag : type : table name : xxlmk_targets_psp_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_targets_psp_lmk_tab"  (
id_target numeric(38) not null,
des_target_short varchar(100),
num_demog_lmk numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_targets_psp_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_targets_psp_lmk_tab add primary key (id_target);
