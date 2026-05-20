-- dmap_object_gen_tag : type : index name : nmpcol1
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmpcol1 on nmlopcol (pco_keyrco, pco_numsec);
