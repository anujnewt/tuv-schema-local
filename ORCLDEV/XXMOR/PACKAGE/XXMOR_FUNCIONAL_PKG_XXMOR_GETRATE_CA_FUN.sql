create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_getrate_ca_fun ( p_id_solicitud integer, p_linea integer, p_tipo varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_rtcrddscr   varchar(50);
v_diasemana   varchar(10);
v_stnid       varchar(15);
v_duracion integer;
v_hora_ini    varchar(10);
v_hora_fin    varchar(10);
v_fecha_ini   varchar(10);
v_tarifa      numeric;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select xxmor_funcional_pkg_xxmor_sol_fechas_fun(p_id_solicitud,p_linea,'F_1A_T')
into strict   v_fecha_ini
;/* dmap converted statement start */
select rtcrddscr,
case when (sabado)::numeric  > 1 then 'S'
when (domingo)::numeric  > 1 then 'D'
else 'L-V' end,
d.stnid,
d.duracion,
oracle. concat(substr(hora_inicio,1,2), ':', oracle.substr(hora_inicio,3,2)) ,
oracle. concat(substr(hora_fin,1,2), ':', oracle.substr(hora_fin,3,2)) ,
oracle. concat(substr(v_fecha_ini,1,4), '-', oracle.substr(v_fecha_ini,5,2), '-', oracle.substr(v_fecha_ini,7,2)
) into strict   v_rtcrddscr, v_diasemana, v_stnid, v_duracion, v_hora_ini,  v_hora_fin, v_fecha_ini
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    d.linea        = p_linea
and    e.id_solicitud = d.id_solicitud;/* dmap converted statement end */
-- p_tipo  si es cbsky, cv o sk
if p_tipo != 'CBSKY' then
select replace(e.rtcrddscr, am.ca_rtcrd_substr, am.ca_rtcrd_aux) as rtcrd_tmp
into strict   v_rtcrddscr
from   xxmor_solicitudes_enc_tab e,
xxmor_cat_agrupador_mult_tab am
where  id_solicitud     = p_id_solicitud
and    e.agrupador      = am.agrupador_multiple
and    am.prefijo_canal = (select oracle.substr(stnid,0,2)
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = e.id_solicitud
limit 1);
end if;
select max(cst.tarifa) tarifa
into strict   v_tarifa
from   eventas.ca_costos__ordunidb2 cst
left join eventas.ca_franja_dia__ordunidb2 frd
on (cst.idfranjadia = frd.idfranjadia)
left join eventas.ca_ratecards__ordunidb2 rts
on frd.frname = rts.frname
left join eventas.ca_canales__ordunidb2 cnl
on cst.idcanal = cnl.idcanal
where  rts.rtcrddscr  =  v_rtcrddscr                  -- el ratecard de la orden
and    cst.idtarget   =  rts.idtarget
and    cst.idtipotari =  rts.idtipotari
and    cst.diasemana  =  v_diasemana                   -- dependiendo del primer dia de transmision (l-v, s, d)
and    cnl.canal      =  v_stnid                       -- canal de la linea
and    cst.duracion   =  v_duracion                    -- de la duracion de la linea
and    frd.idcanal    =  cst.idcanal
and    frd.horaini    >= v_hora_ini                   -- hora inicio de la linea
and    frd.horafin    <= v_hora_fin                   -- hora fin de la linea
and    frd.diasemana  =  cst.diasemana
and    v_fecha_ini between frd.fecini and frd.fecfin; -- la fecha de la primer transmision
return v_tarifa;end;
$body$
language plpgsql
;
