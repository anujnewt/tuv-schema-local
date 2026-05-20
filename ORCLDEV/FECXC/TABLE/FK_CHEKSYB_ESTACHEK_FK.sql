-- dmap_object_gen_tag : type : index name : fk_cheksyb_estachek_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cheksyb_estachek_fk on xxchk_asoc_fact_cheq_syb (id_estado_cheque);
