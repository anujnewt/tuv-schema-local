-- dmap_object_gen_tag : type : index name : i_api_departamento
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_departamento on api_departamento (id_transaccion);
