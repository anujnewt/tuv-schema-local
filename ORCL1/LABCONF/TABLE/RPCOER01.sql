-- dmap_object_gen_tag : type : index name : rpcoer01
set search_path = labconf,oracle,dmap_extension,public;
create index rpcoer01 on rpcoenrp (enr_keyrep);
