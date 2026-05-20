-- dmap_object_gen_tag : type : index name : idx_apdpol1
set search_path = labprod,oracle,dmap_extension,public;
create index idx_apdpol1 on sipros_erp_det_his (apd_keypol, apd_fecpol);
