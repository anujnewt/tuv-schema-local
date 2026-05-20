-- dmap_object_gen_tag : type : table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
create table "feci_recibo_manual_tab"  (
folio_recibo_manual  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
fec_contabilidad timestamp(0) not null,
fec_operativa timestamp(0) not null,
importe numeric not null,
cod_moneda varchar(20) not null,
cod_empresa varchar(20) not null,
cod_cliente varchar(100),
ref_cliente varchar(100),
nom_cliente varchar(250),
clase_cliente varchar(100),
metodo_pago varchar(100),
nom_banco_emisor varchar(250),
num_chequera varchar(100),
num_cheque varchar(100),
num_operacion varchar(100),
tipo_cambio_origen numeric,
fec_tc_origen timestamp(0),
tipo_cambio_dolar numeric,
fec_tc_dolar timestamp(0),
id_usuario_clasificacion numeric,
fec_clasificacion timestamp(0),
id_usuario_aplicacion numeric,
fec_aplicacion timestamp(0),
cod_estado_recibo varchar(20) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab add constraint recibo_manual_pk primary key (folio_recibo_manual) deferrable;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column folio_recibo_manual set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column fec_contabilidad set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column fec_operativa set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column cod_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column cod_estado_recibo set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_recibo_manual_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_recibo_manual_tab alter column ind_estado set not null;
