-- dmap_object_gen_tag : type : table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usuario_correo_tab"  (
id_usuario_correo_pk numeric not null,
nom_usuario_correo varchar(50) not null,
cve_usuario_correo varchar(50) not null,
host varchar(100) not null,
puerto varchar(10) not null,
autenticacion varchar(10) not null,
remitente varchar(100) not null,
remitente_no_enviar varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab add constraint xxcofidi_usuario_corr_pk_idx01 primary key (id_usuario_correo_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column id_usuario_correo_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column nom_usuario_correo set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column cve_usuario_correo set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column host set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column puerto set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column autenticacion set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_correo_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_correo_tab alter column remitente set not null;
