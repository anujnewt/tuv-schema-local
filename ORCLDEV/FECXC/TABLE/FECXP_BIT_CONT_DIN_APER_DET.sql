-- dmap_object_gen_tag : type : table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bit_cont_din_aper_det"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
secuencia_cont_din_aper_det numeric(38) not null,
importe_set decimal(20, 2),
importe_ap decimal(20, 2),
fec_ejecucion timestamp(0) default (statement_timestamp())
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_det add constraint pk_fecxp_bit_cont_din_aper_det primary key (e_codigo,secuencia_pagos_erp,secuencia_cont_din_aper_det);
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_det alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_det alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_det alter column secuencia_cont_din_aper_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_aper_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_aper_det add constraint fk_fecxp_bit_cont_din_aper foreign key (e_codigo,secuencia_pagos_erp) references fecxp_bit_cont_din_aper_enc(e_codigo,secuencia_pagos_erp) on delete no action not deferrable initially immediate;
