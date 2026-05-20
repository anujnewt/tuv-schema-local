create or replace procedure feci."histfeci_procesa_clasificaciones_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador numeric;
rec record;
begin
for rec in (select folio_recibo, porcentaje_iva, importe_org, monto_base_org, monto_iva_org,
importe_mxn, monto_base_mxn, monto_iva_mxn, importe_usd, monto_base_usd,
monto_iva_usd, cod_segmento, cod_grupo_forecast, cod_concepto, cod_region,
cod_pais, desc_cps
from histfeci_recibos_masivo_tab)
loop
select count(folio_recibo) into strict contador from feci_clasificacion_tab
where folio_recibo =  rec.folio_recibo;
-- insertar en feci_clasificacion_tab
insert into feci_clasificacion_tab(
folio_recibo, tipo_recibo,orden,
porcentaje_iva,
importe_org,
monto_base_org,
monto_iva_org,
importe_mxn,
monto_base_mxn,
monto_iva_mxn,
importe_usd,
monto_base_usd,
monto_iva_usd,
cod_segmento,
cod_grupo_forecast,
cod_concepto,
cod_region,
cod_pais,
desc_cps,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
) values (
rec.folio_recibo, 'BATCH', contador+1,
rec.porcentaje_iva,
rec.importe_org,
rec.monto_base_org,
rec.monto_iva_org,
rec.importe_mxn,
rec.monto_base_mxn,
rec.monto_iva_mxn,
rec.importe_usd,
rec.monto_base_usd,
rec.monto_iva_usd,
rec.cod_segmento,
rec.cod_grupo_forecast,
rec.cod_concepto,
rec.cod_region,
rec.cod_pais,
rec.desc_cps,
clock_timestamp(), clock_timestamp(), 0, 0, 1
);
end loop;end;
$body$
language plpgsql
;
