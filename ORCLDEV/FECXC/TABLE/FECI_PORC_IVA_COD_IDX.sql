-- dmap_object_gen_tag : type : index name : feci_porc_iva_cod_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_porc_iva_cod_idx on feci_porcentaje_iva_cat (cod_porcentaje_iva);
