create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_fecha_enc_val_fun ( p_id_solicitud integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_lineas_bien       integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(1)
into strict   v_lineas_bien
from (select numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    upper(accion_concom) = 'LINEABIEN'
except
select numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    upper(accion_concom) in ( 'AUTORIZACION', 'RECHAZO', 'REPROCESO')
and    estatus_orduni       = '10'
) alias4;
return v_lineas_bien;end;
$body$
language plpgsql
;
