-- dmap_object_gen_tag : type : view name : xxmor_pantalla_archivos_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_pantalla_archivos_vw"  ("id_archivo_sol", "id_seg_neg", "nom_archivo_sol", "estatus", "desc_estatus", "num_ordenes", "observaciones", "create_date", "created_by") as select sa.id_archivo_sol,
sa.id_seg_neg,
sa.nom_archivo_sol,
sa.archivo_procesado estatus,
case when sa.archivo_procesado=1 then     'En Espera a Ser Procesado'                                   when sa.archivo_procesado=2 then     'En Proceso'                                   when sa.archivo_procesado=3 then     'Con Errores o Inconsistencias'                                   when sa.archivo_procesado=4 then     'Archivo leido,  ir a Estatus'              end  desc_estatus,
sa.num_ordenes,
sa.observaciones,
to_char(sa.created_date,  'YYYY-MM-DD HH24:MI') create_date,
sa.created_by
from   xxmor_solicitudes_arch_tab sa
where  sa.id_seg_neg = 1::NUMERIC;/* dmap converted statement end */
-- estimed cost of view [ xxmor_pantalla_archivos_vw ]: 1.00;
