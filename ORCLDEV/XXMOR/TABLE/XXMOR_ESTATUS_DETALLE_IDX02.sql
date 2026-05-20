-- dmap_object_gen_tag : type : index name : xxmor_estatus_detalle_idx02
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_estatus_detalle_idx02 on xxmor_solicitudes_est_rep_tab (id_solicitud);
