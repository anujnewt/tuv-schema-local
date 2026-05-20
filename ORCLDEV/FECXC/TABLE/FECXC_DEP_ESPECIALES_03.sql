-- dmap_object_gen_tag : type : index name : fecxc_dep_especiales_03
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxc_dep_especiales_03 on fecxc_dep_especiales (fec_valor_original, aperturadoar, id_tipo_operacion_set);
