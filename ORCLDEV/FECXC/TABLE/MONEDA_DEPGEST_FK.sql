-- dmap_object_gen_tag : type : index name : moneda_depgest_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index moneda_depgest_fk on fecxc_enc_impges (secmoneda);
