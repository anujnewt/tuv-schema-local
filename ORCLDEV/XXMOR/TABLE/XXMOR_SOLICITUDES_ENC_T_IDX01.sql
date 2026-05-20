-- dmap_object_gen_tag : type : index name : xxmor_solicitudes_enc_t_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_solicitudes_enc_t_idx01 on xxmor_solicitudes_enc_tab (id_seg_neg, id_fza_ventas);
