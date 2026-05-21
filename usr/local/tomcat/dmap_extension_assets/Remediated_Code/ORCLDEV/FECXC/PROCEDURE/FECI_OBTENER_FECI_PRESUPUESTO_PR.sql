create or replace procedure fecxc."feci_obtener_feci_presupuesto_pr"  ( p_anio numeric, 
p_mes numeric, 
p_moneda varchar,
INOUT feci_cursors refcursor ) as $body$
declare
-- pgv moved types start
-- pgv moved types end

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
EXTRACT(YEAR FROM fec_presupuesto)::numeric = p_anio::numeric
AND EXTRACT(MONTH FROM fec_presupuesto)::numeric = p_mes::numeric
and cod_moneda = p_moneda;
end;
$body$
language plpgsql
;
