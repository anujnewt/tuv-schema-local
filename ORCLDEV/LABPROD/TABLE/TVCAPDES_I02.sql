-- dmap_object_gen_tag : type : index name : tvcapdes_i02
set search_path = labprod,oracle,dmap_extension,public;
create index tvcapdes_i02 on tvcapdes_i (orderid2, new_pde_capnew, new_pde_keyemp, marca);
