-- dmap_object_gen_tag : type : index name : partopidx02
set search_path = labppto,oracle,dmap_extension,public;
create index partopidx02 on pppartop (top_keycia, top_keyver, top_keypro, top_cvezon);
