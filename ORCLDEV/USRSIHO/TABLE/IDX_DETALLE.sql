-- dmap_object_gen_tag : type : index name : idx_detalle
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_detalle on holodetp1 (det_keypol);
