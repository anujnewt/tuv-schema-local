-- dmap_object_gen_tag : type : index name : eodecp01
set search_path = labprod,oracle,dmap_extension,public;
create index eodecp01 on eocodecp (dcp_keydep, dcp_keypue, dcp_keycon);
