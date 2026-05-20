create or replace procedure fecxc."fecxp_llena_ing_erp_det_cont"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
begin 

--- ======== limpia temporales ======== ---
delete	from fecxc_dep_especiales_sin_det;
delete	from fecxc_dep_esp_sin_det_oracle;
/* commit; */
--- ======== inserta folios sin detalle ======== ---
insert	into fecxc_dep_especiales_sin_det(
secuencia_dep_especiales, no_empresa, no_folio_det, importe)
select	secuencia_dep_especiales, no_empresa, no_folio_det, importe
from	fecxc_dep_especiales i,
fecxc_empresas e
where	clock_timestamp() - i.fec_valor < 60
and		i.no_empresa = coalesce(v_e_codigo, i.no_empresa)
and		i.secuencia_dep_especiales > 0
and		e.cual_erp = 'O'
and		i.no_empresa = e.e_codigo
and		not exists (
select	1
from	fecxc_dep_especiales_d d
where	i.secuencia_dep_especiales = d.secuencia_dep_especiales
);
insert	into fecxc_dep_esp_sin_det_oracle(
secuencia_dep_especiales, code_combination, importe_linea, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	fe.secuencia_dep_especiales, g.code_combination_id, select array_append(acla, null) into aclaed_amount, g.segment1, g.segment2, g.segment3, g.segment4, g.segment5, g.segment6, g.segment7
from	fecxc_dep_especiales_sin_det fe,
ar.ar_receivable_applications_all__erp_prod a,
ar.ra_customer_trx_all__erp_prod b,
apps.ar_cash_receipts_all__erp_prod c,
ap.ap_bank_accounts_all__erp_prod d,
ar.ar_receipt_methods__erp_prod e,
ar.ar_payment_schedules_all__erp_prod f,
ar.ra_batch_sources_all__erp_prod g,
ar.ra_cust_trx_types_all__erp_prod h,
ar.ra_customer_trx_lines_all__erp_prod acla,
ar.ra_cust_trx_line_gl_dist_all__erp_prod rct,
gl.gl_code_combinations__erp_prod g
where	fe.no_empresa = coalesce(v_e_codigo, fe.no_empresa)
and		to_char(fe.no_empresa) = g.segment1
and		to_char(fe.no_folio_det) = c.receipt_number
and		a.applied_customer_trx_id = b.customer_trx_id
and		a.cash_receipt_id = c.cash_receipt_id
and		c.remittance_bank_account_id = d.bank_account_id
and		c.receipt_method_id = e.receipt_method_id
and		a.applied_payment_schedule_id = f.payment_schedule_id
and		b.batch_source_id = g.batch_source_id
and		b.cust_trx_type_id = h.cust_trx_type_id
and		b.customer_trx_id = acla.customer_trx_id
and		acla.customer_trx_line_id = rct.customer_trx_line_id
and		g.code_combination_id = rct.code_combination_id;
/* commit; */
insert	into fecxc_dep_esp_comp_det_oracle(
secuencia_dep_especiales, importe_enc, importe_det)
select	a.secuencia_dep_especiales, a.importe_enc, a.importe_det
from	(
select	e.secuencia_dep_especiales, e.importe_enc, d.importe_det
from (
select	e.secuencia_dep_especiales, e.importe importe_enc
from	fecxc_dep_especiales_sin_det e
) e,
(
select	d.secuencia_dep_especiales, sum(d.importe_linea) importe_det
from	fecxc_dep_esp_sin_det_oracle d
group by d.secuencia_dep_especiales
) d
where	e.secuencia_dep_especiales = d.secuencia_dep_especiales
and		abs(e.importe_enc - d.importe_det) > 1
) a;
/* commit; */
delete	from fecxc_dep_esp_sin_det_oracle a
where	exists (
select	1
from	fecxc_dep_esp_comp_det_oracle b
where	a.secuencia_dep_especiales = b.secuencia_dep_especiales
);
/* commit; */
insert	into fecxc_dep_especiales_d(
secuencia_det_dep_esp, secuencia_dep_especiales, code_combination, importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	nextval('secuencia_det_dep_esp'), secuencia_dep_especiales, code_combination, importe_linea, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxc_dep_esp_sin_det_oracle;
/* commit; */
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
