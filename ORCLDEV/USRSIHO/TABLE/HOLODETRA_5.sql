-- dmap_object_gen_tag : type : index name : holodetra_5
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodetra_5 on holodettra (det_keydep, det_keyfol, det_stsreg);
