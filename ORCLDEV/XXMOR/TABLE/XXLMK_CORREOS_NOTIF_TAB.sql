-- dmap_object_gen_tag : type : table name : xxlmk_correos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_correos_notif_tab"  (
id_correo_notif numeric not null,
id_grupo_notif numeric not null,
des_correo_notif varchar(200),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_notif_tab add primary key (id_correo_notif);
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_notif_tab alter column id_correo_notif set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_notif_tab alter column id_grupo_notif set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_correos_notif_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_correos_notif_tab add constraint xxlmk_correos_notif_tab_fk_01 foreign key (id_grupo_notif) references xxlmk_grupos_notif_tab(id_grupo_notif) on delete no action not deferrable initially immediate;
