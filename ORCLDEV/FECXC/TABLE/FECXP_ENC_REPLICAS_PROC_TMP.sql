-- dmap_object_gen_tag : type : table name : fecxp_enc_replicas_proc_tmp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_enc_replicas_proc_tmp"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
fecha_aplicacion timestamp(0),
importe decimal(20, 2),
estatus_movimiento varchar(1),
estatus_de_ingreso varchar(1) default 'P',
procesado numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_replicas_proc_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_replicas_proc_tmp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_replicas_proc_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_replicas_proc_tmp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_replicas_proc_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_replicas_proc_tmp alter column folio_set set not null;
