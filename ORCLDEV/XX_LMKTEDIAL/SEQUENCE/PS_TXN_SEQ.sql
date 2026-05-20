-- dmap_object_gen_tag : type : sequence name : ps_txn_seq
set search_path = xx_lmktedial,oracle,dmap_extension,public;
create sequence "ps_txn_seq"  increment 50 minvalue 1 no maxvalue start 88151 cache 20;
