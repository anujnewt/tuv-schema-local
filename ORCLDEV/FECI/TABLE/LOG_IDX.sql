-- dmap_object_gen_tag : type : index name : log_idx
set search_path = feci,oracle,dmap_extension,public;
create index log_idx on feci_log_tab (clave_rastreo);
