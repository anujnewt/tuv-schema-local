-- dmap_object_gen_tag : type : index name : nmccol1
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmccol1 on nmloccol (cco_keyrco, cco_numsec);
