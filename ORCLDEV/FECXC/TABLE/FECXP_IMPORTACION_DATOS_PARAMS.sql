-- dmap_object_gen_tag : type : table name : fecxp_importacion_datos_params
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_importacion_datos_params"  (
tipo_empresa_imp varchar(2) not null,
tipoempresa varchar(2),
tipo_importacion varchar(2),
permite_importacion varchar(1),
estatus_origen varchar(25) default 'EN ESPERA'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_importacion_datos_params
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_importacion_datos_params alter column tipo_empresa_imp set not null;
