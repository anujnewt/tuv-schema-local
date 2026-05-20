-- dmap_object_gen_tag : type : index name : nmmofi01
set search_path = labconf,oracle,dmap_extension,public;
create index nmmofi01 on nmwkmofi (mof_keyemp, mof_keyims);
