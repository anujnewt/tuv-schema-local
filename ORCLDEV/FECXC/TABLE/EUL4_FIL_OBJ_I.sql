-- dmap_object_gen_tag : type : index name : eul4_fil_obj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_fil_obj_i on eul4_expressions (fil_obj_id);
