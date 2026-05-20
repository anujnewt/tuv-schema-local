-- dmap_object_gen_tag : type : index name : rbosmsgs01
set search_path = labconf,oracle,dmap_extension,public;
create index rbosmsgs01 on rbosmsgs (msg_keypro, msg_keyper, msg_keynom);
