-- dmap_object_gen_tag : type : index name : eul4_key_obj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_key_obj_i on eul4_key_cons (key_obj_id);
