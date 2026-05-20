-- dmap_object_gen_tag : type : index name : log_accesos_seg_neg_fk
set search_path = xxmor,oracle,dmap_extension,public;
create index log_accesos_seg_neg_fk on xxmor_log_accesos_tab (id_seg_neg);
