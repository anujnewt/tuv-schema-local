-- dmap_object_gen_tag : type : table name : fecxp_bit_ingr_cc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bit_ingr_cc"  (
secuencia_dep_especiales numeric(38) not null,
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
id_status_mov varchar(1),
tipo_cuenta varchar(20),
estatus_din_cc varchar(1) default ('P'),
fec_primera_ejecucion timestamp(0) default (statement_timestamp()),
fec_ultima_ejecucion timestamp(0) default (statement_timestamp()),
code_combination numeric(38),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
id_divisa varchar(3),
fec_valor timestamp(0),
importe decimal(20, 2),
dias_vigencia_apertura numeric(38) default (60)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_cc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_cc add constraint pk_fecxp_bit_ingr_cc primary key (secuencia_dep_especiales);
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_cc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_cc alter column secuencia_dep_especiales set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_cc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_cc alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_ingr_cc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_ingr_cc alter column no_folio_det set not null;
