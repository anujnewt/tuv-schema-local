-- dmap_object_gen_tag : type : index name : idx_recibos_generacion01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_recibos_generacion01 on recibos_generacion (eje_keypro, eje_keyper);
