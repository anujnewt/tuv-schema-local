-- dmap_object_gen_tag : type : index name : nmmosu01
set search_path = labconf,oracle,dmap_extension,public;
create index nmmosu01 on nmwkmosu (mos_keyemp, mos_keyims, mos_mesliq);
