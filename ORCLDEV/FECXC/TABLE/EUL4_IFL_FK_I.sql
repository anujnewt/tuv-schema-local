-- dmap_object_gen_tag : type : index name : eul4_ifl_fk_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ifl_fk_i on eul4_ihs_fk_links (ifl_key_id);
