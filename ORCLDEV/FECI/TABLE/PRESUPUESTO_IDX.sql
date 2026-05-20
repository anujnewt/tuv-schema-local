-- dmap_object_gen_tag : type : index name : presupuesto_idx
set search_path = feci,oracle,dmap_extension,public;
create index presupuesto_idx on feci_presupuesto_tab (cod_segmento, cod_concepto, cod_moneda, num_gestion, ind_estado);
