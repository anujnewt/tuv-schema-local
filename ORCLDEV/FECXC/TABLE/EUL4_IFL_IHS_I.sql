-- dmap_object_gen_tag : type : index name : eul4_ifl_ihs_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ifl_ihs_i on eul4_ihs_fk_links (ifl_ihs_id);
