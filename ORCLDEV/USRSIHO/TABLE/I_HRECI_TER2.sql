-- dmap_object_gen_tag : type : index name : i_hreci_ter2
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci_ter2 on holoreci_ter (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_numrem, rec_keyemp, rec_stsrec, rec_stsfon);
