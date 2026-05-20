-- dmap_object_gen_tag : type : index name : eul4_bq_bs_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_bq_bs_i on eul4_batch_queries (bq_bs_id);
