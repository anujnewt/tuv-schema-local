create or replace procedure fecxc."feci_rep_flujo_efectivo_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin 

open feci_cursor for
select
des_grupo_forecast      as grupo_forecast
,des_segmento           as segmento
,concat(concat(cod_empresa, ' - '), des_empresa) as empresa
,fec_aplicacion         as fecha_aplicacion
,fec_operativa          as fecha_operativa
,metodo_pago            as metodo_pago
,folio_recibo           as folio_recibo
,nom_cliente            as nombre_cliente
,ref_cliente            as referencia_cliente
,cod_cliente            as cod_cliente
,clase_cliente          as clase_cliente
,desc_cps               as cps
,des_concepto           as concepto
,des_region             as region
,des_pais               as pais
,cod_moneda             as moneda
,tipo_cambio_origen     as tc_origen
,tipo_cambio_dolar      as tc_dolar
,monto_base_org         as monto_base_org
,monto_iva_org          as monto_iva_org
,importe_org            as monto_org
,monto_base_mxn         as monto_base_mxn
,monto_iva_mxn          as monto_iva_mxn
,importe_mxn            as monto_mxn
,monto_base_usd         as monto_base_usd
,monto_iva_usd          as monto_iva_usd
,importe_usd            as monto_usd
from fecxc.feci_clasificaciones_vw
order by  des_grupo_forecast, des_segmento, folio_recibo, orden;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
