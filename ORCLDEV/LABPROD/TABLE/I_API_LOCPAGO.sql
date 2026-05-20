-- dmap_object_gen_tag : type : index name : i_api_locpago
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_locpago on api_locpago (id_transaccion);
