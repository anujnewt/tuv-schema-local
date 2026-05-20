-- dmap_object_gen_tag : type : index name : xxchk_cheque_a_asoc_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_cheque_a_asoc_fk on xxchk_asoc_fact_cheq (id_sec_cheque);
