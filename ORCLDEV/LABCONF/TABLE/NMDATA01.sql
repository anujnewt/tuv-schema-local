-- dmap_object_gen_tag : type : index name : nmdata01
set search_path = labconf,oracle,dmap_extension,public;
create index nmdata01 on nmlodata (dat_keyemp, dat_keypar);
