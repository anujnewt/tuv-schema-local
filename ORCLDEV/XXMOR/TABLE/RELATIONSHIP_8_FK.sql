-- dmap_object_gen_tag : type : index name : relationship_8_fk
set search_path = xxmor,oracle,dmap_extension,public;
create index relationship_8_fk on xxmor_log_movimientos_tab (id_solicitud);
