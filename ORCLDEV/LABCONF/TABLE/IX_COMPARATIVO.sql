-- dmap_object_gen_tag : type : index name : ix_comparativo
set search_path = labconf,oracle,dmap_extension,public;
create index ix_comparativo on comparativo (cve_origen);
