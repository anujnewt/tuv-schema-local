-- dmap_object_gen_tag : type : index name : fecxp_ajustes_saldos_finalesd0
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ajustes_saldos_finalesd0 on fecxp_ajustes_saldos_finalesd (e_codigo, moneda, fecha);
