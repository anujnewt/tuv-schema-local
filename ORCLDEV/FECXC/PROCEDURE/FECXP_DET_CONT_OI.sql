create or replace procedure fecxc."fecxp_det_cont_oi"  ( v_fecha_ini datedefault sysdate - 1, v_fecha_fin datedefault sysdate - 11 ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--	v_fecha_ini date:= sysdate - 31;
--	v_fecha_fin date:= sysdate - 1;
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
v_id_banco_ini fecxp_politicas_erp.id_banco_ini%type;
v_id_banco_fin fecxp_politicas_erp.id_banco_fin%type;
v_id_chequera_ini fecxp_politicas_erp.id_chequera_ini%type;
v_id_chequera_fin fecxp_politicas_erp.id_chequera_fin%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
v_ora_s1_ini fecxp_politicas_erp.oracle_segmento1_ini%type;
v_ora_s1_fin fecxp_politicas_erp.oracle_segmento1_fin%type;
v_ora_s2_ini fecxp_politicas_erp.oracle_segmento2_ini%type;
v_ora_s2_fin fecxp_politicas_erp.oracle_segmento2_fin%type;
v_ora_s3_ini fecxp_politicas_erp.oracle_segmento3_ini%type;
v_ora_s3_fin fecxp_politicas_erp.oracle_segmento3_fin%type;
v_ora_s4_ini fecxp_politicas_erp.oracle_segmento4_ini%type;
v_ora_s4_fin fecxp_politicas_erp.oracle_segmento4_fin%type;
v_ora_s5_ini fecxp_politicas_erp.oracle_segmento5_ini%type;
v_ora_s5_fin fecxp_politicas_erp.oracle_segmento5_fin%type;
v_ora_s6_ini fecxp_politicas_erp.oracle_segmento6_ini%type;
v_ora_s6_fin fecxp_politicas_erp.oracle_segmento6_fin%type;
v_ora_s7_ini fecxp_politicas_erp.oracle_segmento7_ini%type;
v_ora_s7_fin fecxp_politicas_erp.oracle_segmento7_fin%type;
cursor_clasificacion_fe_oracle cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where 	id_tipo_movto in ('A', 'E')
and  	activa_regla = 1
order by prioridad asc;
cursor_clasificacion_fe_ing cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'I')
and		activa_regla = 1
order by prioridad asc;
begin 

delete	from fecxp_pagos_erp_oi
where	e_codigo > 0;
--==  inserta todos los detalles que tengan una cuenta de provisi?n ==--
insert	into fecxp_pagos_erp_oi(e_codigo, folio_set, tipo_operacion, estatus_movimiento, id_chequera, id_banco, forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento, importe, numero_de_partida_erp, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, importe_linea, concepto, beneficiario, cla_fe_id_pol, cla_fe_des_pol, cla_fe_id_oi, cla_fe_des_oi, organization_id, name, no_cliente)
select	ep.e_codigo, ep.folio_set, ep.tipo_operacion, ep.estatus_movimiento, ep.id_chequera, ep.id_banco, ep.forma_pago, ep.fecha_aplicacion, ep.moneda, ep.tipo_cambio, ep.origen_movimiento, ep.importe, de.numero_de_partida_erp, de.oracle_segmento1, de.oracle_segmento2, de.oracle_segmento3, de.oracle_segmento4, de.oracle_segmento5, de.oracle_segmento6, de.oracle_segmento7, de.importe_linea, ep.concepto, ep.beneficiario, '|', '<SIN CLASIFICACI?N>', '|', '<SIN CLASIFICACI?N>', 0, '<EL REGISTRO NO EXISTE>', ep.no_cliente
from	fecxp_enc_pagos_erp ep,
fecxp_det_pagos_erp de,
fecxp_pagos_cuentas_apertura ca
where	fecha_aplicacion >= v_fecha_ini
and		fecha_aplicacion <= v_fecha_fin
and (de.oracle_segmento1 = ca.oracle_segmento1 or nullif(ca.oracle_segmento1::text, '') is null)
and (de.oracle_segmento2 = ca.oracle_segmento2 or nullif(ca.oracle_segmento2::text, '') is null)
and (de.oracle_segmento3 = ca.oracle_segmento3 or nullif(ca.oracle_segmento3::text, '') is null)
and (de.oracle_segmento4 = ca.oracle_segmento4 or nullif(ca.oracle_segmento4::text, '') is null)
and (de.oracle_segmento5 = ca.oracle_segmento5 or nullif(ca.oracle_segmento5::text, '') is null)
and (de.oracle_segmento6 = ca.oracle_segmento6 or nullif(ca.oracle_segmento6::text, '') is null)
and (de.oracle_segmento7 = ca.oracle_segmento7 or nullif(ca.oracle_segmento7::text, '') is null)
and		ep.secuencia_pagos_erp = de.secuencia_pagos_erp;
delete	from fecxp_organizaciones_ap;
/* commit; */
insert	into fecxp_organizaciones_ap(
e_codigo, folio_set, org_id, vendor_id, po_distribution_id)
select	fe.e_codigo,
fe.folio_set,
ia.org_id,
ia.vendor_id, -- para join
d.po_distribution_id -- para join
from (
select	 e_codigo, folio_set
from	 fecxp_pagos_erp_oi
group by e_codigo, folio_set
) fe,
ap_invoices_all__erp_prod ia,
ap_invoice_payments_all__erp_prod ip,
ap_checks_all__erp_prod ch,
ap_invoice_distributions_all__erp_prod d
where	d.line_type_lookup_code = 'ITEM'
and		nullif(d.po_distribution_id::text, '') is not null
and		ch.attribute11 = fe.folio_set
and		ia.invoice_id = ip.invoice_id
and		ia.invoice_id = d.invoice_id
and		ip.check_id = ch.check_id
group by fe.e_codigo,
fe.folio_set,
ia.org_id,
ia.vendor_id, -- para join
d.po_distribution_id; -- para join
/* commit; */
delete	from fecxp_organizaciones_rcv;
/* commit; */
insert	into fecxp_organizaciones_rcv(
e_codigo, folio_set, org_id, org_inventario, desc_org_inv)
select	e_codigo,
folio_set,
org_id,
rsh.ship_to_org_id org_inventario,
oi.name desc_org_inv
from 	fecxp_organizaciones_ap fe,
fecxp_org_inv_flujo ofe,
po.rcv_shipment_headers__erp_prod rsh,
po.rcv_shipment_lines__erp_prod rsl,
po.rcv_transactions__erp_prod rt ,
hr.hr_all_organization_units__erp_prod oi
where	rt.transaction_type = 'RECEIVE'
and		nullif(rt.po_header_id::text, '') is not null
and		ofe.organization_id = rsh.ship_to_org_id
and		rsh.shipment_header_id = rsl.shipment_header_id
and		rsh.shipment_header_id = rt.shipment_header_id
and		rsl.shipment_line_id = rt.shipment_line_id
and		rsl.shipment_header_id = rt.shipment_header_id
and		oi.organization_id = rsh.ship_to_org_id
and		rsl.po_distribution_id = fe.po_distribution_id
group by e_codigo,
folio_set,
org_id,
rsh.ship_to_org_id,
oi.name;
/* commit; */
delete	from fecxp_pagos_erp_oi oi
where	exists (
select	1
from	fecxp_organizaciones_rcv rcv
where	rcv.e_codigo = oi.e_codigo
and		rcv.folio_set = oi.folio_set
);
/* commit; */
insert	into fecxp_pagos_erp_oi(e_codigo, folio_set, tipo_operacion, estatus_movimiento, id_chequera, id_banco, forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento, importe, numero_de_partida_erp, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, importe_linea, concepto, beneficiario, cla_fe_id_pol, cla_fe_des_pol, cla_fe_id_oi, cla_fe_des_oi, organization_id, name, no_cliente)
select	ep.e_codigo, ep.folio_set, ep.tipo_operacion, ep.estatus_movimiento, ep.id_chequera, ep.id_banco, ep.forma_pago, ep.fecha_aplicacion, ep.moneda, ep.tipo_cambio, ep.origen_movimiento, ep.importe, de.numero_de_partida_erp, de.oracle_segmento1, de.oracle_segmento2, de.oracle_segmento3, de.oracle_segmento4, de.oracle_segmento5, de.oracle_segmento6, de.oracle_segmento7, de.importe_linea, ep.concepto, ep.beneficiario, '|', '<SIN CLASIFICACI?N>', '|', '<SIN CLASIFICACI?N>', rcv.org_inventario, rcv.desc_org_inv, ep.no_cliente
from	fecxp_organizaciones_rcv rcv,
fecxp_enc_pagos_erp ep,
fecxp_det_pagos_erp de,
fecxp_pagos_cuentas_apertura ca
where	ep.fecha_aplicacion >= v_fecha_ini
and		ep.fecha_aplicacion <= v_fecha_fin
and (de.oracle_segmento1 = ca.oracle_segmento1 or nullif(ca.oracle_segmento1::text, '') is null)
and (de.oracle_segmento2 = ca.oracle_segmento2 or nullif(ca.oracle_segmento2::text, '') is null)
and (de.oracle_segmento3 = ca.oracle_segmento3 or nullif(ca.oracle_segmento3::text, '') is null)
and (de.oracle_segmento4 = ca.oracle_segmento4 or nullif(ca.oracle_segmento4::text, '') is null)
and (de.oracle_segmento5 = ca.oracle_segmento5 or nullif(ca.oracle_segmento5::text, '') is null)
and (de.oracle_segmento6 = ca.oracle_segmento6 or nullif(ca.oracle_segmento6::text, '') is null)
and (de.oracle_segmento7 = ca.oracle_segmento7 or nullif(ca.oracle_segmento7::text, '') is null)
and		ep.secuencia_pagos_erp = de.secuencia_pagos_erp
and		ep.e_codigo = rcv.e_codigo
and		ep.folio_set = rcv.folio_set;
update	fecxp_pagos_erp_oi oi
set		cla_fe_id_oi =
(
select	fe.cla_fe_id
from	fecxp_org_inv_flujo fe
where	oi.organization_id = fe.organization_id
)
where	exists (
select	1
from	fecxp_org_inv_flujo fe
where	oi.organization_id = fe.organization_id
);
/* commit; */
--==  integra la clasificaci?n de claves de flujo originales ==--
open cursor_clasificacion_fe_oracle;
loop
fetch cursor_clasificacion_fe_oracle
into v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_oracle */
--== clasificaci?n de cuentas contables erp ==--
update	fecxp_pagos_erp_oi
set		cla_fe_id_pol = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (oracle_segmento1 <= coalesce(v_ora_s1_fin, 'z'))
and (oracle_segmento2 >= coalesce(v_ora_s2_ini, '0'))
and (oracle_segmento2 <= coalesce(v_ora_s2_fin, 'z'))
and (oracle_segmento3 >= coalesce(v_ora_s3_ini, '0'))
and (oracle_segmento3 <= coalesce(v_ora_s3_fin, 'z'))
and (oracle_segmento4 >= coalesce(v_ora_s4_ini, '0'))
and (oracle_segmento4 <= coalesce(v_ora_s4_fin, 'z'))
and (oracle_segmento5 >= coalesce(v_ora_s5_ini, '0'))
and (oracle_segmento5 <= coalesce(v_ora_s5_fin, 'z'))
and (oracle_segmento6 >= coalesce(v_ora_s6_ini, '0'))
and (oracle_segmento6 <= coalesce(v_ora_s6_fin, 'z'))
and (oracle_segmento7 >= coalesce(v_ora_s7_ini, '0'))
and (oracle_segmento7 <= coalesce(v_ora_s7_fin, 'z'))
and		coalesce(cla_fe_id_pol, '|') = '|';
end loop;
close cursor_clasificacion_fe_oracle;
--== actualiza campo cla_fe_des_pol ==--
update	fecxp_pagos_erp_oi poi
set		cla_fe_des_pol  = (select cf.cla_fe_des
from	fecxp_clasificacion_fe cf
where	cf.cla_fe_id = poi.cla_fe_id_pol);
--== actualiza cla_fe_des_oi ==--
update	fecxp_pagos_erp_oi poi
set		cla_fe_des_oi= (select cf.cla_fe_des
from	fecxp_clasificacion_fe cf
where	cf.cla_fe_id = poi.cla_fe_id_oi);
/* commit; */
-- agregar sin?nimos y grants
end;
$body$
language plpgsql
;
