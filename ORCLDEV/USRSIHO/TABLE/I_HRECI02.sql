-- dmap_object_gen_tag : type : index name : i_hreci02
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci02 on holoreci (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_keyemp);
