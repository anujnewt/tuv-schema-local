-- dmap_object_gen_tag : type : table name : fecxp_bit_ingr_misc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bit_ingr_misc"  (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
receipt_number varchar(30),
num_recibo numeric(38),
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
cash_receipt_id numeric(15),
receivables_trx_id numeric(15),
status_recibo varchar(30),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20, 2),
importe_recibo decimal(20, 2),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_misc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_misc add constraint pk_fecxp_bit_ingr_misc primary key (secuencia_dep_especiales);
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_misc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_misc alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_misc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_misc alter column no_folio_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_misc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_misc alter column secuencia_dep_especiales set not null;
