-- dmap_object_gen_tag : type : index name : idx_01
set search_path = usrsiho,oracle,dmap_extension,public;
create index idx_01 on holodetp1 (det_cargos, det_abonos);
