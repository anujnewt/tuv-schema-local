-- dmap_object_gen_tag : type : index name : recibo_manual_idx
set search_path = feci,oracle,dmap_extension,public;
create index recibo_manual_idx on feci_recibo_manual_tab (folio_recibo_manual, fec_operativa, cod_empresa, cod_estado_recibo, ind_estado);
