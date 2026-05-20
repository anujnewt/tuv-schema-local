-- dmap_object_gen_tag : type : table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_det_pagos_procesados"  (
e_codigo numeric(38) not null,
secuencia_pagos_erp numeric(38) not null,
secuencia_det_pagos_erp numeric(38) not null,
numero_de_partida_erp numeric(38) not null,
sec_det_pag_proc numeric(38) not null,
code_combination numeric(38),
importe_linea decimal(20, 4),
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados add constraint pk_fecxcp_det_pagos_procesados primary key (e_codigo,secuencia_pagos_erp,secuencia_det_pagos_erp,numero_de_partida_erp,sec_det_pag_proc);
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados alter column secuencia_det_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados alter column numero_de_partida_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_procesados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_procesados alter column sec_det_pag_proc set not null;
