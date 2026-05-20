-- dmap_object_gen_tag : type : index name : idx_cfdi2comprobanteemp01
set search_path = labconf,oracle,dmap_extension,public;
create index idx_cfdi2comprobanteemp01 on cfdi2comprobanteemp (serie, folio);
