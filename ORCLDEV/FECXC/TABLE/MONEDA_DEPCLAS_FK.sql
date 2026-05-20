-- dmap_object_gen_tag : type : index name : moneda_depclas_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index moneda_depclas_fk on fecxc_enc_clasificados (secmoneda);
