-- dmap_object_gen_tag : type : index name : eul4_sdo_sbo_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_sdo_sbo_i on eul4_summary_objs (sdo_sbo_id);
