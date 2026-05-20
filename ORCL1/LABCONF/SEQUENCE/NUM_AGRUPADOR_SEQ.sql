-- dmap_object_gen_tag : type : sequence name : num_agrupador_seq
set search_path = labconf,oracle,dmap_extension,public;
create sequence "num_agrupador_seq"  increment 1 minvalue 1 no maxvalue start 1 cache 20;
