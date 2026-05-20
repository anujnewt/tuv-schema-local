-- dmap_object_gen_tag : type : index name : xxmor_sol_det_orig_tab_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_sol_det_orig_tab_idx01 on xxmor_solicitudes_orig_det_tab (id_request);
