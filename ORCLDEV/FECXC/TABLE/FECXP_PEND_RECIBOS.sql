-- dmap_object_gen_tag : type : table name : fecxp_pend_recibos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_pend_recibos"  (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
status_recibo varchar(30),
tipo_recibo varchar(20),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20, 2),
importe_recibo decimal(20, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_pend_recibos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pend_recibos alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pend_recibos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pend_recibos alter column no_folio_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pend_recibos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pend_recibos alter column secuencia_dep_especiales set not null;
