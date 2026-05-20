-- dmap_object_gen_tag : type : index name : glresu01
set search_path = usrsiho,oracle,dmap_extension,public;
create index glresu01 on glcoresu (res_idepro, res_idepcc);
