-- dmap_object_gen_tag : type : table name : fecxp_bitacora_procesamiento
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bitacora_procesamiento"  (
id_ejecucion numeric(38) not null,
usuario varchar(25),
fecha timestamp(0),
parametros varchar(100),
estatus_terminado varchar(25),
v_error varchar(255),
proceso varchar(35)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bitacora_procesamiento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bitacora_procesamiento add primary key (id_ejecucion);
