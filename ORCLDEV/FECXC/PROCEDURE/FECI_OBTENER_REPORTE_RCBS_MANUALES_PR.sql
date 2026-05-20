create or replace procedure fecxc."feci_obtener_reporte_rcbs_manuales_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor     refcursor;
--feci_cursor refcursor;
begin 

/* dmap converted statement start */
open feci_cursor for
select   concat(r.cod_empresa, ' - ' , e.des_empresa)  empresa, r.fec_operativa fecha,
r.metodo_pago as metodo, r.ref_cliente referencia_cliente,
r.nom_cliente as nombre_cliente, r.folio_recibo_manual numero_recibo,
r.num_operacion as codigo_operacion, r.cod_moneda moneda,
r.importe, r.cod_estado_recibo estado_recibo
from fecxc.feci_recibo_manual_tab r
inner join fecxc.feci_empresa_cat e on r.cod_empresa = e.cod_empresa
inner join fecxc.feci_moneda_cat m on r.cod_moneda = m.cod_moneda;/* dmap converted statement end */
dbms_sql.return_result(feci_cursor);
exception
when no_data_found then
perform dbms_output.put_line('feci_cursor ');end;
$body$
language plpgsql
;
