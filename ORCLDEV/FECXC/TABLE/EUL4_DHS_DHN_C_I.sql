-- dmap_object_gen_tag : type : index name : eul4_dhs_dhn_c_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_dhs_dhn_c_i on eul4_hi_segments (dhs_dhn_id_parent);
