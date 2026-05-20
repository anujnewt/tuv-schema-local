-- dmap_object_gen_tag : type : index name : idx_fecxp_folios_prov_det_00
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_folios_prov_det_00 on fecxp_folios_prov_det (fecxp_e_codigo, fecxp_no_folio_det);
