-- dmap_object_gen_tag : type : index name : xxmor_cat_urls_tab_idx01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_cat_urls_tab_idx01 on xxmor_cat_urls_tab (id_seg_neg);
