-- dmap_object_gen_tag : type : index name : eul4_srs_rfu_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_srs_rfu_i on eul4_sum_rfsh_sets (srs_rfu_id);
