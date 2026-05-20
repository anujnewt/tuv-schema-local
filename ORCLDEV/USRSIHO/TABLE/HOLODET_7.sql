-- dmap_object_gen_tag : type : index name : holodet_7
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodet_7 on holodetlla (det_keyemp desc, det_keyfol desc);
CREATE INDEX "USRSIHO"."HOLODET_7" ON "USRSIHO"."HOLODETLLA" ("DET_KEYEMP" DESC, "DET_KEYFOL" DESC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
