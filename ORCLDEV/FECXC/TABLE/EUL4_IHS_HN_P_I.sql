-- dmap_object_gen_tag : type : index name : eul4_ihs_hn_p_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ihs_hn_p_i on eul4_hi_segments (ihs_hn_id_child);
