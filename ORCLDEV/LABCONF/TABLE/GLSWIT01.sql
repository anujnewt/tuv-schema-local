-- dmap_object_gen_tag : type : index name : glswit01
set search_path = labconf,oracle,dmap_extension,public;
create index glswit01 on glcoswit (swi_keytab, swi_keycam);
