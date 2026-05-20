-- dmap_object_gen_tag : type : index name : idx_nmlocepro
set search_path = labprod,oracle,dmap_extension,public;
create index idx_nmlocepro on nmlocepro (cen_keycen);
