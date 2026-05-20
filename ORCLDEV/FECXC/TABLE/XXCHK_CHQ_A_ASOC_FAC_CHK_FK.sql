-- dmap_object_gen_tag : type : index name : xxchk_chq_a_asoc_fac_chk_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_chq_a_asoc_fac_chk_fk on xxchk_asoc_fact_cheq_syb (id_sec_cheque);
