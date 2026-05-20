-- dmap_object_gen_tag : type : index name : eoreor02
set search_path = labprod,oracle,dmap_extension,public;
create index eoreor02 on eoloreor (reo_keyorg, reo_paddep, reo_keydep, reo_keypue, reo_keyplz);
