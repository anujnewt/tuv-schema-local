-- dmap_object_gen_tag : type : index name : pk_cuentas
set search_path = labconf,oracle,dmap_extension,public;
create index pk_cuentas on cuentas (proceso, periodo);
