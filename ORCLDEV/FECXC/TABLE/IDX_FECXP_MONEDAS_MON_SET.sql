-- dmap_object_gen_tag : type : index name : idx_fecxp_monedas_mon_set
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecxp_monedas_mon_set on fecxp_monedas (mes, mon_set);
