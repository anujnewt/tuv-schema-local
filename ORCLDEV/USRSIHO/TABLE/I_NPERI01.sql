-- dmap_object_gen_tag : type : index name : i_nperi01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_nperi01 on nmloperi (per_keypro, per_nu3aux, per_keynom, per_nu4aux);
