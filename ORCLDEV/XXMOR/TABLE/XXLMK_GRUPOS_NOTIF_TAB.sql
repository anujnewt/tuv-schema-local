-- dmap_object_gen_tag : type : table name : xxlmk_grupos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_grupos_notif_tab"  (
id_grupo_notif numeric not null,
nom_grupo varchar(200),
ind_tipo varchar(20),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grupos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grupos_notif_tab add primary key (id_grupo_notif);
-- dmap_object_gen_tag : type : alter table name : xxlmk_grupos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grupos_notif_tab alter column id_grupo_notif set not null;
