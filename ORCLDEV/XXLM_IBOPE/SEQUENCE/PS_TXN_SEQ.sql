-- dmap_object_gen_tag : type : sequence name : ps_txn_seq
set search_path = xxlm_ibope,oracle,dmap_extension,public;
create sequence "ps_txn_seq"  increment 50 minvalue 1 no maxvalue start 437251 cache 20;
