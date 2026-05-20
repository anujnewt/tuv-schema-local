-- dmap_object_gen_tag : type : index name : idx_fec_valor_original
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fec_valor_original on fecxc_enc_clasificados (fec_valor_original);
