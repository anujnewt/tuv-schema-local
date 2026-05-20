-- dmap_object_gen_tag : type : index name : fecxp_importacion_datos_ns01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_importacion_datos_ns01 on fecxp_importacion_datos_ns (((nullif(immutable_to_char(fecha,'YYYY'), '')::numeric)), mes);
CREATE INDEX "FECXC"."FECXP_IMPORTACION_DATOS_NS01" ON "FECXC"."FECXP_IMPORTACION_DATOS_NS" (TO_NUMBER(TO_CHAR("FECHA",'YYYY')), "MES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
