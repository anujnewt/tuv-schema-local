-- dmap_object_gen_tag : type : index name : porcentaje_iva_idx
set search_path = feci,oracle,dmap_extension,public;
create index porcentaje_iva_idx on feci_porcentaje_iva_cat (cod_porcentaje_iva, ind_estado);
