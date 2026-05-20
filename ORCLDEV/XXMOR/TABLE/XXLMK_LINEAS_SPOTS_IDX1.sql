-- dmap_object_gen_tag : type : index name : xxlmk_lineas_spots_idx1
set search_path = xxmor,oracle,dmap_extension,public;
create index xxlmk_lineas_spots_idx1 on xxlmk_lineas_spots_tab (id_linea, ind_estatus);
