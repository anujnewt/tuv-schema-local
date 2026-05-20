-- dmap_object_gen_tag : type : table name : fecxp_crear_aperturados
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_crear_aperturados"  (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_pagos_erp numeric(38) not null,
secuencia_aplicada numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_crear_aperturados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_crear_aperturados add constraint pk_fecxp_crear_aperturados primary key (e_codigo,secuencia_pagos_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_crear_aperturados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_crear_aperturados alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_crear_aperturados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_crear_aperturados alter column folio_set set not null;
