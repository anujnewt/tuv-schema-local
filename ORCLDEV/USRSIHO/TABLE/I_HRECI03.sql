-- dmap_object_gen_tag : type : index name : i_hreci03
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hreci03 on holoreci (rec_keypro, rec_keyapr, rec_keynom, rec_numemi, rec_numrem, rec_keyemp, rec_stsrec, rec_stsfon);
