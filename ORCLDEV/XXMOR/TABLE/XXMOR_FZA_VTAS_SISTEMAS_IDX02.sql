-- dmap_object_gen_tag : type : index name : xxmor_fza_vtas_sistemas_idx02
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_fza_vtas_sistemas_idx02 on xxmor_fzas_vtas_sistemas_tab (id_seg_neg, id_fza_ventas);
