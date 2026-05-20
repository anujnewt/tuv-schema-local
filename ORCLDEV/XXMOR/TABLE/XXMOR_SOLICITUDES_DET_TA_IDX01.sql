-- dmap_object_gen_tag : type : index name : xxmor_solicitudes_det_ta_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_solicitudes_det_ta_idx01 on xxmor_solicitudes_det_tab (id_solicitud);
