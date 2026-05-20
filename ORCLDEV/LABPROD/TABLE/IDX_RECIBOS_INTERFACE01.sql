-- dmap_object_gen_tag : type : index name : idx_recibos_interface01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_recibos_interface01 on recibos_interface (eje_feceje);
