-- dmap_object_gen_tag : type : index name : fecxp_imprtacn_datos_hist01_h
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_imprtacn_datos_hist01_h on fecxp_importacion_datos_hist_h (((nullif(immutable_to_char(fecha,'YYYY'), '')::numeric)), mes);
CREATE INDEX "FECXC"."FECXP_IMPRTACN_DATOS_HIST01_H" ON "FECXC"."FECXP_IMPORTACION_DATOS_HIST_H" (TO_NUMBER(TO_CHAR("FECHA",'YYYY')), "MES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
