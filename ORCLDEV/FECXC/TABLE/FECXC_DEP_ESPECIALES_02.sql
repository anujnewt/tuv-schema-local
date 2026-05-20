-- dmap_object_gen_tag : type : index name : fecxc_dep_especiales_02
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxc_dep_especiales_02 on fecxc_dep_especiales (no_empresa, id_tipo_operacion_set, no_cuenta, secuencia_dep_especiales);
