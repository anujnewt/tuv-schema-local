-- dmap_object_gen_tag : type : index name : nmdeps03
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmdeps03 on nmcodeps (dep_keydep, dep_keycen);
