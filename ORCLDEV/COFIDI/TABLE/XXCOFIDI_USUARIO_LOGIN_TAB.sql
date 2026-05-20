-- dmap_object_gen_tag : type : table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usuario_login_tab"  (
id_usuario_login_pk numeric not null,
id_usuario_fk numeric not null,
fec_ultimo_logeo timestamp not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_login_tab add constraint xxcofidi_usu_login_pk_idx01 primary key (id_usuario_login_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_login_tab alter column id_usuario_login_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_login_tab alter column id_usuario_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_login_tab alter column fec_ultimo_logeo set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_login_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_login_tab add constraint xxcofidi_usuario_login_usu_idx foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
