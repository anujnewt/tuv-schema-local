-- dmap_object_gen_tag : type : index name : idx_fe_extrae_folios
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fe_extrae_folios on fe_extrae_folios (no_empresa, folio, id_banco, id_chequera, fecha, tipo_operacion);
