-- dmap_object_gen_tag : type : index name : feci_clasif_folio_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_clasif_folio_idx on feci_clasificacion_tab (folio_recibo, tipo_recibo);
