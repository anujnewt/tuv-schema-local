-- dmap_object_gen_tag : type : index name : idx_cfdi2comprobanteemp02
set search_path = labprod,oracle,dmap_extension,public;
create index idx_cfdi2comprobanteemp02 on cfdi2comprobanteemp (idcomprobantepro, com_keyemp);
