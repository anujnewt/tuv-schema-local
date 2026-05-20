-- dmap_object_gen_tag : type : index name : idx_fecxp_ppto_cnvrsn_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_ppto_cnvrsn_erp_h on fecxp_ppto_conversion_erp_h (e_codigo, version_fe, periodo, mes, libro_id, version_id, moneda, code_combination, id_version);
