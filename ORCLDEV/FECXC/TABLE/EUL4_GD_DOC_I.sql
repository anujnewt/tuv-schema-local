-- dmap_object_gen_tag : type : index name : eul4_gd_doc_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_gd_doc_i on eul4_access_privs (gd_doc_id);
