-- dmap_object_gen_tag : type : index name : fecxp_ingresos_clasif04
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ingresos_clasif04 on fecxp_ingresos_clasif (e_codigo, fecha);
CREATE INDEX fecxp_ingresos_clasif04 ON fecxc."fecxp_ingresos_clasif" (e_codigo,fecha);
