-- dmap_object_gen_tag : type : index name : fecxp_ppto_opera_erp00_h
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ppto_opera_erp00_h on fecxp_ppto_opera_erp_h (periodo_extraccion, mes_de_extraccion, id_version);
