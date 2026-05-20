create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_copys_por_orden_fn ( piin_id_fza_ventas integer, piin_id_solicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_conf_copys_fv  varchar(1);
lst_copys_orden    varchar(1);
lin_regs_canal     numeric;
lin_regs_version   numeric;
lin_regs_can_ver   numeric;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
lst_conf_copys_fv := null;
lst_copys_orden   := null;
select coalesce(copys_x_orden,'0')
into strict   lst_conf_copys_fv
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = piin_id_fza_ventas;/* dmap converted statement start */
if lst_conf_copys_fv = '1' then
-- se trata de copys por orden, por lo tanto hay que revisar
-- si en realidad deben ser por orden o por linea.
select count(distinct d.stnid)            canal,
count(distinct d.version)          version,
count(distinct  concat(d.stnid, d.version))  can_ver
into strict   lin_regs_canal,
lin_regs_version,
lin_regs_can_ver
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = piin_id_solicitud
and    not exists (   --lineas en las que concom respondio que su version no existe no se generan copys
select 1
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
and    position('VersionHorario' in cr.detalle_concom) > 0
)
and    not exists (   --lineas que sigan teniendo error no se generan copys
select 1
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
and    cr.estatus_orduni             = '10'
);/* dmap converted statement end */
-- caso 1, 1 canal - 1 version
if lin_regs_canal = 1 and lin_regs_version = 1 then
lst_copys_orden := 'Y';
-- caso 2, n canales - 1 version
elsif lin_regs_canal > 1 and lin_regs_version = 1 then
lst_copys_orden := 'Y';
-- caso 3, n canales - n versiones
elsif lin_regs_canal = lin_regs_version then
if lin_regs_canal = lin_regs_can_ver then
lst_copys_orden := 'Y';
else
lst_copys_orden := 'N';
end if;
-- caso 4, 1 canal - n versiones
elsif lin_regs_canal = 1 and lin_regs_version > 1 then
lst_copys_orden := 'N';
-- caso 5, n canales - n versiones
elsif lin_regs_canal != lin_regs_version then
lst_copys_orden := 'N';
end if;
else
-- se trata de copys por linea, por lo tanto se envia el valor de
-- la configuracion de la fuerza de ventas, es decir, por linea.
lst_copys_orden := 'N';
end if;
return(lst_copys_orden);end;
$body$
language plpgsql
;
