-- dmap_object_gen_tag : type : index name : eul4_obj2_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_obj2_i on eul4_objs (obj_ext_object, obj_ext_owner, obj_ext_db_link);
