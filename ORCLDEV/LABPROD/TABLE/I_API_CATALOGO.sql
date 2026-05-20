-- dmap_object_gen_tag : type : index name : i_api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_catalogo on api_catalogo (id_transaccion);
