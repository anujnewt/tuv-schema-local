-- dmap_object_gen_tag : type : table name : fecxp_folios_prov_invoices
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_folios_prov_invoices"  (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
ap_check_id numeric(15),
ap_invoice_id numeric(15)
) ;
