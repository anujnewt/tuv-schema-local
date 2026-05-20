-- dmap_object_gen_tag : type : index name : tc_moneda_idx
set search_path = feci,oracle,dmap_extension,public;
create index tc_moneda_idx on feci_tc_moneda_cat (fec_fecha_tc, cod_mon_origen, cod_mon_destino, ind_estado);
