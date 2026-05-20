-- dmap_object_gen_tag : type : index name : xxmor_ordenes_urgentes_t_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_ordenes_urgentes_t_idx01 on xxmor_conf_ords_urgentes_tab (id_seg_neg, id_fza_ventas);
