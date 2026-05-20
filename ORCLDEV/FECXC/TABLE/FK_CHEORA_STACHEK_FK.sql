-- dmap_object_gen_tag : type : index name : fk_cheora_stachek_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cheora_stachek_fk on xxchk_asoc_fact_cheq (id_estado_cheque);
