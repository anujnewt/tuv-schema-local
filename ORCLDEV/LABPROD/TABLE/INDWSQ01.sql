-- dmap_object_gen_tag : type : index name : indwsq01
set search_path = labprod,oracle,dmap_extension,public;
create index indwsq01 on inlodwsq (dws_keywor, dws_numsql, dws_numsec);
