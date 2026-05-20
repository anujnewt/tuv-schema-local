-- dmap_object_gen_tag : type : index name : fecxc_dep_especiales_fa_tonum
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxc_dep_especiales_fa_tonum on fecxc_dep_especiales (((nullif(immutable_to_char(fec_valor,'MM'), '')::numeric)));
CREATE INDEX "FECXC"."FECXC_DEP_ESPECIALES_FA_TONUM" ON "FECXC"."FECXC_DEP_ESPECIALES" (TO_NUMBER(TO_CHAR("FEC_VALOR",'MM'))) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
