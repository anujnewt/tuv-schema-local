-- dmap_object_gen_tag : type : index name : xxar_control_nc_n01
set search_path = labprod,oracle,dmap_extension,public;
create index xxar_control_nc_n01 on xxar_control_nc_tab (num_anio, num_mes, ind_tipo_pago, num_proceso, num_periodo, des_descripcion);
