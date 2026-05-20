-- dmap_object_gen_tag : type : table name : fecxp_replicas_por_cerrar
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_replicas_por_cerrar"  (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38),
secuencia_aplicada numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_replicas_por_cerrar
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_replicas_por_cerrar add constraint pk_fecxp_replicas_por_cerrar primary key (e_codigo,folio_set);
-- dmap_object_gen_tag : type : alter table name : fecxp_replicas_por_cerrar
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_replicas_por_cerrar alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_replicas_por_cerrar
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_replicas_por_cerrar alter column folio_set set not null;
