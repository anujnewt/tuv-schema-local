-- dmap_object_gen_tag : type : index name : eul4_fk_uk_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_fk_uk_i on eul4_key_cons (fk_key_id_remote);
