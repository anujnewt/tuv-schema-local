-- dmap_object_gen_tag : type : table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bit_cont_din_aper_enc"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
moneda varchar(3),
fecha_aplicacion timestamp(0),
tipo_operacion numeric(38),
id_banco numeric(38),
forma_pago numeric(38),
estatus_movimiento varchar(1),
id_chequera varchar(11),
concepto varchar(100),
beneficiario varchar(60),
importe_set decimal(20, 2),
estatus_cont_din_aper varchar(1) default ('P'),
fec_primera_ejecucion timestamp(0) default (statement_timestamp()),
fec_ultima_ejecucion timestamp(0) default (statement_timestamp()),
dias_vigencia_apertura numeric(38) default (60)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc add constraint pk_fecxp_bit_cont_din_aper_enc primary key (e_codigo,secuencia_pagos_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc add constraint ckc_bit_cont_din_aper_enc check (estatus_cont_din_aper in ('P','S', 'C'));
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_enc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_enc add constraint fk_fecxp_bit_cont_din_pagos foreign key (e_codigo,secuencia_pagos_erp) references fecxp_enc_pagos_erp(e_codigo,secuencia_pagos_erp) on delete no action not deferrable initially immediate;
