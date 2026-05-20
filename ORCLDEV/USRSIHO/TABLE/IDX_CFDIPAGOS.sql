-- dmap_object_gen_tag : type : index name : idx_cfdipagos
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_cfdipagos on cfdipagos (pag_cvepol);
