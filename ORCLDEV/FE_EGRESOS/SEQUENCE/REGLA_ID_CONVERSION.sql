-- dmap_object_gen_tag : type : sequence name : regla_id_conversion
set search_path = fe_egresos,oracle,dmap_extension,public;
create sequence "regla_id_conversion"  increment 1 minvalue 1 no maxvalue start 500 cache 20;
