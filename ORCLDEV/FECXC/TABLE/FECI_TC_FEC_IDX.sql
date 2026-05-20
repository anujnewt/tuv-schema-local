-- dmap_object_gen_tag : type : index name : feci_tc_fec_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_tc_fec_idx on feci_tipo_cambio_cat (fec_fecha_tc);
