-- dmap_object_gen_tag : type : index name : eodpla01
set search_path = labprod,oracle,dmap_extension,public;
create index eodpla01 on eolodpla (dpl_keyest, dpl_keydep, dpl_keypue);
