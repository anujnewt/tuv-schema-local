-- dmap_object_gen_tag : type : table name : fecxp_crear_miscelaneos
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_crear_miscelaneos"  (
e_codigo numeric(38) not null,
folio_set numeric(38) not null,
secuencia_dep_especiales numeric(38),
secuencia_aplicada numeric(38),
estatus_din_cc_apli varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_crear_miscelaneos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_crear_miscelaneos alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_crear_miscelaneos
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_crear_miscelaneos alter column folio_set set not null;
