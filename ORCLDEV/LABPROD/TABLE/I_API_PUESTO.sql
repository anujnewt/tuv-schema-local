-- dmap_object_gen_tag : type : index name : i_api_puesto
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_puesto on api_puesto (id_transaccion);
