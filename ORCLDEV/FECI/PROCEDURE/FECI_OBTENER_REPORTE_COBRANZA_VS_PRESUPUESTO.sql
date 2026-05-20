create or replace procedure feci."feci_obtener_reporte_cobranza_vs_presupuesto"  ( p_dia numeric, p_mes numeric, p_anio numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
v_fechaoperativa timestamp(0);
v_fechames timestamp(0);
v_fechaanio timestamp(0);
v_fechaanioanteriorenero timestamp(0);
v_fechaanioanterioroperativa timestamp(0);
begin
/* dmap converted statement start */
v_fechaoperativa := to_date( concat(p_dia, '/' , p_mes , '/' , p_anio) , 'DD/MM/YYYY');/* dmap converted statement end *//* dmap converted statement start */
v_fechames := to_date( concat('01', '/' , p_mes , '/' , p_anio) , 'DD/MM/YYYY');/* dmap converted statement end *//* dmap converted statement start */
v_fechaanio := to_date( concat('01', '/' , '01' , '/' , p_anio) , 'DD/MM/YYYY');/* dmap converted statement end *//* dmap converted statement start */
v_fechaanioanteriorenero := to_date( concat('01', '/' , '01' , '/' , to_char((p_anio)::numeric  - 1)) , 'DD/MM/YYYY');/* dmap converted statement end *//* dmap converted statement start */
v_fechaanioanterioroperativa := to_date( concat('01', '/' , p_mes , '/' , to_char((p_anio)::numeric  - 1)) , 'DD/MM/YYYY');/* dmap converted statement end */
open feci_cursor for
with periodoactual as (
select
s.cod_moneda,
c.cod_grupo_forecast,
g.des_grupo_forecast,
c.cod_segmento,
s.des_segmento,
c.cod_concepto,
concepto.des_concepto,
r.fec_operativa,
c.monto_base_mxn,
c.monto_base_usd
from feci_clasificacion_tab c
join feci_recibos_rep_vw r on c.folio_recibo = r.folio_recibo
join feci_segmento_cat s on c.cod_segmento = s.cod_segmento
join feci_grupo_forecast_cat g on c.cod_grupo_forecast = g.cod_grupo_forecast
join feci_concepto_cat concepto on c.cod_concepto = concepto.cod_concepto
where r.fec_operativa between v_fechaanio and v_fechaoperativa
or  r.fec_operativa between v_fechaanioanteriorenero and v_fechaanioanterioroperativa
)
select
pa.cod_segmento,
pa.des_segmento,
pa.cod_grupo_forecast,
pa.des_grupo_forecast,
pa.cod_concepto,
pa.des_concepto,
pa.cod_moneda,
sum(case when pa.fec_operativa = v_fechaoperativa
then
case when pa.cod_moneda = 'MXN' then pa.monto_base_mxn else pa.monto_base_usd end
else 0 end) as cobranza_dia,
sum(case when pa.fec_operativa between v_fechames and v_fechaoperativa then
case when pa.cod_moneda = 'MXN' then pa.monto_base_mxn else pa.monto_base_usd end
else 0 end) as cobranza_mes,
(
select sum(num_importe)
from feci_presupuesto_tab p
where  p.cod_segmento =pa.cod_segmento
and  p.cod_concepto = pa.cod_concepto
and p.fec_presupuesto between v_fechames and v_fechaoperativa
and p.cod_moneda = pa.cod_moneda
) presupuesto_mes,
sum(case when pa.fec_operativa between v_fechaanio and v_fechaoperativa then
case when pa.cod_moneda = 'MXN' then pa.monto_base_mxn else pa.monto_base_usd end
else 0 end) as cobranza_a_la_fecha,
(
select sum(num_importe)
from feci_presupuesto_tab p
where  p.cod_segmento =pa.cod_segmento
and  p.cod_concepto = pa.cod_concepto
and p.fec_presupuesto between v_fechaanio and v_fechaoperativa
and p.cod_moneda = pa.cod_moneda
) presupuesto_a_la_fecha,
sum(case when pa.fec_operativa between v_fechaanioanteriorenero and v_fechaanioanterioroperativa then
case when pa.cod_moneda = 'MXN' then pa.monto_base_mxn else pa.monto_base_usd end
else 0 end) as cobranza_anio_anterior
from periodoactual pa
group by
pa.cod_segmento,
pa.des_segmento,
pa.cod_grupo_forecast,
pa.des_grupo_forecast,
pa.cod_concepto,
pa.des_concepto,
pa.cod_moneda;/* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Operativa: ', v_fechaoperativa)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Mes: ', v_fechames)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha A?', v_fechaanio)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha A?nterior Mes: ', v_fechaanioanteriorenero)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha A?nterior Operativa: ', v_fechaanioanterioroperativa)) ;/* dmap converted statement end */
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
