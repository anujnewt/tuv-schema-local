-- dmap_object_gen_tag : type : index name : tipo_cambio_idx
set search_path = feci,oracle,dmap_extension,public;
create index tipo_cambio_idx on feci_tipo_cambio_cat (fec_fecha_tc, cod_moneda, ind_estado);
