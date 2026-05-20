-- dmap_object_gen_tag : type : index name : idx_apdpol2
set search_path = labconf,oracle,dmap_extension,public;
create index idx_apdpol2 on sipros_erp_caietu (ape_keypol, ape_fecpol);
