create or replace procedure feci."feci_inserta_clasificacion_pr"  ( p_id_clasificacion numeric, p_folio_recibo numeric, p_tipo_recibo varchar, p_orden numeric, p_porcentaje_iva numeric, p_importe_org numeric , p_monto_base_org numeric, p_monto_iva_org numeric, p_importe_mxn numeric , p_monto_base_mxn numeric, p_monto_iva_mxn numeric, p_importe_usd numeric , p_monto_base_usd numeric, p_monto_iva_usd numeric, p_cod_segmento varchar , p_cod_grupo_forecast varchar, p_cod_concepto varchar, p_cod_region varchar , p_cod_pais varchar, p_desc_cps varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
folio numeric;
feci_cursors refcursor;
begin
insert into feci_clasificacion_tab(folio_recibo,tipo_recibo,orden,porcentaje_iva,importe_org,monto_base_org,monto_iva_org,
importe_mxn,monto_base_mxn,monto_iva_mxn,importe_usd,monto_base_usd,monto_iva_usd,cod_segmento,cod_grupo_forecast,
cod_concepto,cod_region,cod_pais,desc_cps,fec_creacion,fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,ind_estado)
values (
p_folio_recibo,
p_tipo_recibo,
p_orden,
p_porcentaje_iva,
p_importe_org,
p_monto_base_org,
p_monto_iva_org,
p_importe_mxn,
p_monto_base_mxn,
p_monto_iva_mxn,
p_importe_usd,
p_monto_base_usd,
p_monto_iva_usd,
p_cod_segmento,
p_cod_grupo_forecast,
p_cod_concepto,
p_cod_region,
p_cod_pais,
p_desc_cps,
clock_timestamp(),
clock_timestamp(),
1,
1,
1
) returning folio_recibo into folio;
open feci_cursors for
select folio_recibo from feci_clasificacion_tab where folio_recibo =  folio;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
