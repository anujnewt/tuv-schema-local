-- dmap_object_gen_tag : type : index name : xxmor_arch_sol_orig_enc_fk
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_arch_sol_orig_enc_fk on xxmor_solicitudes_orig_enc_tab (id_seg_neg, id_archivo_sol);
