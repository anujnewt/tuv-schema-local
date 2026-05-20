-- dmap_object_gen_tag : type : index name : eul4_sb_fk_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_sb_fk_i on eul4_sum_bitmaps (sb_key_id);
