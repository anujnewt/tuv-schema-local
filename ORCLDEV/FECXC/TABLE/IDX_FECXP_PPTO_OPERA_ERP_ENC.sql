-- dmap_object_gen_tag : type : index name : idx_fecxp_ppto_opera_erp_enc
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_ppto_opera_erp_enc on fecxp_ppto_opera_erp_enc (periodo_origen, version_origen, estatus_origen);
