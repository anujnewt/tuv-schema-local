-- dmap_object_gen_tag : type : index name : idx_cfdi2nomina
set search_path = labprod,oracle,dmap_extension,public;
create index idx_cfdi2nomina on cfdi2nomina (idcomprobanteemp);
