create or replace procedure feci."feci_obtener_feci_presupuesto_pr"  ( p_anio numeric, p_mes numeric, p_moneda varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursors refcursor;
begin
open feci_cursors for
select
id_presupuesto,
cod_segmento,
cod_concepto,
cod_moneda,
cod_region,
fec_presupuesto,
num_gestion,
num_importe
from
feci_presupuesto_tab
where
extract(year from fec_presupuesto) = (p_anio)::numeric
and extract(month from fec_presupuesto) = (p_mes)::numeric
and cod_moneda = p_moneda;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
