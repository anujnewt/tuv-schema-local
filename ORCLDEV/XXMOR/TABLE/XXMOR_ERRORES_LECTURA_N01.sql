-- dmap_object_gen_tag : type : index name : xxmor_errores_lectura_n01
set search_path = xxmor,oracle,dmap_extension,public;
create index xxmor_errores_lectura_n01 on xxmor_errores_lectura_arch_tab (id_archivo);
