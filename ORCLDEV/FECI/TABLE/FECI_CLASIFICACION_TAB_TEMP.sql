-- dmap_object_gen_tag : type : table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
create table "feci_clasificacion_tab_temp"  (
id_clasificacion numeric not null,
folio_recibo numeric not null,
tipo_recibo varchar(20) not null,
orden numeric not null,
porcentaje_iva numeric not null,
importe_org numeric not null,
monto_base_org numeric not null,
monto_iva_org numeric not null,
importe_mxn numeric not null,
monto_base_mxn numeric not null,
monto_iva_mxn numeric not null,
importe_usd numeric not null,
monto_base_usd numeric not null,
monto_iva_usd numeric not null,
cod_segmento varchar(20) not null,
cod_grupo_forecast varchar(20) not null,
cod_concepto varchar(20),
cod_region varchar(20),
cod_pais varchar(20),
desc_cps varchar(100),
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column id_clasificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column folio_recibo set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column tipo_recibo set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column orden set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column porcentaje_iva set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column importe_org set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_base_org set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_iva_org set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column importe_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_base_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_iva_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column importe_usd set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_base_usd set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column monto_iva_usd set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column cod_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column cod_grupo_forecast set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_clasificacion_tab_temp
set search_path = feci,oracle,dmap_extension,public;
alter table feci_clasificacion_tab_temp alter column ind_estado set not null;
