-- dmap_object_gen_tag : type : index name : fecxp_imp_dat_hist01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_imp_dat_hist01 on fecxp_imp_dat_hist (((nullif(immutable_to_char(fecha,'YYYY'), '')::numeric)), mes);
CREATE INDEX "FECXC"."FECXP_IMP_DAT_HIST01" ON "FECXC"."FECXP_IMP_DAT_HIST" (TO_NUMBER(TO_CHAR("FECHA",'YYYY')), "MES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
