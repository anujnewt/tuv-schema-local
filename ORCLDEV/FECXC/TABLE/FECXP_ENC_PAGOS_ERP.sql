-- dmap_object_gen_tag : type : table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_enc_pagos_erp"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
secmoneda numeric(38),
folio_set varchar(150) not null,
periodo numeric(38),
cve_operacion numeric(38),
estatus_movimiento varchar(1),
no_cheque numeric(38),
id_chequera varchar(11),
id_banco numeric(38),
importe decimal(20, 2),
forma_pago numeric(38),
fecha_aplicacion timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20, 11),
origen_movimiento varchar(3),
estatus_de_ingreso varchar(1) default 'P',
procesado numeric(38) default 0,
tipo_operacion numeric(38),
no_cliente varchar(15),
id_banco_benef numeric(38),
id_chequera_benef varchar(11),
lote_entrada numeric(38),
no_docto numeric(38),
concepto varchar(100),
beneficiario varchar(60),
fecha_actualizacion timestamp(0),
nom_empresa varchar(100),
no_cuenta numeric(38) default (0),
folio_ref numeric(38) default (0),
nom_empresa_rel varchar(100),
referencia varchar(30) default (null),
descripcion varchar(30)
) ;
-- function used in indexes must be immutable, use immutable_to_char() instead of to_char()
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp add constraint pk_fecxp_enc_pagos_erp primary key (e_codigo,secuencia_pagos_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp add constraint ckc_estatus_de_ingres_fecxp_en check (estatus_de_ingreso is null or ( estatus_de_ingreso in ('P','M') ));
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp add constraint ckc_procesado_fecxp_en check (procesado is null or ( procesado in (0,1) ));
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp add constraint fk_fecxp_pagos_monoracle foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
