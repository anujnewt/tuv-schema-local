CREATE OR REPLACE FORCE EDITIONABLE VIEW "FECXC"."XXCHK_FACTURAS_X_ASOC" ("CUSTOMER_ID", "TRX_NUMBER", "CT_REFERENCE", "CUSTOMER_NAME", "MONTO", "CUSTOMER_TRX_ID", "INVOICE_CURRENCY_CODE", "EXCHANGE_RATE", "ORIG_SYSTEM_REFERENCE", "ORG_ID") AS 
  SELECT d.customer_id,
       a.trx_number,
	   a.ct_reference,
	   d.customer_name,
	   c.amount_due_remaining monto, a.customer_trx_id,
	   a.invoice_currency_code, a.exchange_rate, orig_system_reference,
	   a.org_id
  FROM ra_customers@ERP_PROD d,
       ra_customer_trx_all@ERP_PROD a,
       ar_payment_schedules_all@ERP_PROD c,
       hr_all_organization_units@ERP_PROD e
 WHERE a.customer_trx_id = c.customer_trx_id
   AND d.customer_id = a.bill_to_customer_id
   AND a.org_id = e.organization_id
   AND amount_due_remaining <> 0
UNION
SELECT   A.RELATED_CUSTOMER_ID,
		 C.trx_number,
		 C.ct_reference,
		 B.customer_name,
	     D.amount_due_remaining monto,
	     C.customer_trx_id,
		 C.invoice_currency_code,
		 C.exchange_rate,
		 B.orig_system_reference,
		 C.org_id
FROM RA_CUSTOMER_RELATIONSHIPS_ALL@ERP_PROD A,
     ra_customers@ERP_PROD B,
	 ra_customer_trx_all@ERP_PROD C,
	 ar_payment_schedules_all@ERP_PROD D,
	 hr_all_organization_units@ERP_PROD E
WHERE B.CUSTOMER_ID = A.CUSTOMER_ID
AND   A.RELATED_CUSTOMER_ID = C.bill_to_customer_id
AND   C.customer_trx_id = D.customer_trx_id
AND   C.org_id = E.organization_id
AND   amount_due_remaining <> 0;
