-- dmap_object_gen_tag : type : index name : idx_moneda_codigo
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_moneda_codigo on fecxc_enc_impges (secmoneda, e_codigo);
