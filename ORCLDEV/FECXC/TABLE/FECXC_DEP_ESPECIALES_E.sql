-- dmap_object_gen_tag : type : table name : fecxc_dep_especiales_e
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_dep_especiales_e"  (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
fec_valor timestamp(0),
referencia varchar(10),
id_banco numeric(38),
id_banco_benef numeric(38),
id_chequera varchar(20),
concepto varchar(40),
tipo_cambio decimal(20, 11),
importe decimal(20, 2),
no_cheque numeric(38),
id_tipo_operacion_set numeric(38),
id_forma_pago numeric(38),
id_divisa varchar(3),
fec_valor_original timestamp(0),
id_status_mov varchar(1),
beneficiario varchar(60)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales_e add constraint pk_fecxc_dep_especiales_e primary key (no_empresa,no_folio_det);
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales_e alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_dep_especiales_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_dep_especiales_e alter column no_folio_det set not null;
