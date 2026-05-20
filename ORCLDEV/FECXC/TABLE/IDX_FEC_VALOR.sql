-- dmap_object_gen_tag : type : index name : idx_fec_valor
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fec_valor on fecxc_enc_clasificados (fec_valor);
