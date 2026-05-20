-- dmap_object_gen_tag : type : index name : holoenc_1
set search_path = usrsiho,oracle,dmap_extension,public;
create index holoenc_1 on holoenlla (enl_keydep, enl_feclla);
