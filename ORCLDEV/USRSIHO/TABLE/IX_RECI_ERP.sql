-- dmap_object_gen_tag : type : index name : ix_reci_erp
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_reci_erp on reci_erp (rec_stsrec, rec_cvepol);
