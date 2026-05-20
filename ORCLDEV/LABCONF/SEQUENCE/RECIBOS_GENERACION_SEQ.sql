-- dmap_object_gen_tag : type : sequence name : recibos_generacion_seq
set search_path = labconf,oracle,dmap_extension,public;
create sequence "recibos_generacion_seq"  increment 1 minvalue 1 no maxvalue start 1070 cache 20;
