-- dmap_object_gen_tag : type : index name : ind2_fecxp_ppto_opera_soin
set search_path = fecxc,oracle,dmap_extension,public;
create index ind2_fecxp_ppto_opera_soin on fecxp_ppto_operativo_soin (periodo_extraccion, mes_extraccion);
