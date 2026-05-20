-- dmap_object_gen_tag : type : index name : idx_fecxp_monedas_mon_set_ns
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_monedas_mon_set_ns on fecxp_monedas_no_set (mes, mon_set);
