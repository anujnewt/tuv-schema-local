-- dmap_object_gen_tag : type : index name : idx_cfdicomprobanteemp01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_cfdicomprobanteemp01 on cfdicomprobanteemp (serie, folio);
