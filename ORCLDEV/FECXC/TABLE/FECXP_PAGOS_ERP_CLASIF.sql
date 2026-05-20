-- dmap_object_gen_tag : type : table name : fecxp_pagos_erp_clasif
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_pagos_erp_clasif"  (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
tipo_operacion numeric(38) not null,
estatus_movimiento varchar(1),
id_chequera varchar(11),
id_banco numeric(38),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20, 11),
origen_movimiento varchar(3),
importe decimal(20, 2),
numero_de_partida_erp numeric(38) not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
importe_linea decimal(20, 4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
sec_det_pag_proc numeric(38),
referencia varchar(30) default (null),
descripcion varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_erp_clasif
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_erp_clasif alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_erp_clasif
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_erp_clasif alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_erp_clasif
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_erp_clasif alter column tipo_operacion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_erp_clasif
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_erp_clasif alter column numero_de_partida_erp set not null;
