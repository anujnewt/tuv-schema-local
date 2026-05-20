-- dmap_object_gen_tag : type : view name : xxmor_pantalla_est_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_pantalla_est_vw"  ("id_solicitud", "id_fza_ventas", "inf_orden", "id_prdg", "id_onair", "nom_archivo_sol", "id_archivo_sol", "orden_estatus", "nombre_fza_ventas", "error_linea", "error_para", "create_date", "fecha_creacion", "created_by") as select se.id_solicitud,
se.id_fza_ventas,
null                                            inf_orden,
(select er.estat_id_foraneo
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud = se.id_solicitud
and    er.linea        = 0
and    er.id_sist      = 1
)                                               id_prdg,
null                                            id_onair,
sa.nom_archivo_sol,
sa.id_archivo_sol,
xxmor_funcional_pkg_xxmor_orden_estatus_fun(
se.id_solicitud,
null,
'ESTATUS_ORDEN'
)                            orden_estatus,
fv.nombre_fza_ventas,
1,
coalesce((select coalesce(ser.estat_error_msg, '0')
from   xxmor_solicitudes_est_rep_tab ser
where  ser.id_solicitud = se.id_solicitud
and    ser.linea        = 0
and    ser.id_sist      = 1
), '0')                                     error_para,
to_char(se.created_date, 'YYYY-MM-DD HH24:MI')  create_date,
trunc(se.created_date)                          fecha_creacion,
se.created_by
from   xxmor_solicitudes_enc_tab      se,
xxmor_solicitudes_orig_enc_tab so,
xxmor_solicitudes_arch_tab     sa,
xxmor_fzas_vtas_tab            fv
where  se.id_request     = so.id_request
and    so.id_seg_neg     = sa.id_seg_neg
and    so.id_archivo_sol = sa.id_archivo_sol
and    se.id_seg_neg     = fv.id_seg_neg
and    se.id_fza_ventas  = fv.id_fza_ventas
order by  se.id_solicitud desc;/* dmap converted statement end */
-- estimed cost of view [ xxmor_pantalla_est_vw ]: 1.00;
