-- dmap_object_gen_tag : type : table name : fecxp_fact_folios_var
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_fact_folios_var"  (
no_folio_det numeric(38) not null,
cuantos numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_folios_var
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_folios_var alter column no_folio_det set not null;
