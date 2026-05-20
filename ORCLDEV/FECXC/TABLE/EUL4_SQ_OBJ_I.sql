-- dmap_object_gen_tag : type : index name : eul4_sq_obj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_sq_obj_i on eul4_sub_queries (sq_obj_id);
