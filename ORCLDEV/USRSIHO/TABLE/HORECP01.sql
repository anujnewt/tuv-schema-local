-- dmap_object_gen_tag : type : index name : horecp01
set search_path = usrsiho,oracle,dmap_extension,public;
create index horecp01 on holorecp (rec_keypro, rec_keyper);
