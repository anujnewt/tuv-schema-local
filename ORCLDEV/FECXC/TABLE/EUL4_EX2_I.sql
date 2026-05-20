-- dmap_object_gen_tag : type : index name : eul4_ex2_i
set search_path = fecxc,oracle,dmap_extension,public;
create index eul4_ex2_i on eul4_elem_xrefs (ex_ref1, ex_type, ex_ref2);
