-- dmap_object_gen_tag : type : index name : idx_periodo_ppto_erp_h
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_periodo_ppto_erp_h on fecxp_ppto_conversion_erp_h (periodo_extraccion, mes_extraccion);
