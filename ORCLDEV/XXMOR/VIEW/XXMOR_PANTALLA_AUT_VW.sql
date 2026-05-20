-- dmap_object_gen_tag : type : view name : xxmor_pantalla_aut_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_pantalla_aut_vw"  ("cred_corp", "sobrecargo", "mc_topado", "saldo_cps", "openlog", "urgente", "tarifa_manual", "reprocesar", "id_solicitud", "id_fza_ventas", "nombre_fza_ventas", "nom_archivo_sol", "create_date", "fecha_creacion", "advid", "clave_agencia", "prdid_desc", "referencia_folio", "rtcrd", "mcontid", "pl", "total_con_desc", "created_by", "id_prdg", "id_onair", "id_archivo_sol", "existen_errores", "id_request", "spot_chr") as select to_char(cred_corp)         cred_corp,
to_char(sobrecargo)        sobrecargo,
to_char(mc_topado)         mc_topado,
to_char(saldo_cps)         saldo_cps,
to_char(openlog)           openlog,
to_char(urgente)           urgente,
to_char(tarifa_manual)     tarifa_manual,
to_char(reprocesar)        reprocesar,
to_char(id_solicitud)      id_solicitud,
to_char(id_fza_ventas)     id_fza_ventas,
to_char(nombre_fza_ventas) nombre_fza_ventas,
to_char(nom_archivo_sol)   nom_archivo_sol,
to_char(create_date)       create_date,
fecha_creacion,
advid,
clave_agencia,
prdid_desc,
referencia_folio,
rtcrd,
mcontid,
pl,
total_con_desc,
created_by,
id_prdg,
id_onair,
to_char(id_archivo_sol)    id_archivo_sol,
to_char(existen_errores)   existen_errores,
to_char(id_request)        id_request,
to_char(spot_chr)          spot_chr
from   (select (case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)      = 'CRED_CORP'
and    upper(rc.accion_concom)     = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                  cred_corp,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)      = 'SOBRECARGO'
and    upper(rc.accion_concom)     = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                  sobrecargo,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.accion_concom)     = 'AUTORIZACION'
and    upper(rc.posicion_concom)   = 'ENCABEZADO'
and    position('MASTER TOPADO' in upper(rc.desc_concom))
> 0
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                  mc_topado,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)      = 'CPS'
and    upper(rc.accion_concom)     = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                  saldo_cps,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)      = 'OPENLOG'
and    upper(rc.accion_concom)     = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                                             openlog,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)     = 'URGENTE'
and    upper(rc.accion_concom)    = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud = se.id_solicitud::NUMERIC::NUMERIC
) > 0 then
1
else
0
end
)                                             urgente,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)     = 'TARIFA_MANUAL'
and    upper(rc.accion_concom)    = 'AUTORIZACION'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                                             tarifa_manual,
(select case when count(1)=0 then  0  else 1 end
from (select distinct id_solicitud
from (select distinct
crt.id_solicitud,
crt.numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni       = '10'
and    upper(crt.accion_concom) in ('REPROCESO', 'REENVIO')
except
select distinct
crt.id_solicitud,
crt.numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni = '10'
and    upper(crt.accion_concom) in ('RECHAZO', 'RETENCION')
) alias66
) re
where  re.id_solicitud = se.id_solicitud::NUMERIC
)                                             reprocesar,
se.id_solicitud,
se.id_fza_ventas,
fz.nombre_fza_ventas,
sol.nom_archivo_sol,
to_char(se.created_date,'YYYY-MM-DD HH24:MI') create_date,
trunc(se.created_date)                        fecha_creacion,
se.advid,
eo.accthdrid                                  clave_agencia,
se.prdid_desc,
eo.agyestnum                                  referencia_folio,
se.rtcrd,
se.mcontid,
se.proc_por_linea                             pl,
se.total_con_desc,
se.created_by,
r.estat_id_foraneo                            id_prdg,
ro.estat_id_foraneo                           id_onair,
sol.id_archivo_sol,
(case
when(select count(1)
from   xxmor_concom_rpta_tab rc
where  upper(rc.posicion_concom)   = 'LINEA'
and    coalesce(rc.estatus_orduni,'10') = '10'
and    rc.id_solicitud             = se.id_solicitud::NUMERIC
) > 0 then
1
else
0
end
)                                             existen_errores,
se.id_request,
(select count(1)
from   xxmor_solicitudes_det_tab
where  id_solicitud = se.id_solicitud::NUMERIC
and    spot_chr     in (1::VARCHAR,5::VARCHAR)
)                                             spot_chr
from xxmor_solicitudes_arch_tab sol, xxmor_fzas_vtas_tab fz, xxmor_solicitudes_orig_enc_tab eo, (select distinct crt.id_solicitud
from (select distinct
crt.id_solicitud,
crt.numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni       = '10'
and    upper(crt.accion_concom) in ('REPROCESO',
'REENVIO',
'AUTORIZACION'
)
group by crt.id_solicitud,
crt.numlinea_concom
except
select distinct
crt.id_solicitud,
crt.numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni = '10'
and    upper(crt.accion_concom) in ('RETENCION', 'RECHAZO')
group by crt.id_solicitud,
numlinea_concom
) crt
) cr, xxmor_solicitudes_enc_tab se
left outer join xxmor_solicitudes_est_rep_tab r on (se.id_solicitud = r.id_solicitud and 0 = r.linea and 1 = r.id_sist)
left outer join xxmor_solicitudes_est_rep_tab ro on (se.id_solicitud = ro.id_solicitud and 0 = ro.linea and 2 = ro.id_sist)
where se.orden_estatus != 46::VARCHAR and se.id_request     = eo.id_request::NUMERIC and eo.id_archivo_sol = sol.id_archivo_sol::NUMERIC and se.id_fza_ventas  = fz.id_fza_ventas::NUMERIC       and se.id_solicitud   = cr.id_solicitud::NUMERIC
) alias85;/* dmap converted statement end */
-- estimed cost of view [ xxmor_pantalla_aut_vw ]: 2.70;
