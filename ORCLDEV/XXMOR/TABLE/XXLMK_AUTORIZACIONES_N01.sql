-- dmap_object_gen_tag : type : index name : xxlmk_autorizaciones_n01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxlmk_autorizaciones_n01 on xxlmk_autorizaciones_tab (id_orden, ind_tipo_aut, ind_estatus);
