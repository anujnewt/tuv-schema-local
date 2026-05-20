-- dmap_object_gen_tag : type : table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_factura_tab"  (
id_factura_pk numeric(38) not null,
cliente_transaccional varchar(100),
fec_timbrado timestamp,
folio numeric(38),
nom_emisor varchar(255),
nom_receptor varchar(255),
rfc_emisor varchar(13),
rfc_receptor varchar(13),
serie varchar(50),
uuid varchar(50),
id_documento_pdf_fk numeric(38),
id_documento_xml_fk numeric(38),
id_estado_fk numeric not null,
fec_emision timestamp,
tipo_comprobante varchar(20) not null,
val_subtotal varchar(20),
val_impuesto varchar(20),
val_total varchar(20),
pac varchar(10),
origen varchar(50),
folio_alfanumerico varchar(50),
cve_exportacion varchar(10),
cve_periodicidad varchar(10),
cve_meses varchar(10),
cve_anio numeric,
cve_base varchar(10),
cod_dom_fiscal_r varchar(20),
cod_reg_fiscal_r varchar(20),
cod_rfc_a_terceros varchar(20),
cve_nom_acuent_aterc varchar(256),
cod_reg_fis_aterc varchar(20),
cod_dom_fiscal_aterc varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab add constraint xxcofidi_factura_pk_idx01 primary key (id_factura_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab alter column id_factura_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab alter column id_estado_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab alter column tipo_comprobante set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab add constraint xxcofidi_factura_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab add constraint xxcofidi_fac_doc_pdf_fk_idx01 foreign key (id_documento_pdf_fk) references xxcofidi_documento_tab(id_documento_pk) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_factura_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_factura_tab add constraint xxcofidi_fac_doc_xml_fk_idx01 foreign key (id_documento_xml_fk) references xxcofidi_documento_tab(id_documento_pk) on delete no action not deferrable initially immediate;
