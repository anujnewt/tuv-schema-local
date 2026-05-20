-- dmap_object_gen_tag : type : index name : eul4_sumo_asmp_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_sumo_asmp_i on eul4_summary_objs (sumo_asmp_id);
