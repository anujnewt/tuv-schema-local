-- dmap_object_gen_tag : type : index name : fecxp_ingresos_clasif01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ingresos_clasif01 on fecxp_ingresos_clasif (e_codigo, folio_set);
CREATE INDEX fecxp_ingresos_clasif01 ON fecxc."fecxp_ingresos_clasif" (e_codigo,folio_set);
