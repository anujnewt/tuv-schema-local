-- dmap_object_gen_tag : type : index name : idx_holocusi01
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_holocusi01 on holocusi (cus_keyemp, cus_keypue, cus_keycen);
