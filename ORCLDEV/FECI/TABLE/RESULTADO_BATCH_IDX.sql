-- dmap_object_gen_tag : type : index name : resultado_batch_idx
set search_path = feci,oracle,dmap_extension,public;
create index resultado_batch_idx on feci_resultado_batch_tab (fec_inicio, ind_estado);
