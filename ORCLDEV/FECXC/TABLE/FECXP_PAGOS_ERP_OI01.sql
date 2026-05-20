-- dmap_object_gen_tag : type : index name : fecxp_pagos_erp_oi01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_pagos_erp_oi01 on fecxp_pagos_erp_oi (e_codigo, tipo_operacion, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7);
