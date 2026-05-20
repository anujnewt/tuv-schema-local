-- dmap_object_gen_tag : type : index name : tiposdecambio_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index tiposdecambio_fk on fecxc_tpc (secmoneda);
