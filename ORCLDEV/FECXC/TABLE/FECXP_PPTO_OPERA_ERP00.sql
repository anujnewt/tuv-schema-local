-- dmap_object_gen_tag : type : index name : fecxp_ppto_opera_erp00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ppto_opera_erp00 on fecxp_ppto_opera_erp (periodo_extraccion, mes_de_extraccion);
