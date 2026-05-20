-- dmap_object_gen_tag : type : index name : eul4_od_cobj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_od_cobj_i on eul4_obj_deps (od_obj_id_from);
