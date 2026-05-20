-- dmap_object_gen_tag : type : index name : gldats01
set search_path = usrsiho,oracle,dmap_extension,public;
create index gldats01 on glcodats (dat_keymen, dat_idecam);
