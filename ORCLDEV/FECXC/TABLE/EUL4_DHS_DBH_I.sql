-- dmap_object_gen_tag : type : index name : eul4_dhs_dbh_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_dhs_dbh_i on eul4_hi_segments (dhs_hi_id);
