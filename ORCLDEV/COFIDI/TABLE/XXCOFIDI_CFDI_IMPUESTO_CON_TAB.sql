-- dmap_object_gen_tag : type : table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_cfdi_impuesto_con_tab"  (
id_cfdi_impuesto_concepto_pk numeric not null,
id_factura_fk numeric not null,
id_cfdi_concepto_fk numeric,
traslado numeric(1) not null,
base varchar(20),
impuesto varchar(20) not null,
tipo_factor varchar(20),
tasa_o_cuota varchar(20),
importe varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab add constraint xxcofidi_cfdi_impuesto_con_pk primary key (id_cfdi_impuesto_concepto_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab alter column id_cfdi_impuesto_concepto_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab alter column id_factura_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab alter column traslado set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab alter column impuesto set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab add constraint xxcofidi_imp_concept_fk_idx01 foreign key (id_cfdi_concepto_fk) references xxcofidi_cfdi_concepto_tab(id_cfdi_concepto_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_cfdi_impuesto_con_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_cfdi_impuesto_con_tab add constraint xxcofidi_imp_factura_fk_idx01 foreign key (id_factura_fk) references xxcofidi_factura_tab(id_factura_pk) on delete no action not deferrable initially immediate;
