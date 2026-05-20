-- dmap_object_gen_tag : type : view name : xxchk_facturas_x_asoc
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxchk_facturas_x_asoc"  ("customer_id", "trx_number", "ct_reference", "customer_name", "monto", "customer_trx_id", "invoice_currency_code", "exchange_rate", "orig_system_reference", "org_id") as select d.customer_id,
a.trx_number,
a.ct_reference,
d.customer_name,
c.amount_due_remaining monto,  a.customer_trx_id,
a.invoice_currency_code,  a.exchange_rate,  orig_system_reference,
a.org_id
from ra_customers__erp_prod d,
ra_customer_trx_all__erp_prod a,
ar_payment_schedules_all__erp_prod c,
hr_all_organization_units__erp_prod e
where a.customer_trx_id = c.customer_trx_id
and d.customer_id = a.bill_to_customer_id
and a.org_id = e.organization_id
and amount_due_remaining <> 0
union
select   a.related_customer_id,
c.trx_number,
c.ct_reference,
b.customer_name,
d.amount_due_remaining monto,
c.customer_trx_id,
c.invoice_currency_code,
c.exchange_rate,
b.orig_system_reference,
c.org_id
from ra_customer_relationships_all__erp_prod a,
ra_customers__erp_prod b,
ra_customer_trx_all__erp_prod c,
ar_payment_schedules_all__erp_prod d,
hr_all_organization_units__erp_prod e
where b.customer_id = a.customer_id
and   a.related_customer_id = c.bill_to_customer_id
and   c.customer_trx_id = d.customer_trx_id
and   c.org_id = e.organization_id
and   amount_due_remaining <> 0;/* dmap converted statement end */
-- estimed cost of view [ xxchk_facturas_x_asoc ]: 5.00;
