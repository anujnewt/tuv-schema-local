-- dmap_object_gen_tag : type : index name : fk_histchk_alchek_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_histchk_alchek_fk on xxchk_cheq_all_hist (id_sec_cheque);
