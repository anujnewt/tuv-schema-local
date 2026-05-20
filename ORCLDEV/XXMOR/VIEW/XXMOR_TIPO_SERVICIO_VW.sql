-- dmap_object_gen_tag : type : view name : xxmor_tipo_servicio_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_"tipo_servicio"_vw"  (tipo_servicio) as select   inclusion || '-' || sptchr ||':'|| usrchr as tipo_servicio
from   xxmor_conf_tipo_srv_tab
group by   inclusion, sptchr, usrchr
order by    inclusion, sptchr, usrchr
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_tipo_servicio_vw ]: 1.40;
