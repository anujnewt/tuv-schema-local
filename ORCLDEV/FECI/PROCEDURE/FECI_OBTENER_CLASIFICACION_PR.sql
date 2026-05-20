create or replace procedure feci."feci_obtener_clasificacion_pr"  ( p_folio_recibo varchar, p_tipo_recibo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin
open feci_cursor for
select
id_clasificacion,folio_recibo,tipo_recibo,orden,porcentaje_iva,importe_org,
monto_base_org,monto_iva_org,importe_mxn,monto_base_mxn,monto_iva_mxn,
importe_usd,monto_base_usd,monto_iva_usd,cod_segmento,cod_grupo_forecast,
cod_concepto,cod_region,cod_pais,desc_cps,fec_creacion,fec_ult_modificacion,
id_usuario_creacion,id_usuario_ult_modif,ind_estado
from feci_clasificacion_tab
where folio_recibo = p_folio_recibo
and tipo_recibo = p_tipo_recibo
and ind_estado = 1;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
