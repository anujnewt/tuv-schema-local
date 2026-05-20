-- dmap_object_gen_tag : type : table name : fecxc_dep_especiales
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_dep_especiales"  (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
fec_valor timestamp(0),
referencia varchar(30) default (null),
id_banco numeric(38),
id_banco_benef numeric(38),
id_chequera varchar(20),
concepto varchar(100),
tipo_cambio decimal(20, 11),
importe decimal(20, 2),
no_cheque numeric(38),
id_tipo_operacion_set numeric(38) not null,
id_forma_pago numeric(38),
id_divisa varchar(3),
fec_valor_original timestamp(0),
id_status_mov varchar(1) not null,
beneficiario varchar(60),
descripcion varchar(30),
secuencia_dep_especiales numeric(38) default (0),
no_cliente varchar(15),
periodo numeric(38),
cve_operacion numeric(38),
origen_movimiento varchar(3),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
plataforma varchar(1),
nom_empresa varchar(100),
no_cuenta numeric(38) default (0),
folio_ref numeric(38) default (0),
fecha_actualizacion timestamp(0),
nom_empresa_rel varchar(100),
procesado numeric(38) default 0,
aperturadoar numeric(38)
) ;
-- function used in indexes must be immutable, use immutable_to_char() instead of to_char()
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales add constraint pk_fecxc_dep_especiales primary key (no_folio_det,id_status_mov,id_tipo_operacion_set);
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales alter column no_folio_det set not null;
