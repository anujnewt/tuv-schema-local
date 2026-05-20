-- dmap_object_gen_tag : type : index name : eul4_dhn_dbh_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_dhn_dbh_i on eul4_dbh_nodes (dhn_hi_id);
