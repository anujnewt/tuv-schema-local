-- dmap_object_gen_tag : type : table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_bit_cont_din_aper_e"  (
id_segmento numeric(38) not null,
des_segmento varchar(80),
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
folio_set varchar(150) not null,
mon_oracle varchar(3) not null,
fecha_aplicacion timestamp(0),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
id_chequera varchar(11),
estatus_movimiento varchar(1),
concepto varchar(100),
beneficiario varchar(60),
importe_set decimal(20, 2),
ap_invoice_amount numeric,
ap_invoice_id numeric(15),
estatus_ultima_apertura varchar(11),
fec_ultima_ejecucion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column id_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_e
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_e alter column mon_oracle set not null;
