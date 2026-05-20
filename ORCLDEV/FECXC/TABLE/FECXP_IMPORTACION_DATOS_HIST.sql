-- dmap_object_gen_tag : type : table name : fecxp_importacion_datos_hist
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_importacion_datos_hist"  (
tipo_empresa_imp varchar(2) not null,
tipo_importacion varchar(2),
e_empresa_imp varchar(25),
cla_fe_id_imp varchar(25),
importe_linea decimal(20, 4),
moneda_imp varchar(3),
mes numeric(38),
fecha timestamp(0),
atributo_1 varchar(256),
atributo_2 varchar(256),
atributo_3 varchar(256),
atributo_4 varchar(256),
estatus_origen varchar(25) default ('IMPORTADO'),
division varchar(50),
agrupamiento varchar(50),
rubro varchar(250),
folio_set varchar(150),
no_cliente varchar(15),
referencia varchar(30),
descripcion varchar(30),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(20),
estatus_movimiento varchar(4),
beneficiario varchar(60),
concepto varchar(100),
origen_movimiento varchar(4),
numero_de_partida numeric(38),
cia varchar(25),
neg varchar(25),
cta varchar(25),
sct varchar(25),
cc varchar(25),
icia varchar(25),
top varchar(25),
estatus varchar(50),
fecha_aplicacion timestamp(0),
e_empresa_des varchar(100),
cla_fe_des varchar(50),
code_combination numeric(38)
) ;
-- function used in indexes must be immutable, use immutable_to_char() instead of to_char()
-- dmap_object_gen_tag : type : alter table name : fecxp_importacion_datos_hist
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_importacion_datos_hist alter column tipo_empresa_imp set not null;
