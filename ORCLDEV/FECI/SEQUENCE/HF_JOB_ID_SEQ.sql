-- dmap_object_gen_tag : type : sequence name : hf_job_id_seq
set search_path = feci,oracle,dmap_extension,public;
create sequence "hf_job_id_seq"  increment 1 minvalue 1 no maxvalue start 101 cache 20;
