-- dmap_object_gen_tag : type : index name : tvbadi01
set search_path = labconf,oracle,dmap_extension,public;
create index tvbadi01 on tvlobadi (bad_keyemp, bad_keyben);
