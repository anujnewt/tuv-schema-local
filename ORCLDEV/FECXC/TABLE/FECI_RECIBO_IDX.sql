-- dmap_object_gen_tag : type : index name : feci_recibo_idx
set search_path = fecxc,oracle,dmap_extension,public;
create index feci_recibo_idx on feci_recibo_tab (fec_operativa, cod_empresa, clase_cliente);
