-- dmap_object_gen_tag : type : table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_historico_usuario_tab"  (
id_historico_usuario_pk numeric not null,
id_usuario_movimiento_fk numeric,
user_name_movimiento varchar(50) not null,
id_usuario_afectado_fk numeric not null,
user_name_afectado varchar(50) not null,
fec_movimiento timestamp not null,
des_movimiento varchar(255) not null,
tipo_abc varchar(6),
nom_afectado varchar(255),
ip_origen varchar(15)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab add constraint xxcofidi_historico_usuario_pk primary key (id_historico_usuario_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column id_historico_usuario_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column user_name_movimiento set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column id_usuario_afectado_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column user_name_afectado set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column fec_movimiento set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_historico_usuario_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_historico_usuario_tab alter column des_movimiento set not null;
