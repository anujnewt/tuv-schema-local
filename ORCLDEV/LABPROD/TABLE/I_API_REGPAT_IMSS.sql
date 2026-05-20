-- dmap_object_gen_tag : type : index name : i_api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
create index i_api_regpat_imss on api_regpat_imss (id_transaccion);
