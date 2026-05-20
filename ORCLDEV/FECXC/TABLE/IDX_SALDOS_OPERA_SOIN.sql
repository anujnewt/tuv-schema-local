-- dmap_object_gen_tag : type : index name : idx_saldos_opera_soin
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_saldos_opera_soin on fecxp_saldos_operativo_soin (e_codigo, ctam01, ctam02, ctam03);
