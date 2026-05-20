create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun ( p_id_solicitud numeric, p_linea numeric, p_campo_ou varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_err_msg     varchar(32765) := null;
v_aux         varchar(2500) := null;
v_count       integer := 0;
c1 cursor for
select distinct desc_concom || '/' ||detalle_concom as err_msg
from   xxmor_concom_rpta_tab       r,
xxmor_map_concom_orduni_tab m
where  position(campo_posicion_concom  r.campo_concom) > 0
and    m.campo_orduni = p_campo_ou  -- accthdr
and    r.id_solicitud = p_id_solicitud
and    r.trackingid   = (case when nullif(p_linea::text, '') is not null then (select trackingid
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea
) else (select trackingid
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
end)
and    coalesce((r.numlinea_concom)::numeric ,0) = coalesce(p_linea,0)
and    r.estatus_orduni = '10';
--and r.accion_concom != rechazo
c2 cursor for
select distinct desc_concom || '/' ||detalle_concom as err_msg
from   xxmor_concom_rpta_tab r,
xxmor_map_concom_orduni_tab m
where  position(campo_posicion_concom  r.campo_concom) > 0
and    r.id_solicitud = p_id_solicitud
and    r.trackingid   = (case when nullif(p_linea::text, '') is not null then (select trackingid
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea
) else (select trackingid
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
end)
and    coalesce((r.numlinea_concom)::numeric ,0) = coalesce(p_linea,0)
and    r.estatus_orduni = '10';
--and r.accion_concom != rechazo
c3 cursor for
select distinct detalle_concom as err_msg
from   xxmor_concom_rpta_tab r
where  r.id_solicitud                      = p_id_solicitud
and    coalesce((r.numlinea_concom)::numeric ,0) = coalesce(p_linea,0)
and    r.estatus_orduni                    = '10';
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
if p_campo_ou = 'lineaMail' then
select count(1)
into strict v_count
from  xxmor_concom_rpta_tab
where id_solicitud = p_id_solicitud;
if v_count > 0 then
open c3;
loop
fetch c3 into v_aux;
exit when not found; /* dmap converted statement start *//* apply on c3 */
--v_err_msg := oracle.substr(v_err_msg,1,32665) || v_aux ||, ;
v_err_msg :=  concat(v_err_msg, v_aux, ', ') ;/* dmap converted statement end */
end loop;
close c3;
v_err_msg := oracle.substr(v_err_msg,1,length(v_err_msg)-2);
return coalesce(v_err_msg,'Sin_Error');
else
return coalesce(v_err_msg,'Estatus Inicial');
end if;
end if;
if p_campo_ou != 'linea' then
open c1;
loop
fetch c1 into v_aux;
exit when not found; /* dmap converted statement start *//* apply on c1 */
v_err_msg :=  concat(v_err_msg, v_aux, ', ') ;/* dmap converted statement end */
end loop;
close c1;
else
open c2;
loop
fetch c2 into v_aux;
exit when not found; /* dmap converted statement start *//* apply on c2 */
v_err_msg :=  concat(v_err_msg, v_aux, ', ') ;/* dmap converted statement end */
end loop;
close c2;
end if;
v_err_msg := oracle.substr(v_err_msg,1,length(v_err_msg)-2);
return coalesce(v_err_msg,'0');end;
$body$
language plpgsql
;
