-- dmap_object_gen_tag : type : index name : idx_folio_empresa
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_folio_empresa on fecxc_enc_impges (e_codigo, codfolio);
