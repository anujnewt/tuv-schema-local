-- dmap_object_gen_tag : type : index name : eul4_it_obj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_it_obj_i on eul4_expressions (it_obj_id);
