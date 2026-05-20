-- dmap_object_gen_tag : type : index name : flujo_vs_operac_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index flujo_vs_operac_fk on fecxc_mapeo_fl_opera (id_tipo_operacion);
