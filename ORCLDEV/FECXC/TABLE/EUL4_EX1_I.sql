-- dmap_object_gen_tag : type : index name : eul4_ex1_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ex1_i on eul4_elem_xrefs (ex_el_id, ex_el_type);
