-- dmap_object_gen_tag : type : table name : fecxp_cancelados_sin_aplicado
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_cancelados_sin_aplicado"  (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_cancelados_sin_aplicado
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cancelados_sin_aplicado alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_cancelados_sin_aplicado
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cancelados_sin_aplicado alter column folio_set set not null;
