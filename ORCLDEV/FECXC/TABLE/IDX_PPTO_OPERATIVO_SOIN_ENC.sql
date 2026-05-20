-- dmap_object_gen_tag : type : index name : idx_ppto_operativo_soin_enc
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_ppto_operativo_soin_enc on fecxp_ppto_operativo_soin_enc (periodo_origen, version_origen, estatus_origen);
