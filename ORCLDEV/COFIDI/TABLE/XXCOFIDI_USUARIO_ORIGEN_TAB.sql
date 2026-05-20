-- dmap_object_gen_tag : type : table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usuario_origen_tab"  (
id_usuario_origen_pk numeric not null,
id_usuario_fk numeric not null,
id_origen_fk numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab add constraint xxcofidi_usu_ori_pk_idx01 primary key (id_usuario_origen_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab alter column id_usuario_origen_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab alter column id_usuario_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab alter column id_origen_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab add constraint xxcofidi_usu_ori_origen_idx foreign key (id_origen_fk) references xxcofidi_origen_ct_tab(id_origen_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_origen_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_origen_tab add constraint xxcofidi_usu_ori_usuario_idx foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
