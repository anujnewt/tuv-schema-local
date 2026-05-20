-- dmap_object_gen_tag : type : index name : i_nperi02
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_nperi02 on nmloperi02 (per_keypro, per_nu3aux, per_keynom, per_nu4aux);
