-- dmap_object_gen_tag : type : table name : xxlmk_users_overbook_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_users_overbook_tab"  (
id_user_overbook numeric(38) not null,
cve_usuario varchar(100),
ind_status numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_users_overbook_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_users_overbook_tab add primary key (id_user_overbook);
-- dmap_object_gen_tag : type : alter table name : xxlmk_users_overbook_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_users_overbook_tab alter column id_user_overbook set not null;
