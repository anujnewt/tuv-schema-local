-- dmap_object_gen_tag : type : table name : fecxp_ape_det_tmp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ape_det_tmp"  (
e_codigo numeric(38) not null,
folio_set varchar(150) not null,
secuencia_pagos_erp numeric(38) not null,
secuencia_cont_din_aper_det numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ape_det_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ape_det_tmp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ape_det_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ape_det_tmp alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ape_det_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ape_det_tmp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ape_det_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ape_det_tmp alter column secuencia_cont_din_aper_det set not null;
