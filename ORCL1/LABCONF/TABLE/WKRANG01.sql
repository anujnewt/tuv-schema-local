-- dmap_object_gen_tag : type : index name : wkrang01
set search_path = labconf,oracle,dmap_extension,public;
create index wkrang01 on glwkrang (ran_nomrep, ran_idepcc, ran_keyusu);
