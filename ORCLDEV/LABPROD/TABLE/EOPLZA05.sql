-- dmap_object_gen_tag : type : index name : eoplza05
set search_path = labprod,oracle,dmap_extension,public;
create index eoplza05 on eocoplza (plz_keyest, plz_keydep);
