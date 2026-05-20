-- dmap_object_gen_tag : type : index name : pre_moneda_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index pre_moneda_fk on fecxc_enc_de_presu (secmoneda);
