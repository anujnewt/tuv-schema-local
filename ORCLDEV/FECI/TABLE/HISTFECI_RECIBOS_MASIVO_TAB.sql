-- dmap_object_gen_tag : type : table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
create table "histfeci_recibos_masivo_tab"  (
folio_recibo varchar(30) not null,
cod_empresa varchar(20) not null,
des_empresa varchar(250) not null,
fec_ingreso timestamp(0) not null,
fec_contabilidad timestamp(0) not null,
fec_deposito timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
des_moneda varchar(250) not null,
cod_cliente varchar(100),
cod_clase_cliente varchar(100),
nom_cliente varchar(250),
ref_cliente varchar(100),
metodo_pago varchar(100),
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
fec_tc_origen timestamp(0),
tipo_cambio_origen numeric,
fec_tc_dolar timestamp(0),
tipo_cambio_dolar numeric,
fec_clasificacion timestamp(0),
fec_aplicacion timestamp(0),
porcentaje_iva numeric not null,
cod_porcentaje_iva varchar(20) not null,
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
des_segmento varchar(250) not null,
cod_grupo_forecast varchar(20) not null,
des_grupo_forecast varchar(250) not null,
cod_concepto varchar(20) not null,
des_concepto varchar(250) not null,
cod_region varchar(20),
des_region varchar(250),
cod_pais varchar(20),
des_pais varchar(250),
desc_cps varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column folio_recibo set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column fec_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column fec_contabilidad set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column fec_deposito set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column des_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column porcentaje_iva set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_porcentaje_iva set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column importe_org set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_base_org set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_iva_org set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column importe_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_base_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_iva_mxn set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column importe_usd set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_base_usd set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column monto_iva_usd set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column des_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_grupo_forecast set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column des_grupo_forecast set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column cod_concepto set not null;
-- dmap_object_gen_tag : type : alter table name : histfeci_recibos_masivo_tab
set search_path = feci,oracle,dmap_extension,public;
alter table histfeci_recibos_masivo_tab alter column des_concepto set not null;
