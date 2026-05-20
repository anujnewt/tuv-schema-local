-- dmap_object_gen_tag : type : index name : fecxp_ajustes_saldos_finales00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ajustes_saldos_finales00 on fecxp_ajustes_saldos_finales (e_codigo, moneda, mes);
