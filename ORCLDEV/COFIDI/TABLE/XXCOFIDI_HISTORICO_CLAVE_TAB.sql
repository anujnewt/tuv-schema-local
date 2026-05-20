-- dmap_object_gen_tag : type : table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_historico_clave_tab"  (
id_historico_clave_pk numeric not null,
id_usuario_fk numeric not null,
cve_usuario varchar(50) not null,
fec_movimiento timestamp not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab add constraint xxcofidi_hist_clave_pk_idx01 primary key (id_historico_clave_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab alter column id_historico_clave_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab alter column id_usuario_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab alter column cve_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab alter column fec_movimiento set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_clave_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_clave_tab add constraint xxcofidi_hist_clave_usu_idx01 foreign key (id_usuario_fk) references xxcofidi_usuario_tab(id_usuario_pk) on delete no action not deferrable initially immediate;
