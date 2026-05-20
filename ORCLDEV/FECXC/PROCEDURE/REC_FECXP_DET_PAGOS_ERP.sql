-- dmap_object_gen_tag : type : procedure name : rec_fecxp_det_pagos_erp;
set search_path = fecxc,oracle,dmap_extension,public;
drop type  if exists rec_fecxp_det_pagos_erp;
-- dmap_object_gen_tag : type : procedure name : FECXC.rec_fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
create type FECXC.rec_fecxp_det_pagos_erp as (secuencia_det_pagos_erp  integer,secuencia_pagos_erp      integer,e_codigo                 integer,numero_de_partida_erp    integer,code_combination         integer,importe_linea            numeric,oracle_segmento1         varchar(25),oracle_segmento2         varchar(25),oracle_segmento3         varchar(25),oracle_segmento4         varchar(25),oracle_segmento5         varchar(25),oracle_segmento6         varchar(25),oracle_segmento7         varchar(25));
