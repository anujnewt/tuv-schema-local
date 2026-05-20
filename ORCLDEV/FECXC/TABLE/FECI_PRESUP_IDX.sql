-- dmap_object_gen_tag : type : index name : feci_presup_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_presup_idx on feci_presupuesto_tab (cod_segmento, cod_concepto, cod_moneda, fec_presupuesto, num_gestion);
