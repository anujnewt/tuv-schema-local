-- dmap_object_gen_tag : type : index name : idx_webitacc01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_webitacc01 on webitacc (wcc_keyemp);
