-- dmap_object_gen_tag : type : index name : fk_histchk_cheksall_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_histchk_cheksall_fk on xxchk_cheq_all_hist (e_codigo, no_folio_det, id_status_mov);
