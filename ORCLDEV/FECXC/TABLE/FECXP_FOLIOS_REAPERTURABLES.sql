-- dmap_object_gen_tag : type : table name : fecxp_folios_reaperturables
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_folios_reaperturables"  (
folio_set varchar(150) not null,
e_codigo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_folios_reaperturables
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_folios_reaperturables alter column folio_set set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_folios_reaperturables
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_folios_reaperturables alter column e_codigo set not null;
