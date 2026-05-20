-- dmap_object_gen_tag : type : index name : i_hreci_ter3
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci_ter3 on holoreci_ter (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_regrfc);
