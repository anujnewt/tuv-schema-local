-- dmap_object_gen_tag : type : index name : fk_chk_facts_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_chk_facts_fk on xxchk_asoc_fact_cheq (e_codigo);
