-- dmap_object_gen_tag : type : table name : fecxp_pagos_soin_clasif_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_pagos_soin_clasif_h"  (
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
numero_de_partida_soin numeric(38) not null,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3),
importe_linea decimal(20, 4),
concepto varchar(100),
beneficiario varchar(60),
no_cliente varchar(15),
des_empresa varchar(100),
no_cuenta numeric(38),
secuencia_det_pagos_soin numeric(38),
referencia varchar(30) default (null),
descripcion varchar(30),
id_version numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_soin_clasif_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_soin_clasif_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_soin_clasif_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_soin_clasif_h alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_soin_clasif_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_soin_clasif_h alter column tipo_operacion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_pagos_soin_clasif_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_pagos_soin_clasif_h alter column numero_de_partida_soin set not null;
