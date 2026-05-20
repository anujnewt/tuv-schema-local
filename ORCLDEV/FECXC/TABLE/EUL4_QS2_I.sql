-- dmap_object_gen_tag : type : index name : eul4_qs2_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_qs2_i on eul4_qpp_stats (qs_object_use_key);
