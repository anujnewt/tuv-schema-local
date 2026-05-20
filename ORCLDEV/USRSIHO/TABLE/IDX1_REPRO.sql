-- dmap_object_gen_tag : type : index name : idx1_repro
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx1_repro on reprocesos (rep_status, rep_ejercicio);
