-- dmap_object_gen_tag : type : index name : i_nperi_kaz02
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_nperi_kaz02 on nmloperi (per_nummes);
