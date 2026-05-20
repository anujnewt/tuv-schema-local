-- dmap_object_gen_tag : type : index name : idx_apdpol1_tmp
set search_path = labconf,oracle,dmap_extension,public;
create index idx_apdpol1_tmp on sipros_erp_det_tmp (apd_keypol, apd_fecpol);
