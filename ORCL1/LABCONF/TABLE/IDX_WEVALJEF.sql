-- dmap_object_gen_tag : type : index name : idx_wevaljef
set search_path = labconf,oracle,dmap_extension,public;
create index idx_wevaljef on wevaljef (val_keyemp);
