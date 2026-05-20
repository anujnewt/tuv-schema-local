-- dmap_object_gen_tag : type : index name : idx_pplopira
set search_path = labppto,oracle,dmap_extension,public;
create index idx_pplopira on pplopira (pir_keycia, pir_keyver, pir_importe);
