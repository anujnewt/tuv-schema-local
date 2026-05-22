create or replace procedure fecxc."feci_obtener_reporte_no_clasif_pr"  (INOUT feci_cursor     refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end

--feci_cursor refcursor;
begin 

/* dmap converted statement start */
open feci_cursor for
select   concat(r.cod_empresa, ' - ' , e.des_empresa)  as empresa, r.fec_operativa fecha,
r.metodo_pago as metodopago, r.ref_cliente as referenciacliente,
r.nom_cliente as nombrecliente, r.folio_recibo as numerorecibo,
r.num_operacion as codigooperacion,
r.cod_moneda moneda, r.importe
from fecxc.feci_recibo_tab r
inner join fecxc.feci_empresa_cat e on r.cod_empresa = e.cod_empresa
inner join fecxc.feci_moneda_cat m on r.cod_moneda = m.cod_moneda
where r.cod_estado_recibo = 'PEND';/* dmap converted statement end */

exception
when no_data_found then
end;
$body$
language plpgsql
;
