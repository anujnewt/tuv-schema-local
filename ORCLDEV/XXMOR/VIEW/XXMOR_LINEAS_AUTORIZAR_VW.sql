-- dmap_object_gen_tag : type : view name : xxmor_lineas_autorizar_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_lineas_autorizar_vw"  ("id_solicitud", "linea") as select id_solicitud,
linea
from (select distinct
id_solicitud,
(numlinea_concom)::numeric  linea
from   xxmor_concom_rpta_tab r
where  r.id_seg_neg     = 1
and    r.estatus_orduni = '20'
and    not exists (select 1 -- el encabezado no tenga errores (reprocesos)
from   xxmor_concom_rpta_tab cr
where  cr.id_seg_neg           = 1
and    upper(cr.accion_concom) = 'REPROCESO'
and    cr.estatus_orduni       = '10'
and    cr.id_solicitud         = r.id_solicitud
and    nullif(cr.numlinea_concom::text, '') is null
)
and    not exists (select 1 -- las lineas no tengan errores (reprocesos)
from   xxmor_concom_rpta_tab cr
where  cr.id_seg_neg           = 1
and    upper(cr.accion_concom) = 'REPROCESO'
and    cr.estatus_orduni       = '10'
and    cr.id_solicitud         = r.id_solicitud
and    nullif(cr.numlinea_concom::text, '') is not null
and    cr.numlinea_concom      = r.numlinea_concom
)
and    not exists (select 1 -- las lineas de detalle que no han sido rechazadas
from   xxmor_concom_rpta_tab cr
where  cr.id_seg_neg      = 1
and    nullif(cr.numlinea_concom::text, '') is not null
and    cr.accion_concom   = 'RECHAZO'
and    cr.estatus_orduni  = '10'
and    cr.id_solicitud    = r.id_solicitud
and    cr.numlinea_concom = r.numlinea_concom
)
and not exists (select 1 -- las lineas de detalle que no han sido insertadas
from   xxmor_solicitudes_est_rep_tab er
where  er.id_sist          = 1
and    nullif(er.estat_id_foraneo::text, '') is not null
and    er.linea            != 0
and    er.id_solicitud     = r.id_solicitud
and    er.linea            = (r.numlinea_concom)::numeric
)
) alias8
where nullif(linea::text, '') is not null
order by  linea;/* dmap converted statement end */
-- estimed cost of view [ xxmor_lineas_autorizar_vw ]: 1.00;
