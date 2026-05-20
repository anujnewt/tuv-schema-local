-- dmap_object_gen_tag : type : table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_b_ejecucion_proceso"  (
id_proceso numeric(38) not null,
proceso_nombre varchar(100) not null,
catalogo_nombre varchar(100) not null,
version_id numeric(38) not null,
accion varchar(25) not null,
usuario_id varchar(30) not null,
fecha_creacion timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso add constraint pkfecxp_bit_ejecucion_procesos primary key (id_proceso,proceso_nombre,catalogo_nombre,version_id,accion);
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column id_proceso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column proceso_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column catalogo_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column accion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column usuario_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_ejecucion_proceso
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_ejecucion_proceso alter column fecha_creacion set not null;
