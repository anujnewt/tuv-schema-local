-- dmap_object_gen_tag : type : table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_det_pagos_erp"  (
secuencia_det_pagos_erp numeric(38) not null,
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
numero_de_partida_erp numeric(38) not null,
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
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp add constraint pk_fecxp_det_pagos_erp primary key (e_codigo,secuencia_pagos_erp,secuencia_det_pagos_erp,numero_de_partida_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp alter column secuencia_det_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp alter column numero_de_partida_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_erp add constraint fk_fecxp_de_pagos_ora_fecxp_en foreign key (e_codigo,secuencia_pagos_erp) references fecxp_enc_pagos_erp(e_codigo,secuencia_pagos_erp) on delete no action not deferrable initially immediate;
