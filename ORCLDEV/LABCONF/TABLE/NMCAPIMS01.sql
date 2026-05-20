-- dmap_object_gen_tag : type : index name : nmcapims01
set search_path = labconf,oracle,dmap_extension,public;
create index nmcapims01 on nmcapims (pim_numche, pim_keyban, pim_numinc);
