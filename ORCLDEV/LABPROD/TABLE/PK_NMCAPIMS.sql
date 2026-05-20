-- dmap_object_gen_tag : type : index name : pk_nmcapims
set search_path = labprod,oracle,dmap_extension,public;
create index pk_nmcapims on nmcapims (pim_numinc, pim_numche, pim_keyban);
