-- dmap_object_gen_tag : type : index name : fecxp_ingresos_clasif02
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_ingresos_clasif02 on fecxp_ingresos_clasif (tipo_operacion);
CREATE INDEX fecxp_ingresos_clasif02 ON fecxc."fecxp_ingresos_clasif" (tipo_operacion);
