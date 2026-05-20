-- dmap_object_gen_tag : type : index name : idx_gl01
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_gl01 on glcoargu (arg_idepro, arg_idepcc, arg_keyusu);
