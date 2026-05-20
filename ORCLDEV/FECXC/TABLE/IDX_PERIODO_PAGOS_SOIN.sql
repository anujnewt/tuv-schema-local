-- dmap_object_gen_tag : type : index name : idx_periodo_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_periodo_pagos_soin on fecxp_enc_pagos_soin (((nullif(immutable_to_char(fecha_aplicacion,'YYYY'), '')::numeric)), ((nullif(immutable_to_char(fecha_aplicacion,'MM'), '')::numeric)));
CREATE INDEX "FECXC"."IDX_PERIODO_PAGOS_SOIN" ON "FECXC"."FECXP_ENC_PAGOS_SOIN" (TO_NUMBER(TO_CHAR("FECHA_APLICACION",'YYYY')), TO_NUMBER(TO_CHAR("FECHA_APLICACION",'MM'))) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
