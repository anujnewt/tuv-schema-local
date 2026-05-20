-- dmap_object_gen_tag : type : index name : i_api_nmlocenc
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_nmlocenc on api_nmlocenc (id_transaccion);
