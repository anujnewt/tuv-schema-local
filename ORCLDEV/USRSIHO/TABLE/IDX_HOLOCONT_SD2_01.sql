-- dmap_object_gen_tag : type : index name : idx_holocont_sd2_01
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_holocont_sd2_01 on holocont_sdw2 (con_fecini);
