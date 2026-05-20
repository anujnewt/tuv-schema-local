-- dmap_object_gen_tag : type : index name : eul4_doc_eu_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_doc_eu_i on eul4_documents (doc_eu_id);
