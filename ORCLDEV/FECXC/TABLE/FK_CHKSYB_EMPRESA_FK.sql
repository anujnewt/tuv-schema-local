-- dmap_object_gen_tag : type : index name : fk_chksyb_empresa_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_chksyb_empresa_fk on xxchk_asoc_fact_cheq_syb (e_codigo);
