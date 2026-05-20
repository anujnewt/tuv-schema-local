-- dmap_object_gen_tag : type : index name : fecxp_folios_prov_invoices_00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_folios_prov_invoices_00 on fecxp_folios_prov_invoices (fecxp_e_codigo, fecxp_no_folio_det);
