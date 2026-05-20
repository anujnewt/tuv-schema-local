-- dmap_object_gen_tag : type : index name : idx_fecxp_folios_prov_det_02
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_folios_prov_det_02 on fecxp_folios_prov_det (ap_dist_code_combination_id);
