-- dmap_object_gen_tag : type : index name : idx_wesuperv01
set search_path = labconf,oracle,dmap_extension,public;
create index idx_wesuperv01 on wesuperv (sup_keysup);
