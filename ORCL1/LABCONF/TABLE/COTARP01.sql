-- dmap_object_gen_tag : type : index name : cotarp01
set search_path = labconf,oracle,dmap_extension,public;
create index cotarp01 on nmcotarp (arp_keyarp, arp_keyrep);
