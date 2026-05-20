-- dmap_object_gen_tag : type : index name : lofoco02
set search_path = labconf,oracle,dmap_extension,public;
create index lofoco02 on nmlofoco (foc_keyfor, foc_numsec);
