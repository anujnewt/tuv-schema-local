-- dmap_object_gen_tag : type : index name : fecxp_imprtacn_dts_hist01_r
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_imprtacn_dts_hist01_r on fecxp_importacion_datos_hist_r (((nullif(immutable_to_char(fecha,'YYYY'), '')::numeric)), mes);
CREATE INDEX "FECXC"."FECXP_IMPRTACN_DTS_HIST01_R" ON "FECXC"."FECXP_IMPORTACION_DATOS_HIST_R" (TO_NUMBER(TO_CHAR("FECHA",'YYYY')), "MES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
