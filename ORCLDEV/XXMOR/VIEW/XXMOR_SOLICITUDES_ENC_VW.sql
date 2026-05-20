-- dmap_object_gen_tag : type : view name : xxmor_solicitudes_enc_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_solicitudes_enc_vw"  ("id_solicitud", "id_request", "id_fza_ventas", "err_id_fza_ventas", "nombre_fza_ventas", "err_nombre_fza_ventas", "id_solicitud_hna", "proc_por_linea", "err_proc_por_linea", "garantizado", "err_garantizado", "advid", "err_advid", "mcontid", "err_mcontid", "mcontid_cutin", "err_mcontid_cutin", "email", "err_email", "agyestnum", "err_agyestnum", "accthdrid", "err_accthdrid", "rtcrddscr", "err_rtcrddscr", "rtcrd", "err_rtcrd", "rtcrddscr_cutin", "err_rtcrddscr_cutin", "comentarios", "err_comentarios", "secnum", "err_secnum", "plataforma_canal", "err_plataforma_canal", "agrupador", "err_agrupador", "prdid_desc", "err_prdid_desc", "prdid", "err_prdid", "total_spots", "err_total_spots", "total_con_desc", "err_total_con_desc", "total_sin_desc", "err_total_sin_desc", "tipo_facturacion", "err_tipo_facturacion", "descuento", "err_descuento", "target", "err_target", "orden_estatus", "desc_notificacion", "err_desc_notificacion", "total_efectivo", "cred_corp", "saldo_cps", "saldo_master_contract", "aut_cred_corp", "aut_saldo_cps", "aut_mc_topado") as select se.id_solicitud,
se.id_request,
se.id_fza_ventas,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'FZA_VENTAS'
)
, 0)                             as err_id_fza_ventas,
fz.nombre_fza_ventas,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'FZA_VENTAS'
)
, 0)                             as err_nombre_fza_ventas,
se.id_solicitud_hna,
(case when nullif(se.proc_por_linea::text,  '') is not null then 'SI' else 'NO' end) proc_por_linea,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'PROC_POR_LINEA'
)
, 0)                             as err_proc_por_linea,
se.garantizado,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'GARANTIZADO'
)
, 0)                            as err_garantizado,
se.advid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'ADVID'
)
, 0)                             as err_advid,
se.mcontid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'MCONTID'
)
, 0)                             as err_mcontid,
se.mcontid_cutin,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'MCONTID'
)
, 0)                             as err_mcontid_cutin,
se.email,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'EMAIL'
)
, 0)                             as err_email,
se.agyestnum,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'AGYESTNUM'
)
, 0)                             as err_agyestnum,
se.accthdrid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'ACCTHDRID'
)
, 0)                             as err_accthdrid,
se.rtcrddscr,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'RTCRD'
)
, 0)                             as err_rtcrddscr,
se.rtcrd,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'RTCRDSCR'
)
, 0)                             as err_rtcrd,
se.rtcrddscr_cutin,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(   se.id_solicitud,
null,
'MCONTID'
)
, 0)                             as err_rtcrddscr_cutin,
se.comentarios,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'COMENTARIOS'
)
, 0)                             as err_comentarios,
se.secnum,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'SECNUM'
)
, 0)                             as err_secnum,
se.plataforma_canal,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'PLATAFORMA_CANAL'
)
, 0)                             as err_plataforma_canal,
se.agrupador,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'AGRUPADOR'
)
, 0)                             as err_agrupador,
se.prdid_desc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'PRDID_DESC'
)
, 0)                             as err_prdid_desc,
se.prdid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'PRDID'
)
, 0)                             as err_prdid,
coalesce(se.total_spots,  xxmor_funcional_pkg_xxmor_sol_totales_fun(    se.id_solicitud,
null,
'SP_X_O'
)
)                                as total_spots,
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'TOTAL_SPOTS_PAQUETES'
)          err_total_spots,
xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun(    se.id_solicitud,
null,
'TCD_X_O'
)          total_con_desc,
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'TOT_LINEA_CON_DESC'
)          err_total_con_desc,
xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun(    se.id_solicitud,
null,
'TSD_X_O'
),
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'TOT_LINEA_SIN_DESC'
)          err_total_sin_desc,
se.tipo_facturacion,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'TIPO_FACTURACION'
)
, 0)                             as err_tipo_facturacion,
se.descuento,
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'DESCUENTO'
)          err_descuento,
se.target,
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun(    se.id_solicitud,
null,
'TARGET'
)          err_target,
xxmor_funcional_pkg_xxmor_orden_estatus_fun(    se.id_solicitud,
null,
'ESTATUS_ORD_N'
)                as orden_estatus,
(select desc_notificacion
from   xxmor_ordenes_estatus_tab
where  id_notificacion = xxmor_funcional_pkg_xxmor_orden_estatus_fun(    se.id_solicitud,
null,
'ESTATUS_ORD_N'
)
)                                   as desc_notificacion,
'0'                                 err_desc_notificacion,
(select sum(tot_linea_sin_desc)
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_est_rep_tab er
where  d.id_solicitud = se.id_solicitud
and    d.id_solicitud = er.id_solicitud
and    d.linea        = er.linea
and    er.estat_rep  != 2
)                                   as total_efectivo,
(case
when(select count(1)
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'CRED_CORP'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
) > 0 then
1
else
0
end
)                                   cred_corp,
(case
when(select count(1)
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'CPS'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
) > 0 then
1
else
0
end
)                                   saldo_cps,
(case
when(select count(1)
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
) > 0 then
1
else
0
end
)                                   saldo_master_contract,
coalesce((select xcr.desc_concom||'/'||xcr.detalle_concom
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'CRED_CORP'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
),'0'
)                                aut_cred_corp,
coalesce((select xcr.desc_concom||'/'||xcr.detalle_concom
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'CPS'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
),'0'
)                                aut_saldo_cps,
coalesce((select xcr.desc_concom||'/'||xcr.detalle_concom
from   xxmor_concom_rpta_tab xcr
where  upper(xcr.campo_concom)      = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
and    upper(xcr.posicion_concom)   = 'ENCABEZADO'
and    upper(xcr.accion_concom)     = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    xcr.id_solicitud             = se.id_solicitud
and    xcr.id_rpta_concom           = (select max(rc.id_rpta_concom)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)       = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT'
and    upper(rc.posicion_concom)    = 'ENCABEZADO'
and    upper(rc.accion_concom)      = 'AUTORIZACION'
and    coalesce(xcr.estatus_orduni,'10') = '10'
and    rc.id_solicitud              = xcr.id_solicitud
)
),'0'
)                                aut_mc_topado
from   xxmor_solicitudes_enc_tab se,
xxmor_fzas_vtas_tab       fz
where  se.id_seg_neg    = 1
and    se.id_fza_ventas = fz.id_fza_ventas;/* dmap converted statement end */
-- estimed cost of view [ xxmor_solicitudes_enc_vw ]: 1.60;
