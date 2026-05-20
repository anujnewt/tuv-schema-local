-- dmap_object_gen_tag : type : index name : pppmesidx_03
set search_path = labppto,oracle,dmap_extension,public;
create index pppmesidx_03 on ppempmes (emm_keyver, emm_keycia, emm_mes, emm_keyplz);
