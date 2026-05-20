-- dmap_object_gen_tag : type : index name : flujo_operacion_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index flujo_operacion_fk on fecxc_mapeo_fl_opera (cod_sec_tipcat, cod_sec_lin);
