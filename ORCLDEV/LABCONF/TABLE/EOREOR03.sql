-- dmap_object_gen_tag : type : index name : eoreor03
set search_path = labconf,oracle,dmap_extension,public;
create index eoreor03 on eoloreor (reo_keyorg, reo_padplz, reo_keyplz);
