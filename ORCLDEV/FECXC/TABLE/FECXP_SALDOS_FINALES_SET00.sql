-- dmap_object_gen_tag : type : index name : fecxp_saldos_finales_set00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_saldos_finales_set00 on fecxp_saldos_finales_set (e_codigo, moneda, mes);
