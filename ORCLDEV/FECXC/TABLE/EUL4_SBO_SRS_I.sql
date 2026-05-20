-- dmap_object_gen_tag : type : index name : eul4_sbo_srs_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_sbo_srs_i on eul4_summary_objs (sbo_srs_id);
