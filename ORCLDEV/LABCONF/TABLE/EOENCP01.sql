-- dmap_object_gen_tag : type : index name : eoencp01
set search_path = labconf,oracle,dmap_extension,public;
create index eoencp01 on eocoencp (ecp_keydep, ecp_keypue, ecp_keycon);
