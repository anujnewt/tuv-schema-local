-- dmap_object_gen_tag : type : index name : holodetra_kaz01
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodetra_kaz01 on holodettra (det_keypue, det_tipinc, det_stsreg);
