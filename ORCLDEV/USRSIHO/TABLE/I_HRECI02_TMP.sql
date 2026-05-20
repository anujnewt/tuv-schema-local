-- dmap_object_gen_tag : type : index name : i_hreci02_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci02_tmp on holoreci_tmp (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_keyemp);
