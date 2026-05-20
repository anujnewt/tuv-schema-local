-- dmap_object_gen_tag : type : index name : xxmor_fzas_ventas_mult_t_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_fzas_ventas_mult_t_idx01 on xxmor_fzas_vtas_mult_tab (id_seg_neg_hijo, id_fza_ventas_hija);
