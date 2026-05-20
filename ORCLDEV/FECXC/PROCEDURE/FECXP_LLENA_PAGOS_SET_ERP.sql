create or replace procedure fecxc."fecxp_llena_pagos_set_erp"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*noviembre 2009 v8 modificado para llamar la extraccion de ingresos antes que los detalles automaticos*/
/*agosto 2009  modificado para comenzar el proceso automatico de detalle solo dos*/
/*agosto 2009 modificado para evitar triplicaciones incluye el caso de cancelados sin aplicado en bitacora*/
/*julio 2009  elimina temporalidad de tablas  de trabajo*/
/*abril 2009  separar cancelados de los que no en prov_det*/
/*fecha modificacion: noviembre 08*/
/*los movimientos set ahora tienen un historico en el caso de los cancelados, por lo que se modifica este procedimiento*/
/*se hace filtro para evitar los movs. con status cancelado y luego se retoman calculando importe con signo contrario*/
/*17may2011 se agrega condicion para que no mande a ejecutar los demas procesos los dias lunes*/
v_fec_fec_ejecucion timestamp(0):= clock_timestamp();
v_folio_set varchar(150); -- := '';
v_contador integer:=0;
v_dia    varchar(20);
v_hora   varchar(30);
begin 

---utilizar dblink  para verificar si hay conexion
select count(check_id)
into strict v_contador
from ap_checks_all__erp_prod
where check_date>= clock_timestamp();
-- inicializa fecxp_folios_prov_enc --
delete from fecxp_folios_prov_enc;
--/* commit; */
-- inicializa fecxp_folios_prov_det --
delete from fecxp_folios_prov_det;
--/* commit; */
--inicializa tablas de trabajo
delete from fecxp_enc_replicas_proc_tmp;
delete from fecxp_replicas_por_cerrar;
delete from fecxp_cancelados_sincambios;
delete from fecxp_crear_aperturados;
--delete fecxp_fol_ap_tmp;
--delete fecxp_ape_det_tmp;
delete from fecxp_enc_pagos_erp_tmp;
delete from fecxp_folios_prov_checks;
delete from fecxp_folios_prov_invoices;
--/* commit; */
--- ======== control dinamico ======== ---
-- inhabilita para apertura aquellos registros que sobrepasen la vigencia --
-- estatus_cont_din_aper = 'P' [pendiente], 'S' [sin cuadrar], 'C' [cuadrado] --
-- no excluye a los cancelados porque de otra forma quedan distintos el aplicado y cancelado ('S' y 'P') por ejemplo
-- si ya esta cerrado no se toma en cuenta
update    fecxp_bit_cont_din_aper_enc
set        estatus_cont_din_aper = case when dias_vigencia_apertura > round(v_fec_fec_ejecucion - fec_primera_ejecucion) then 'P' else 'S' end,
fec_ultima_ejecucion = case when dias_vigencia_apertura > round(v_fec_fec_ejecucion - fec_primera_ejecucion) then v_fec_fec_ejecucion else fec_ultima_ejecucion end
where    folio_set = coalesce(v_folio_set, folio_set)
and        estatus_cont_din_aper <> 'C';
--and     estatus_movimiento not in ('X','Y','Z');
/*identifica los aplicados que revivieron sin borrar el cancelado*/
insert into fecxp_cancelados_sin_aplicado( e_codigo, folio_set, secuencia_pagos_erp)
select be.e_codigo, be.folio_set, be.secuencia_pagos_erp
from fecxp_bit_cont_din_aper_enc be
where be.estatus_movimiento in ('X','Y','Z')
and be.fecha_aplicacion>=to_timestamp('20090101','YYYYMMDD')
and not exists (select 1
from   fecxp_bit_cont_din_aper_enc ba
where ba.e_codigo = be.e_codigo
and   ba.folio_set = be.folio_set
and   ba.estatus_movimiento not in ('X','Y','Z')
);
delete  from fecxp_bit_cont_din_aper_det d
where exists (select 1
from   fecxp_cancelados_sin_aplicado e
where e.e_codigo = d.e_codigo
and e.secuencia_pagos_erp = d.secuencia_pagos_erp)
;
delete from   fecxp_bit_cont_din_aper_enc d
where exists (select 1
from fecxp_cancelados_sin_aplicado e
where  e.e_codigo = d.e_codigo
and e.secuencia_pagos_erp = d.secuencia_pagos_erp)
;
delete from fecxp_det_pagos_procesados d
where exists (select 1
from fecxp_cancelados_sin_aplicado e
where  e.e_codigo = d.e_codigo
and e.secuencia_pagos_erp = d.secuencia_pagos_erp)
;
/*termina de eliminar lo cancelado sin aplicado*/
-- /* commit; */
--- ======== control dinamico ======== ---
-- vuelve a tomar aquellos folios que siguen pendientes, no distingue entre aplicados y cancelados
-- siempre y cuando este pendiente en bitacora se reapertura
update    fecxp_enc_pagos_erp e
set        procesado = 0
where    exists (
select    1
from    fecxp_bit_cont_din_aper_enc b
where    b.estatus_cont_din_aper = 'P'
and        b.secuencia_pagos_erp = e.secuencia_pagos_erp
and        b.e_codigo = e.e_codigo
)
and        folio_set = coalesce(v_folio_set, folio_set);/* dmap converted statement start */
-- /* commit; */
-- se reinicializa el estatus de procesado si no se cuenta con detalle aperturado --
-- tampoco distingue entre cancelados y aplicados
update    fecxp_enc_pagos_erp e
set        procesado = 0
where    fecha_aplicacion >= to_date( concat(to_char(add_months(clock_timestamp(), -1), 'YYYYMM'), '01') , 'YYYYMMDD')
and        not exists (
select    1
from    fecxp_det_pagos_procesados d
where    e.e_codigo = d.e_codigo
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp
)
and        procesado = 1
and        folio_set = coalesce(v_folio_set, folio_set);/* dmap converted statement end */
-- /* commit; */
-- todo aquel documemto que no haya sido procesado se le bobrrara su detalle --
-- tampoco distingue entre cancelados y aplicados
delete    from fecxp_det_pagos_procesados d
where    exists (
select    1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = d.e_codigo
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp
and        e.procesado = 0
and        e.folio_set = coalesce(v_folio_set, e.folio_set)
);
-- /* commit; */
-- se extraen los folios que caen en la regla de negocios de cuentas de provision --
-- excluye los cancelados para que no duplique informacion y solo tome el folio aplicado
insert    into fecxp_folios_prov_enc(fecxp_e_codigo, fecxp_no_folio_det, fecxp_importe)
select    ep.e_codigo, ep.folio_set, ep.importe
from    fecxp_enc_pagos_erp ep
where    procesado = 0
and        exists (
select    1
from    fecxp_det_pagos_erp de,
fecxp_pagos_cuentas_apertura ca
where (de.oracle_segmento1 = ca.oracle_segmento1 or nullif(ca.oracle_segmento1::text, '') is null)
and (de.oracle_segmento2 = ca.oracle_segmento2 or nullif(ca.oracle_segmento2::text, '') is null)
and (de.oracle_segmento3 = ca.oracle_segmento3 or nullif(ca.oracle_segmento3::text, '') is null)
and (de.oracle_segmento4 = ca.oracle_segmento4 or nullif(ca.oracle_segmento4::text, '') is null)
and (de.oracle_segmento5 = ca.oracle_segmento5 or nullif(ca.oracle_segmento5::text, '') is null)
and (de.oracle_segmento6 = ca.oracle_segmento6 or nullif(ca.oracle_segmento6::text, '') is null)
and (de.oracle_segmento7 = ca.oracle_segmento7 or nullif(ca.oracle_segmento7::text, '') is null)
and        ep.e_codigo = de.e_codigo
and        ep.secuencia_pagos_erp = de.secuencia_pagos_erp
)
and        ep.folio_set = coalesce(v_folio_set, ep.folio_set)
and        ep.estatus_movimiento not in ('X','Y','Z');
--- ======== control dinamico ======== ---
-- inserta los folios set que pueden volver a ser aperturados --
-- y que no esten duplicados. caso folios set revividos --
-- excluye cancelados para evitar duplicar folio (aplicado y cancelado)
insert    into fecxp_folios_prov_enc(fecxp_e_codigo, fecxp_no_folio_det, fecxp_importe)
select    e_codigo, folio_set, importe_set
from    fecxp_bit_cont_din_aper_enc b
where    b.folio_set = coalesce(v_folio_set, b.folio_set)
and     b.estatus_movimiento not in ('X','Y','Z')
and        b.estatus_cont_din_aper = 'P'
and        not exists (
select    1
from    fecxp_folios_prov_enc p
where    p.fecxp_e_codigo = b.e_codigo
and        p.fecxp_no_folio_det = b.folio_set
);
-- /* commit; */
-- ====================================================================================================== --
delete from fecxp_folios_prov_checks;
-- recupera los folios con base a relaciones de ap [set.folio set a cheques.atributo] --
insert    into fecxp_folios_prov_checks(fecxp_e_codigo, fecxp_no_folio_det, ap_check_id)
select    ep.fecxp_e_codigo,
ep.fecxp_no_folio_det,
ch.check_id
from    fecxc.fecxp_folios_prov_enc ep,
ap_checks_all__erp_prod ch
where    ep.fecxp_no_folio_det = ch.attribute11
group by ep.fecxp_e_codigo,
ep.fecxp_no_folio_det,
ch.check_id;
delete from fecxp_folios_prov_invoices;
-- recupera los folios con base a relaciones de ap [cheques.atributo a facturas.invoice] --
insert    into fecxp_folios_prov_invoices(fecxp_e_codigo, fecxp_no_folio_det, ap_check_id, ap_invoice_id)
select    dp.fecxp_e_codigo, dp.fecxp_no_folio_det, dp.ap_check_id, ip.invoice_id
from    fecxp_folios_prov_checks dp,
ap_invoice_payments_all__erp_prod ip
where    ip.check_id = dp.ap_check_id
group by dp.fecxp_e_codigo, dp.fecxp_no_folio_det, dp.ap_check_id, ip.invoice_id;
-- crea detalle aperturado a partir de ap y flexfield de ap --
insert    into fecxc.fecxp_folios_prov_det(
fecxp_e_codigo, fecxp_no_folio_det, fecxp_importe, ap_invoice_id, ap_invoice_amount, ap_distribution_line_number, ap_distribution_amount, ap_dist_code_combination_id, ap_cuenta)
select    ep.fecxp_e_codigo,
ep.fecxp_no_folio_det,
ep.fecxp_importe,
ip.invoice_id,
sum(ip.amount) monto_factura,
d.distribution_line_number,
d.amount monto_distribucion,
d.dist_code_combination_id,
d.attribute12
from    fecxc.fecxp_folios_prov_enc ep,
fecxp_folios_prov_invoices dp,
ap_invoice_payments_all__erp_prod ip,
ap_invoice_distributions_all__erp_prod d
where    ep.fecxp_no_folio_det = dp.fecxp_no_folio_det
and        ip.check_id = dp.ap_check_id
and        ip.invoice_id = dp.ap_invoice_id
and        d.invoice_id = dp.ap_invoice_id
group by ep.fecxp_e_codigo,
ep.fecxp_no_folio_det,
ep.fecxp_importe,
ip.invoice_id,
d.distribution_line_number,
d.amount,
d.dist_code_combination_id,
d.attribute12;
-- ====================================================================================================== --
-- /* commit; */
-- actualiza cuentas. toma flexfield donde aplica --
update    fecxc.fecxp_folios_prov_det d
set(
d.segmento1,
d.segmento2,
d.segmento3,
d.segmento4,
d.segmento5,
d.segmento6,
d.segmento7
) =
(
select
case when d.ap_cuenta = null then  g.segment1  else oracle.substr(d.ap_cuenta, 1, 3) end ,
case when d.ap_cuenta = null then  g.segment2  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 1) + 1, 2) end ,
case when d.ap_cuenta = null then  g.segment3  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 2) + 1, 3) end ,
case when d.ap_cuenta = null then  g.segment4  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 3) + 1, 6) end ,
case when d.ap_cuenta = null then  g.segment5  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 4) + 1, 8) end ,
case when d.ap_cuenta = null then  g.segment6  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 5) + 1, 3) end ,
case when d.ap_cuenta = null then  g.segment7  else oracle.substr(d.ap_cuenta, instr(d.ap_cuenta, '-', 1, 6) + 1, 1) end
from    gl_code_combinations__erp_prod g
where    g.code_combination_id = d.ap_dist_code_combination_id
);
-- /* commit; */
--- ======== control dinamico ======== ---
-- inserta encabezados de bitacora nuevos --
insert    into fecxp_bit_cont_din_aper_enc(
secuencia_pagos_erp, e_codigo, folio_set, moneda, fecha_aplicacion,
tipo_operacion, id_banco, forma_pago, estatus_movimiento, id_chequera,
concepto, beneficiario, importe_set, fec_primera_ejecucion, fec_ultima_ejecucion)
select    e.secuencia_pagos_erp, e.e_codigo, e.folio_set, e.moneda, e.fecha_aplicacion,
e.tipo_operacion, e.id_banco, e.forma_pago, e.estatus_movimiento, e.id_chequera,
e.concepto, e.beneficiario, e.importe, v_fec_fec_ejecucion, v_fec_fec_ejecucion
from (
select    fe.fecxp_e_codigo, fe.fecxp_no_folio_det,
fe.fecxp_importe importe_set, sum(fd.ap_distribution_amount) importe_ap
from    fecxp_folios_prov_enc fe,
fecxp_folios_prov_det fd
where    fe.fecxp_e_codigo = fd.fecxp_e_codigo
and        fe.fecxp_no_folio_det = fd.fecxp_no_folio_det
group by fe.fecxp_e_codigo, fe.fecxp_no_folio_det, fe.fecxp_importe
) f,
fecxp_enc_pagos_erp e
where    e.folio_set = coalesce(v_folio_set, e.folio_set)
and        f.fecxp_e_codigo = e.e_codigo
and        f.fecxp_no_folio_det = e.folio_set
and        e.estatus_movimiento not in ('X','Y','Z')
and        e.secuencia_pagos_erp not in (
select    b.secuencia_pagos_erp
from    fecxp_bit_cont_din_aper_enc b
where    b.folio_set = coalesce(v_folio_set, b.folio_set)
);
-- /* commit; */
-- se inserta detalle aperturado en estructura de detalle de egresos oracle --
-- excluye a los folios cancelados para tomar solo los aplicados
insert    into fecxp_det_pagos_procesados(
e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp,
sec_det_pag_proc, code_combination, importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select    fpd.fecxp_e_codigo,
ep.secuencia_pagos_erp,
1 as secuencia_det_pagos_erp,
1 as numero_de_partida_erp,
nextval('sec_det_pag_proc'),
fpd.ap_dist_code_combination_id,
fpd.ap_distribution_amount ap_distribution_amount,
fpd.segmento1,
fpd.segmento2,
fpd.segmento3,
fpd.segmento4,
fpd.segmento5,
fpd.segmento6,
fpd.segmento7
from    fecxp_enc_pagos_erp ep,
fecxp_folios_prov_det fpd
where    ep.e_codigo = fpd.fecxp_e_codigo
and        ep.folio_set = fpd.fecxp_no_folio_det
and        ep.estatus_movimiento not in ('X', 'Y', 'Z')  --tomar los folios aplicados
;
---====cambio, ahora el detalle de bitacora guardara la suma del detalle aperturado final para los encabezados no cancelados
--- esto para que en caso de duplicacion o triplicacion quede como pendiente y no lo cierre
--- ======== control dinamico ======== ---
-- inserta todos los detalles generados --
--- excluir los pendientes de cancelados que se encuentren en el encabezado de bitacora
insert    into fecxp_bit_cont_din_aper_det(
secuencia_pagos_erp, e_codigo, secuencia_cont_din_aper_det, importe_set, importe_ap, fec_ejecucion)
select    b.secuencia_pagos_erp, b.e_codigo, nextval('secuencia_cont_din_aper_det'), b.importe_set, fd.importe_ap, v_fec_fec_ejecucion
from    fecxp_bit_cont_din_aper_enc b,
(
select    d.e_codigo, d.secuencia_pagos_erp, sum(d.importe_linea) importe_ap
from    fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d
where     e.e_codigo = d.e_codigo
and     e.secuencia_pagos_erp = d.secuencia_pagos_erp
and        e.procesado=0
and        e.estatus_movimiento not in ('X','Y','Z')
group by d.e_codigo, d.secuencia_pagos_erp
) fd
where    b.e_codigo = fd.e_codigo
and        b.secuencia_pagos_erp = fd.secuencia_pagos_erp
and        b.estatus_cont_din_aper = 'P'
and     b.estatus_movimiento not in ('X','Y','Z');
--- ======== control dinamico ======== ---
-- inserta los folios ap nuevos --
--- exlcuir los cancelados
insert    into fecxp_bit_cont_din_folios_ap(
secuencia_pagos_erp, e_codigo, secuencia_cont_din_aper_det, ap_invoice_id, ap_invoice_amount)
select    bd.secuencia_pagos_erp, bd.e_codigo, bd.secuencia_cont_din_aper_det, fd.ap_invoice_id, fd.importe_ap
from    fecxp_bit_cont_din_aper_enc be,
fecxp_bit_cont_din_aper_det bd,
(
select    d.fecxp_e_codigo, d.fecxp_no_folio_det, d.ap_invoice_id, sum(d.ap_distribution_amount) importe_ap
from    fecxp_folios_prov_det d
group by d.fecxp_e_codigo, d.fecxp_no_folio_det, d.ap_invoice_id
) fd
where    be.folio_set = coalesce(v_folio_set, be.folio_set)
and        be.estatus_cont_din_aper = 'P'
and        be.secuencia_pagos_erp = bd.secuencia_pagos_erp
and        be.e_codigo = fd.fecxp_e_codigo
and        be.folio_set = fd.fecxp_no_folio_det
and        be.estatus_movimiento not in ('X','Y','Z')   --ahora excluye cancelados
and        bd.secuencia_cont_din_aper_det not in (
select    secuencia_cont_din_aper_det
from    fecxp_bit_cont_din_folios_ap
);
-- ======== control dinamico ======== ---
-- maneja la ultima fecha de procesamiento --
update    fecxp_bit_cont_din_aper_enc
set        fec_ultima_ejecucion = v_fec_fec_ejecucion
where    folio_set = coalesce(v_folio_set, folio_set)
and        estatus_cont_din_aper = 'P';
--- ======== control dinamico ======== ---
-- cierra los folios que cuadraron --
--- excluye los cancelados existentes para que repliquen la reaperturacion correcta
update    fecxp_bit_cont_din_aper_enc be
set        estatus_cont_din_aper = 'C'
where    folio_set = coalesce(v_folio_set, folio_set)
and        exists (
select    1
from    fecxp_bit_cont_din_aper_det bd
where    bd.fec_ejecucion = v_fec_fec_ejecucion
and        be.secuencia_pagos_erp = bd.secuencia_pagos_erp
and        be.e_codigo = bd.e_codigo
and        bd.importe_set = bd.importe_ap
)
and        be.estatus_cont_din_aper = 'P'
and        be.estatus_movimiento not in ('X','Y','Z')  --se excluye el cancelado para que pueda replicar si ya existe
;
-- /* commit; */
-- se inserta el resto de los folios que no manejan provisiones --
-- excluir a los folios cancelados y tomar solo aplicados
insert    into fecxp_det_pagos_procesados(
e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp,
sec_det_pag_proc, code_combination, importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select    d.e_codigo,
d.secuencia_pagos_erp,
d.secuencia_det_pagos_erp,
d.numero_de_partida_erp,
nextval('secuencia_det_pagos_abrir'),
d.code_combination,
d.importe_linea,
d.oracle_segmento1,
d.oracle_segmento2,
d.oracle_segmento3,
d.oracle_segmento4,
d.oracle_segmento5,
d.oracle_segmento6,
d.oracle_segmento7
from    fecxp_enc_pagos_erp e,
fecxp_det_pagos_erp d
where    e.procesado = 0
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp
and        e.estatus_movimiento not in ('X','Y','Z') --excluye cancelados
and        not exists (
select    1
from    fecxp_folios_prov_det p
where    e.e_codigo = p.fecxp_e_codigo
and        e.folio_set = p.fecxp_no_folio_det
)
;
-- detecta los folios cuyo detalle y encabezado maneja diferente monto.
-- solo toma los folios aplicados
insert    into fecxp_enc_pagos_erp_tmp(e_codigo, secuencia_pagos_erp)
select    a1.e_codigo, a1.secuencia_pagos_erp
from    fecxp_enc_pagos_erp a1,
(
select    a.e_codigo, a.secuencia_pagos_erp, sum(importe_linea) importe_linea
from     fecxp_enc_pagos_erp     a,
fecxp_det_pagos_procesados b
where    a.procesado = 0
and        a.e_codigo = b.e_codigo
and        a.secuencia_pagos_erp = b.secuencia_pagos_erp
and        a.estatus_movimiento not in ('X','Y','Z')   ---excluye cancelados
group by a.e_codigo, a.secuencia_pagos_erp
) b1
where    a1.procesado = 0
and        a1.e_codigo = b1.e_codigo
and        a1.secuencia_pagos_erp = b1.secuencia_pagos_erp
and        a1.estatus_movimiento not in ('X','Y','Z')  --excluye cancelados
and        a1.importe <> b1.importe_linea;
-- /* commit; */
-- si son distintos se borran los registros en fecxp_detalle_pagos_procesados --
delete    from fecxp_det_pagos_procesados del_table
where    exists (
select    1
from    fecxp_enc_pagos_erp_tmp a
where    a.e_codigo = del_table.e_codigo
and        a.secuencia_pagos_erp = del_table.secuencia_pagos_erp
);
-- /* commit; */
-- y se reemplazan por los datos "originales" sacados de fecxp_enc_pagos_erp y fecxp_det_pagos_erp --
--- excluye a los cancelados
insert    into fecxp_det_pagos_procesados(
e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp,
sec_det_pag_proc, code_combination, importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select    ep.e_codigo, ep.secuencia_pagos_erp, dp.secuencia_det_pagos_erp, dp.numero_de_partida_erp,
nextval('sec_det_pag_proc'), dp.code_combination, dp.importe_linea, dp.oracle_segmento1, dp.oracle_segmento2,
dp.oracle_segmento3, dp.oracle_segmento4, dp.oracle_segmento5, dp.oracle_segmento6, dp.oracle_segmento7
from    fecxp_enc_pagos_erp ep,
fecxp_det_pagos_erp dp,
fecxp_enc_pagos_erp_tmp del_table
where    ep.secuencia_pagos_erp = dp.secuencia_pagos_erp
and        ep.e_codigo = dp.e_codigo
and        ep.estatus_movimiento not in ('X','Y','Z')  --toma aplicados
and        ep.secuencia_pagos_erp = del_table.secuencia_pagos_erp
and        ep.e_codigo = del_table.e_codigo
;
-------------======================================cancelados================================================================-
----una vez aperturado debe replicar para los registros cancelados.
---- si el folio es nuevo y cae el mismo dia que la cancelacion
----        debe replicar ya sea que haya cerrado o que  este pendiente
---- si el folio ya existia y el cancelado recien cayo
----        debe replicar ya sea que haya cerrado o que  este pendiente
---- si el folio ya existia y el cancelado tambien
----        si el folio cerro debe eliminar lo que existia y replicar la reaperturacion correcta
/*identificar los folios coincidentes que en enc_pagos estan cancelados y con procesado=0*/
insert into fecxp_enc_replicas_proc_tmp(secuencia_pagos_erp, e_codigo, folio_set, fecha_aplicacion, importe, estatus_movimiento, estatus_de_ingreso)
select e.secuencia_pagos_erp, e.e_codigo, e.folio_set, e.fecha_aplicacion, e.importe, e.estatus_movimiento, e.estatus_de_ingreso
from fecxp_enc_pagos_erp e
where  e.procesado=0
and    e.estatus_movimiento in ('X','Y','Z')
;
/*caso 0:  cuando los folios revivieron y se elmino  y el cancelado ya existe*/
/*caso 1: folios cancelados que ya existen en bitacora y siguen pendientes, pero su aplicado se cerro*/
---obtener la secuencia de los cancelados existentes en bitacora cuyo aplicado fue cerrado en el proceso.
insert into fecxp_replicas_por_cerrar(e_codigo, folio_set, secuencia_pagos_erp, secuencia_aplicada)
select ca.e_codigo, ca.folio_set, ca.secuencia_pagos_erp, bea.secuencia_pagos_erp as secuencia_aplicada
from fecxp_bit_cont_din_aper_enc be,
fecxp_enc_replicas_proc_tmp ca,
fecxp_bit_cont_din_aper_enc bea
where  be.e_codigo = ca.e_codigo
and        be.secuencia_pagos_erp = ca.secuencia_pagos_erp
and        be.estatus_cont_din_aper = 'P'
and        bea.e_codigo = ca.e_codigo
and        bea.folio_set = ca.folio_set
and        bea.estatus_cont_din_aper = 'C'
and        bea.estatus_movimiento not in ('X','Y','Z')
;
-- eliminar su detalle reaperturado
delete from fecxp_det_pagos_procesados del_table
where exists (select 1
from fecxp_replicas_por_cerrar a
where a.e_codigo = del_table.e_codigo
and        a.secuencia_pagos_erp = del_table.secuencia_pagos_erp)
;
-- replicar el detalle del folio aperturado
insert    into fecxp_det_pagos_procesados(
e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp,
sec_det_pag_proc, code_combination, importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
)
select ca.e_codigo,
ca.secuencia_pagos_erp,
d.secuencia_det_pagos_erp,
d.numero_de_partida_erp,
nextval('sec_det_pag_proc'),
d.code_combination,
d.importe_linea * -1,
d.oracle_segmento1,
d.oracle_segmento2,
d.oracle_segmento3,
d.oracle_segmento4,
d.oracle_segmento5,
d.oracle_segmento6,
d.oracle_segmento7
from fecxp_det_pagos_procesados d,
fecxp_replicas_por_cerrar ca
where d.e_codigo = ca.e_codigo
and        d.secuencia_pagos_erp = ca.secuencia_aplicada
;
-- replicar el detalle de bitacora del registro aplicado y con fecha de esta aperturacion
insert into fecxp_bit_cont_din_aper_det(
secuencia_pagos_erp, e_codigo, secuencia_cont_din_aper_det, importe_set, importe_ap, fec_ejecucion)
select  ca.secuencia_pagos_erp, ca.e_codigo, nextval('secuencia_cont_din_aper_det'), d.importe_set * -1, d.importe_ap * -1, d.fec_ejecucion
from fecxp_bit_cont_din_aper_det d,
fecxp_replicas_por_cerrar ca
where d.e_codigo = ca.e_codigo
and    d.secuencia_pagos_erp = ca.secuencia_aplicada
and    d.fec_ejecucion = v_fec_fec_ejecucion
;
-- actualizar el encabezado de bitacora correspondiente al registro que estaba cancelado
update fecxp_bit_cont_din_aper_enc be
set  estatus_cont_din_aper = 'C',
fec_ultima_ejecucion = v_fec_fec_ejecucion
where    exists (
select    1
from    fecxp_replicas_por_cerrar ca
where    be.e_codigo = ca.e_codigo
and        be.secuencia_pagos_erp = ca.secuencia_pagos_erp
)
and        be.estatus_cont_din_aper = 'P'
;
---marcar los folios cancelados que entraron en este caso
update     fecxp_enc_replicas_proc_tmp up_table
set procesado = 1
where exists (select 1 from fecxp_replicas_por_cerrar a where a.e_codigo = up_table.e_codigo and a.secuencia_pagos_erp = up_table.secuencia_pagos_erp)
;
/*caso 2:  los folios cancelados ya existen en bitacora pero su aplicado esta sin cuadrar*/
/*para los pendientes se elimino el detpagosproc y se volvio a generar por lo que no entran en este caso*/
insert into fecxp_cancelados_sincambios(e_codigo, folio_set, secuencia_pagos_erp, secuencia_aplicada)
select ca.e_codigo, ca.folio_set, ca.secuencia_pagos_erp, bea.secuencia_pagos_erp as secuencia_aplicada
from fecxp_bit_cont_din_aper_enc be,
fecxp_enc_replicas_proc_tmp ca,
fecxp_bit_cont_din_aper_enc bea
where  be.e_codigo = ca.e_codigo
and        be.secuencia_pagos_erp = ca.secuencia_pagos_erp
and        bea.e_codigo = ca.e_codigo
and        bea.folio_set = ca.folio_set
and        bea.estatus_cont_din_aper = 'S'
and        bea.estatus_movimiento not in ('X','Y','Z')
;
update fecxp_enc_replicas_proc_tmp  up_table
set procesado=1
where exists (select 1
from fecxp_cancelados_sincambios a
where a.e_codigo = up_table.e_codigo
and        a.secuencia_pagos_erp = up_table.secuencia_pagos_erp
)
;
/*caso 3: folios cancelados que tienen un aplicado en la bitacora*/
--- en este caso debe replicar si su aplicacion se encuentra en la bitacora, en caso de no encontrarla debe replicar en det_pagos_procesados
--- lo que exista
---obtener los cancelados nuevos que tienen un aplicado aperturado y no estan ya en la bitacora
insert into fecxp_crear_aperturados
select ca.e_codigo, ca.folio_set, ca.secuencia_pagos_erp, be.secuencia_pagos_erp as secuencia_aplicada
from fecxp_bit_cont_din_aper_enc be,
fecxp_enc_replicas_proc_tmp ca
where  be.e_codigo = ca.e_codigo
and        be.folio_set = ca.folio_set
and        be.estatus_movimiento not in ('X','Y','Z')
and    not exists (select 1
from fecxp_bit_cont_din_aper_enc ba
where  ba.e_codigo = ca.e_codigo
and        ba.secuencia_pagos_erp = ca.secuencia_pagos_erp
)
;
--replicar encabezado de bitacora para cancelados
insert    into fecxp_bit_cont_din_aper_enc(
secuencia_pagos_erp, e_codigo, folio_set, moneda, fecha_aplicacion,
tipo_operacion, id_banco, forma_pago, estatus_movimiento, id_chequera,
concepto, beneficiario, importe_set,estatus_cont_din_aper,fec_primera_ejecucion,
fec_ultima_ejecucion,dias_vigencia_apertura)
select re.secuencia_pagos_erp, re.e_codigo, re.folio_set, be.moneda, re.fecha_aplicacion,
be.tipo_operacion, be.id_banco, be.forma_pago, re.estatus_movimiento, be.id_chequera,
be.concepto, be.beneficiario, be.importe_set * -1, be.estatus_cont_din_aper,v_fec_fec_ejecucion,
v_fec_fec_ejecucion, be.dias_vigencia_apertura
from   fecxp_enc_replicas_proc_tmp re,
fecxp_bit_cont_din_aper_enc be,
fecxp_crear_aperturados a
where  re.e_codigo = a.e_codigo
and        re.secuencia_pagos_erp = a.secuencia_pagos_erp
and    be.e_codigo = a.e_codigo
and        be.secuencia_pagos_erp = a.secuencia_aplicada
;
-- replicar el detalle de bitacora del registro aplicado, no importa si en la bitacora quedo pendiente, cerrado o sin cuadrar replica lo que esta
-- replicar solo lo que acaba de crear?
insert    into fecxp_bit_cont_din_aper_det(
secuencia_pagos_erp, e_codigo, secuencia_cont_din_aper_det, importe_set, importe_ap, fec_ejecucion)
select a.secuencia_pagos_erp, a.e_codigo, nextval('secuencia_cont_din_aper_det'), ad.importe_set * -1, ad.importe_ap * -1, ad.fec_ejecucion
from fecxp_crear_aperturados a,
fecxp_bit_cont_din_aper_det ad
where ad.e_codigo = a.e_codigo
and ad.secuencia_pagos_erp = a.secuencia_aplicada
and    ad.fec_ejecucion = v_fec_fec_ejecucion
;
/*casos 3 y 4  una vez replicada la bitacora, debe replicar el detalle aperturado tanto si el registro fue reaperturado como si no*/
/* en ambos casos se tiene un detalle aperturado que replicar debido a que se borro al inicio si lo tenia o crearlo si es nuevo*/
---5)  replica la aperturacion para todos los que estuvieron cancelados  y no tienen un detalle de aperturacion
-- replicar el det_pagos_procesados
insert    into fecxp_det_pagos_procesados(
e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp,
sec_det_pag_proc, code_combination, importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select ca.e_codigo,
ca.secuencia_pagos_erp,
d.secuencia_det_pagos_erp,
d.numero_de_partida_erp,
nextval('sec_det_pag_proc'),
d.code_combination,
d.importe_linea * -1,
d.oracle_segmento1,
d.oracle_segmento2,
d.oracle_segmento3,
d.oracle_segmento4,
d.oracle_segmento5,
d.oracle_segmento6,
d.oracle_segmento7
from       fecxp_enc_pagos_erp e,
fecxp_enc_replicas_proc_tmp ca,
fecxp_det_pagos_procesados d
where e.e_codigo = ca.e_codigo
and    e.folio_set = ca.folio_set
and e.estatus_movimiento not in ('X','Y','Z')
and ca.procesado=0
and d.e_codigo = e.e_codigo
and d.secuencia_pagos_erp = e.secuencia_pagos_erp
;
--actualiza la bandera de registros a buscar en erp --
update    fecxp_enc_pagos_erp
set        procesado = 1
where    folio_set = coalesce(v_folio_set, folio_set)
and        procesado = 0;
/* commit; */
--invocar la ejecucion de la extraccion de cuentas de ingresos (excepto los dias lunes por la ma?ana entre las 1:00 am y las 10:am)
select to_char(clock_timestamp(), 'DAY')
into strict v_dia
;
v_dia:=trim(both v_dia);
if (upper(v_dia) = 'MONDAY' or upper(v_dia) = 'LUNES')
then
if     to_date(to_char(clock_timestamp(), 'HH24:MI'), 'HH24:MI') > to_timestamp('01:00','HH24:MI')
and to_date(to_char(clock_timestamp(), 'HH24:MI'), 'HH24:MI') < to_timestamp('10:00','HH24:MI')
then
null;--no lanza los procesos restantes
else
update fecxp_ppto_extraccion_params
set fecha_ext_sig_ejecucion = clock_timestamp(),
estatus_ppto_sig_ejecucion = 'BEGIN FECXP_GET_CTAS_CONT_INGR; END;',
usuario_ppto_sig_ejecucion = 'EJB',
fec_ini = clock_timestamp(),
estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN PROCESO'
where proceso_id = 16;
end if;
else
update fecxp_ppto_extraccion_params
set fecha_ext_sig_ejecucion = clock_timestamp(),
estatus_ppto_sig_ejecucion = 'BEGIN FECXP_GET_CTAS_CONT_INGR; END;',
usuario_ppto_sig_ejecucion = 'EJB',
fec_ini = clock_timestamp(),
estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN PROCESO'
where proceso_id = 16;
end if;
/* commit; */
/*iniciar la ejecucion automatica detalle reales
update fecxp_ppto_extraccion_params
set fec_ini = sysdate,
estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN EJECUCION'
where proceso_id = 11;
update fecxp_ppto_extraccion_params
set estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN ESPERA'
where proceso_id =12;
/* commit; */
*/
-- end;
exception
when no_data_found then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
