-- dmap_object_gen_tag : type : index name : idx_fecxp_pend_recibos_00
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_pend_recibos_00 on fecxp_pend_recibos (secuencia_dep_especiales);
