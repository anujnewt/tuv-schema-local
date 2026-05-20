-- dmap_object_gen_tag : type : index name : hcont01
set search_path = usrsiho,oracle,dmap_extension,public;
create index hcont01 on holocont (con_keydep, con_keypue);
