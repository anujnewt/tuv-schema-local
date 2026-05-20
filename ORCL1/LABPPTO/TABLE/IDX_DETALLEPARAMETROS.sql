-- dmap_object_gen_tag : type : index name : idx_detalleparametros
set search_path = labppto,oracle,dmap_extension,public;
create index idx_detalleparametros on detalleparametros (enq_keyrep, orden);
