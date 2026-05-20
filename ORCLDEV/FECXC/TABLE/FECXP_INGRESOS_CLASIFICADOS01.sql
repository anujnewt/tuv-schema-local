-- dmap_object_gen_tag : type : index name : fecxp_ingresos_clasificados01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ingresos_clasificados01 on fecxp_ingresos_clasificados (e_codigo, folio_set);
