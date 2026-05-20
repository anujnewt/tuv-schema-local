-- dmap_object_gen_tag : type : index name : cat_enc_det_catalog_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index cat_enc_det_catalog_fk on fecxc_det_catalogos (cod_sec_tipcat);
