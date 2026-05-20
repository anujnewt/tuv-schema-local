-- dmap_object_gen_tag : type : index name : eul4_kil_key_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_kil_key_i on eul4_ig_exp_links (kil_key_id);
