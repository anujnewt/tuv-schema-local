-- dmap_object_gen_tag : type : index name : moneda_presupuesto_soin_fk_h
set search_path = fecxc,oracle,dmap_extension,public;
create index moneda_presupuesto_soin_fk_h on fecxp_ppto_operativo_soin_h (moneda);
