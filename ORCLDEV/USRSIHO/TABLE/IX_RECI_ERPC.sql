-- dmap_object_gen_tag : type : index name : ix_reci_erpc
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_reci_erpc on reci_erp_c (rec_stsrec, rec_cvepol);
