-- dmap_object_gen_tag : type : index name : holoretr01
set search_path = usrsiho,oracle,dmap_extension,public;
create index holoretr01 on holoretr (ret_keyrph, ret_keyrpv);
