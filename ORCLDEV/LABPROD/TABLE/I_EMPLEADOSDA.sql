-- dmap_object_gen_tag : type : index name : i_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
create index i_empleadosda on api_empleadosda (id_transaccion);
