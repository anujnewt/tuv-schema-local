-- dmap_object_gen_tag : type : view name : xxmor_arch_fza_vtas_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_arch_fza_vtas_vw"  ("id_fza_ventas", "id_archivo_fza", "nombre_fza_ventas", "ident_fza_ventas", "nombre_archivo_fza", "desc_archivo_fza", "created_by", "created_date") as select   afv.id_fza_ventas,
afv.id_archivo_fza,
fv.nombre_fza_ventas,
fv.ident_fza_ventas,
afv.nombre_archivo_fza,
afv.desc_archivo_fza,
afv.created_by,
afv.created_date
from   xxmor_fzas_vtas_archivos_tab afv, xxmor_fzas_vtas_tab fv
where   afv.id_fza_ventas = fv.id_fza_ventas
order by    1,
3,
4,
5
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_arch_fza_vtas_vw ]: 1.00;
