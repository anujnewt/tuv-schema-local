-- dmap_object_gen_tag : type : index name : recnom01
set search_path = labconf,oracle,dmap_extension,public;
create index recnom01 on nmrecnom (rec_nomrep, rec_idepcc, rec_keyusu, rec_numsec);
