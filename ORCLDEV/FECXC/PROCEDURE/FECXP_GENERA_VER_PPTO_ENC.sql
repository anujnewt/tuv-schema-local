create or replace procedure fecxc."fecxp_genera_ver_ppto_enc"  ( v_cual_erp varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_periodo_extraccion integer:= ((to_char(clock_timestamp(), 'YYYY'))::numeric );
v_mes_extraccion integer:= ((to_char(clock_timestamp(), 'MM'))::numeric );
v_sig_version integer;
v_version_fe_cantidad integer;
v_vueltas integer;
begin 

if v_cual_erp = 'O' then
-----------------------------------------------------------------------------------------------------------
-- limpia ppto erp operativo en caso de haberlo (no deberia)
delete	from fecxp_ppto_opera_erp
where	periodo_extraccion = v_periodo_extraccion
and		mes_de_extraccion = v_mes_extraccion;
/* commit; */
delete	from fecxp_ppto_opera_erp_enc
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- limpia ppto erp convertido en caso de haberlo (no deberia)
delete	from fecxp_ppto_conversion_erp
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
delete	from fecxp_ppto_conversion_erp_enc
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- obtiene maximo de versiones fe para ppto erp
select	version_fe_cantidad
into strict	v_version_fe_cantidad
from	fecxp_ppto_versiones_params
where	cual_erp = 'O';
-----------------------------------------------------------------------------------------------------------
-- genera ppto erp
select	coalesce(max(version_fe) + 1, 1)
into strict	v_sig_version
from	fecxp_ppto_opera_erp_enc;
v_vueltas:= 1;
loop
insert	into fecxp_ppto_opera_erp_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen, estatus_fe)
values (
v_sig_version, '', '', '', 0, to_timestamp('19000101','YYYYMMDD'), 0, 0, '', 0, 'SIN APLICAR');
v_sig_version:= v_sig_version + 1;
v_vueltas:= v_vueltas + 1;
exit when v_vueltas > v_version_fe_cantidad;
end loop;
/* commit; */
end if;
if v_cual_erp = 'S' then
-----------------------------------------------------------------------------------------------------------
-- limpia ppto soin operativo en caso de haberlo (no deberia)
delete	from fecxp_ppto_operativo_soin
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
delete	from fecxp_ppto_operativo_soin_enc
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- limpia ppto soin convertido en caso de haberlo (no deberia)
delete	from fecxp_ppto_conversion_soin
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
delete	from fecxp_ppto_conversion_soin_enc
where	periodo_extraccion = v_periodo_extraccion
and		mes_extraccion = v_mes_extraccion;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- obtiene maximo de versiones fe para ppto soin
select	version_fe_cantidad
into strict	v_version_fe_cantidad
from	fecxp_ppto_versiones_params
where	cual_erp = 'S';
-----------------------------------------------------------------------------------------------------------
-- genera ppto soin
select	coalesce(max(version_fe) + 1, 1)
into strict	v_sig_version
from	fecxp_ppto_operativo_soin_enc;
v_vueltas:= 1;
loop
insert	into fecxp_ppto_operativo_soin_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen, estatus_fe)
values (
v_sig_version, '', '', '', 0, to_timestamp('19000101','YYYYMMDD'), 0, 0, '', 0, 'SIN APLICAR');
v_sig_version:= v_sig_version + 1;
v_vueltas:= v_vueltas + 1;
exit when v_vueltas > v_version_fe_cantidad;
end loop;
/* commit; */
end if;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
