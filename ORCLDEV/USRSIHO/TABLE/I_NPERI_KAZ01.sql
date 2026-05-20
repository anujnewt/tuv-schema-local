-- dmap_object_gen_tag : type : index name : i_nperi_kaz01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_nperi_kaz01 on nmloperi (per_fecpag, per_keypro, per_nummes);
