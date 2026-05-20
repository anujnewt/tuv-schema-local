create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_env_sol_rezagadas () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--selecciona los encabezados de las ordenes que no han sido insertados y que no tienen erorres
-- y que tienen al menos una linea bien que enviar
orc_enviar_cur cursor for
select er.id_solicitud
from   xxmor_solicitudes_est_rep_tab  er,
(select d.id_solicitud,
count(1)  --linea
from   xxmor_solicitudes_det_tab   d,
(select distinct id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  trunc(created_date) = trunc(clock_timestamp())
and    nullif(numlinea_concom::text, '') is not null
and    id_seg_neg          = 1
except
select distinct id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  trunc(created_date) = trunc(clock_timestamp())
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni      = '10'
and    id_seg_neg          = 1
)                           cr
where  trunc(d.created_date) = trunc(clock_timestamp())
and    d.id_solicitud        = cr.id_solicitud
and    d.linea               = cr.numlinea_concom
and    exists (select 1
from   xxmor_solicitudes_est_rep_tab er
where  trunc(er.created_date) = trunc(clock_timestamp())
and    er.id_solicitud        = d.id_solicitud
and    er.linea               = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null
)
group by d.id_solicitud
)                              lb
where  er.linea               = 0
and    er.id_solicitud        = lb.id_solicitud
and    nullif(er.estat_id_foraneo::text, '') is null
and    trunc(er.created_date) = trunc(clock_timestamp())
and    coalesce(aux3,0)           != 1 --no se esta insertando (proceso bpel)
and    (select ((p.valor_parametro/60)/(24*60)) + er.created_date
from   xxmor_conf_params_grls_tab p
where  nombre_parametro = 'pollingTimer'
)                      < clock_timestamp()
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud    = er.id_solicitud
and    c.estatus_orduni  = '10'
and    nullif(c.numlinea_concom::text, '') is null
);
v_temp      integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
for c_solicitud in orc_enviar_cur  loop
select xxmor_funcional_pkg_xxmor_env_sol_concom_fun(c_solicitud.id_solicitud)
into strict   v_temp
;
end loop;end;
$body$
language plpgsql
;
