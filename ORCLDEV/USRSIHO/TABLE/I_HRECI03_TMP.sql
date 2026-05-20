-- dmap_object_gen_tag : type : index name : i_hreci03_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci03_tmp on holoreci_tmp (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_numrem, rec_keyemp, rec_stsrec, rec_stsfon);
