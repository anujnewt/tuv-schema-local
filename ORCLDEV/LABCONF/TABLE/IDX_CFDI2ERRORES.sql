-- dmap_object_gen_tag : type : index name : idx_cfdi2errores
set search_path = labconf,oracle,dmap_extension,public;
create index idx_cfdi2errores on cfdi2errores (idcomprobanteemp);
