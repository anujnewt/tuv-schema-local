-- dmap_object_gen_tag : type : table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_bit_cont_din_folios_ap"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
secuencia_cont_din_aper_det numeric(38) not null,
ap_invoice_id numeric(15) not null,
ap_invoice_amount numeric
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_folios_ap add constraint pk_fecxp_bit_cont_din_fol_ap primary key (e_codigo,secuencia_pagos_erp,secuencia_cont_din_aper_det,ap_invoice_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_folios_ap alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_folios_ap alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_folios_ap alter column secuencia_cont_din_aper_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_bit_cont_din_folios_ap add constraint fk_fecxp_bit_cont_din_folios foreign key (e_codigo,secuencia_pagos_erp,secuencia_cont_din_aper_det) references fecxp_bit_cont_din_aper_det(e_codigo,secuencia_pagos_erp,secuencia_cont_din_aper_det) on delete no action not deferrable initially immediate;
