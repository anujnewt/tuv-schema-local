-- dmap_object_gen_tag : type : table name : xxcofidi_cfdi_pago_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_cfdi_pago_tab"  (
id_cfdi_pago_pk numeric not null,
uuid varchar(40),
importe_pagado varchar(20),
importe_saldo_ant varchar(20),
importe_saldo_insoluto varchar(20),
moneda_dr varchar(20),
num_parcialidad varchar(20),
tipo_cambio_dr varchar(20),
metodo_pago_dr varchar(20),
id_factura_fk numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_pago_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_pago_tab add constraint xxcofidi_cfdi_pago_pk primary key (id_cfdi_pago_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_pago_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_pago_tab alter column id_cfdi_pago_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_pago_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_pago_tab alter column id_factura_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_pago_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_pago_tab add constraint xxcofidi_cfdi_pago_fk_idx01 foreign key (id_factura_fk) references xxcofidi_factura_tab(id_factura_pk) on delete no action not deferrable initially immediate;
