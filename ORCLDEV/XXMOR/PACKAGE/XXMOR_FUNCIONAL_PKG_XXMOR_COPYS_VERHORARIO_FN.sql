create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_copys_verhorario_fn ( piin_id_solicitud integer, piin_num_linea integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_regs             numeric;
lst_copys_verhorario varchar(1);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
lst_copys_verhorario := 'Y';
lin_regs             := 0;
select count(1)
into strict   lin_regs
from   xxmor_concom_rpta_tab
where  position('VersionHorario' in detalle_concom) > 0
and    estatus_orduni            != '30'
and    id_solicitud               = piin_id_solicitud
and    (numlinea_concom)::numeric  = piin_num_linea;
if lin_regs > 0 then
-- existen registros con versionhorario que se generaron por
-- orden urgente.
lin_regs := 0;
-- existen registros con versionhorario que se generaron por
-- orden urgente y que aun no han sido autorizados, estatus 10.
select count(1)
into strict   lin_regs
from   xxmor_concom_rpta_tab
where  position('VersionHorario' in detalle_concom) > 0
and    estatus_orduni             = '10'
and    id_solicitud               = piin_id_solicitud
and    (numlinea_concom)::numeric  = piin_num_linea;
if lin_regs > 0 then
lst_copys_verhorario := 'N';
else
-- se valida si existen registros con versionhorario que se generaron por
-- orden urgente y que ya fueron autorizados, estatus 20.
lin_regs := 0;
select count(1)
into strict   lin_regs
from   xxmor_concom_rpta_tab
where  position('VersionHorario' in detalle_concom) > 0
and    estatus_orduni             = '20'
and    id_solicitud               = piin_id_solicitud
and    (numlinea_concom)::numeric  = piin_num_linea;
if lin_regs > 0 then
lst_copys_verhorario := 'Y';
end if;
end if;
else
-- se valida si existen registros con versionhorario que se autorizaron
-- en automatico, estatus 30.
lin_regs := 0;
select count(1)
into strict   lin_regs
from   xxmor_concom_rpta_tab
where  position('VersionHorario' in detalle_concom) > 0
and    estatus_orduni             = '30'
and    id_solicitud               = piin_id_solicitud
and    (numlinea_concom)::numeric  = piin_num_linea;
if lin_regs > 0 then
lst_copys_verhorario := 'N';
end if;
end if;
return(lst_copys_verhorario);end;
$body$
language plpgsql
;
