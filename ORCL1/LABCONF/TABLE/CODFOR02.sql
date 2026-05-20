-- dmap_object_gen_tag : type : index name : codfor02
set search_path = labconf,oracle,dmap_extension,public;
create index codfor02 on nmcodfor (for_keyfor, for_keytab, for_keycam);
