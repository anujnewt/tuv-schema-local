-- dmap_object_gen_tag : type : index name : eul4_bol_obj_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_bol_obj_i on eul4_ba_obj_links (bol_obj_id);
