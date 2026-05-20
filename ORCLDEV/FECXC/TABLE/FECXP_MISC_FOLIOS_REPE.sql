-- dmap_object_gen_tag : type : table name : fecxp_misc_folios_repe
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_misc_folios_repe"  (
no_folio_det numeric(38) not null,
cuantos numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_misc_folios_repe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_misc_folios_repe alter column no_folio_det set not null;
