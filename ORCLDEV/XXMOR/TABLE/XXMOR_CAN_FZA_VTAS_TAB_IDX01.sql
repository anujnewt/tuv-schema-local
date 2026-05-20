-- dmap_object_gen_tag : type : index name : xxmor_can_fza_vtas_tab_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_can_fza_vtas_tab_idx01 on xxmor_fzas_vtas_canales_tab (id_seg_neg, id_fza_ventas);
