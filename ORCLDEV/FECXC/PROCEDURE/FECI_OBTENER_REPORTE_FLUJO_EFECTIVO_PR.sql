create or replace procedure fecxc."feci_obtener_reporte_flujo_efectivo_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor     refcursor;
--feci_cursor refcursor;
begin 

/* dmap converted statement start */
open feci_cursor for
select f.des_grupo_forecast as grupo_forecast, s.des_segmento as segmento,  concat(e.cod_empresa, ' - ' , e.des_empresa)  as empresa,
case when c.tipo_recibo = 'MANUAL' then m.fec_aplicacion else r.fec_aplicacion end as fecha_registro,
case when c.tipo_recibo = 'MANUAL' then m.fec_operativa else r.fec_operativa end as fecha_gl,
case when c.tipo_recibo = 'MANUAL' then m.metodo_pago else r.metodo_pago end as metodo_pago,
case when c.tipo_recibo = 'MANUAL' then m.folio_recibo_manual else r.folio_recibo end as numero_recibo,
case when c.tipo_recibo = 'MANUAL' then m.nom_cliente else r.nom_cliente end as nombre_cliente,
case when c.tipo_recibo = 'MANUAL' then m.ref_cliente else r.ref_cliente end as referencia_cliente,
case when c.tipo_recibo = 'MANUAL' then 'N/A' else r.cod_cliente end as numero_cliente,
case when c.tipo_recibo = 'MANUAL' then m.clase_cliente else r.clase_cliente end as clase_cliente,
c.desc_cps as cps, concep.des_concepto as concepto, reg.des_region as region, p.des_pais as pais, mon.des_moneda as moneda,
case when c.tipo_recibo = 'MANUAL' then m.tipo_cambio_origen else r.tipo_cambio_origen end as tc_moneda_origen,
c.monto_base_org as monto_base_origen, c.monto_iva_org as iva_origen, c.importe_org as total_monto_origen,
c.monto_base_mxn as monto_base_local, c.monto_iva_mxn as iva_local, c.importe_mxn as total_monto_local,
case when c.tipo_recibo = 'MANUAL' then m.tipo_cambio_dolar else r.tipo_cambio_dolar end as tc_dolares,
c.monto_base_usd as monto_base_dolares, c.monto_iva_usd as iva_dolares, c.importe_usd as total_monto_dolares
from fecxc.feci_clasificacion_tab c
inner join fecxc.feci_grupo_forecast_cat f on c.cod_grupo_forecast = f.cod_grupo_forecast
inner join fecxc.feci_segmento_cat s on c.cod_segmento = s.cod_segmento
left outer join fecxc.feci_recibo_tab r on c.folio_recibo = r.folio_recibo
left outer join fecxc.feci_recibo_manual_tab m on c.folio_recibo = m.folio_recibo_manual
left outer join fecxc.feci_empresa_cat e on r.cod_empresa = e.cod_empresa or m.cod_empresa = e.cod_empresa
inner join fecxc.feci_concepto_cat concep on c.cod_concepto = concep.cod_concepto
left outer join fecxc.feci_region_cat reg on c.cod_region = reg.cod_region
left outer join fecxc.feci_pais_cat p on c.cod_pais = p.cod_pais
left outer join fecxc.feci_moneda_cat mon on r.cod_moneda = mon.cod_moneda or m.cod_moneda = mon.cod_moneda;/* dmap converted statement end */
dbms_sql.return_result(feci_cursor);
exception
when no_data_found then
perform dbms_output.put_line('feci_cursor ');end;
$body$
language plpgsql
;
