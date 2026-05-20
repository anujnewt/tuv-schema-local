create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_ejecuta_auth_credcorp_pr ( piinidsolicitud numeric, poinautorizar inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_reproceso numeric;
lin_aut_cc    numeric;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select case when count(1)=0 then  0  else 1 end
into strict   lin_reproceso
from (select distinct id_solicitud
from (select distinct crt.id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni   = '10'
and    upper(accion_concom) in ('REPROCESO', 'REENVIO')
except
select distinct crt.id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab crt
where  crt.estatus_orduni = '10'
and upper(accion_concom) in ('RECHAZO', 'RETENCION')
) alias5
) re
where re.id_solicitud = piinidsolicitud;/* dmap converted statement start */
if lin_reproceso = 0 then
-- validar credito
select count(1)
into strict   lin_aut_cc
from   xxmor_concom_rpta_tab rc
where  upper(rc.campo_concom)      = 'CRED_CORP'
and    upper(rc.accion_concom)     = upper('AUTORIZACION')
--and    coalesce(rc.estatus_orduni,10) = 10
and    rc.id_solicitud             = piinidsolicitud;/* dmap converted statement end */
if lin_aut_cc = 0 then
poinautorizar := 1;
else
poinautorizar := 0;
end if;
else
poinautorizar := 0;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('Autorizar:', poinautorizar)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
