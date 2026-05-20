-- dmap_object_gen_tag : type : index name : idx_wesuperv02
set search_path = labconf,oracle,dmap_extension,public;
create index idx_wesuperv02 on wesuperv (sup_keyemp);
