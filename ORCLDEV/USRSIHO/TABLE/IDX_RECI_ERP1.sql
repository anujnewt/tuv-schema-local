-- dmap_object_gen_tag : type : index name : idx_reci_erp1
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_reci_erp1 on reci_erp (rec_fecgen);
