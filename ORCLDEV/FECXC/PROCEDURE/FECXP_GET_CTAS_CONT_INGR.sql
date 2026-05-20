create or replace procedure fecxc."fecxp_get_ctas_cont_ingr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*sept 2009  se crea este procedimiento para obtener las cuentas contables de ingresos*/
/*las cc se obtienen a partir del recibo y no son las cuentas finales de la facturaci?n*/
/*para ingresos miscel?neos y de cobranza marcados en el recibo por el tipo (misc y cash)*/
/*v2 elimina detalles previos si los hubiese*/
/*24-oct-2011 se desactiva el detalle de oracle y solo se deja el de soin, el de oracle se ejcuta por las ma?anas (5am) mediante un cron de so*/
/*12-ene-2012 se re-activa del detalle de reales oracle (se le quita la parte de aperturacion para que se haga lamitad en la noche y la mitad en la ma?ana)
tambien se reactiva el detalle de reales soin  */
v_fec_fec_ejecucion timestamp(0):= clock_timestamp();
v_folio_set varchar(150); -- := '';
v_contador integer:=0;
v_sqlcode varchar(4000);
v_sqlerrm varchar(4000);
c_1 varchar(200);
c_2 varchar(200);
c_3 varchar(200);
c_4 varchar(200);
folio_c integer;
cursor_1 cursor for select a.no_empresa, a.no_folio_det, a.receipt_number, a.num_recibo,
a.fec_valor, a.id_status_mov, a.id_tipo_operacion_set, a.fecha_actualizacion,
a.cash_receipt_id, a.receivables_trx_id, a.status_recibo, a.secuencia_dep_especiales, a.id_divisa, a.importe, a.importe_recibo,
a.code_combination, a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from  fecxp_misc_ini a
where a.es_repetido =0;
cursor_2 cursor for select a.no_empresa, a.no_folio_det, a.receipt_number, a.num_recibo,
d.fec_valor, d.id_status_mov, a.id_tipo_operacion_set, a.fecha_actualizacion,
a.cash_receipt_id, a.receivables_trx_id, a.status_recibo, d.secuencia_dep_especiales, a.id_divisa, d.importe, a.importe_recibo,
a.code_combination, a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from  fecxp_bit_ingr_misc a,
fecxp_crear_miscelaneos b,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales
and b.estatus_din_cc_apli = 'C';
cursor_3 cursor for select distinct        d.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, d.id_status_mov,
'MISC' as misc , a.estatus_din_cc, v_fec_fec_ejecucion as v_fec_fec_ejecucion1, v_fec_fec_ejecucion as v_fec_fec_ejecucion2,
a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7,
a.id_divisa, d.fec_valor, d.importe
from fecxp_bit_ingr_cc a,
fecxp_crear_miscelaneos b,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales;
cursor_4 cursor for  select no_empresa, no_folio_det,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_fact_ini
group by no_empresa, no_folio_det,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7;
cursor_5 cursor for  select   a.no_empresa, a.no_folio_det, b.receipt_number, b.num_recibo,
a.fec_valor, a.id_status_mov, a.id_tipo_operacion_set,
a.fecha_actualizacion, b.cash_receipt_id, b.customer_trx_id,
b.customer_trx_line_id, b.status_recibo, a.secuencia_dep_especiales,
a.id_divisa, a.importe, b.importe_recibo, a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6,
a.oracle_segmento7
from fecxp_fact_grp1 a, fecxp_fact_ini b
where a.no_folio_det = b.no_folio_det and a.es_repetido = 0
group by a.no_empresa,a.no_folio_det,b.receipt_number,b.num_recibo,a.fec_valor,a.id_status_mov,
a.id_tipo_operacion_set,a.fecha_actualizacion,b.cash_receipt_id,
b.customer_trx_id,b.customer_trx_line_id,b.status_recibo,
a.secuencia_dep_especiales,a.id_divisa,a.importe,b.importe_recibo,a.code_combination,a.oracle_segmento1,
a.oracle_segmento2,a.oracle_segmento3,a.oracle_segmento4,a.oracle_segmento5,a.oracle_segmento6,
a.oracle_segmento7;
begin 

/*verifica la conexi?n a ar*/
select count(cash_receipt_id)
into strict v_contador
from ar.ar_cash_receipts_all__erp_prod
where receipt_date>= clock_timestamp();
--- ======== control din?mico ======== ---
-- inhabilita para proceso aquellos registros que sobrepasen la vigencia --
-- estatus_din_cc= 'P' [pendiente], 'S' [sin cuadrar], 'C' [cerrado]  'V' [con varias cuentas]--
-- en la bit?cora permanecer?n vigentes pero despu?s se dejan de procesar para evitar encontrar duplicados y cancelaciones---
-- la bit?cora s?lo tiene folios aplicados, los cancelados se replican hasta que el aplicado encontr? cuenta --
-- pendientes son aquellos que en su ejecuci?n no encontraron alguna cuenta contable a pesar de amarrar recibo, sobretodo en cobranza --
update fecxp_bit_ingr_cc
set     estatus_din_cc = case when dias_vigencia_apertura > round(v_fec_fec_ejecucion - fec_primera_ejecucion) then 'P' else 'S' end,
fec_ultima_ejecucion = case when dias_vigencia_apertura > round(v_fec_fec_ejecucion - fec_primera_ejecucion) then v_fec_fec_ejecucion else fec_ultima_ejecucion end
where    estatus_din_cc = 'P';
/* commit; */
--marcar los que no cuadraron
update fecxc.fecxc_dep_especiales a
set procesado = 3
where exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.estatus_din_cc = 'S'
and b.fec_valor>=clock_timestamp() - interval '90 days' --optimizacion
)
and a.fec_valor>=clock_timestamp() - interval '90 days'; --optimizacion
/* commit; */
/*----------------------   miscelaneos ----------------*/
/*obtiene los recibos miscel?neos amarrados, excluyendo los folios cancelados y los guiones*/
delete from fecxp_misc_ini;
/* commit; */
insert into fecxp_misc_ini(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, receivables_trx_id, status_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select d.no_empresa, d.no_folio_det,b.receipt_number,
(trim(both replace(translate(b.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric  as num_recibo,
d.fec_valor, d.id_status_mov,d.id_tipo_operacion_set, v_fec_fec_ejecucion,
b.cash_receipt_id, b.receivables_trx_id,
b.status as status_recibo,
d.secuencia_dep_especiales,d.id_divisa, d.importe, b.amount,
a.code_combination_id, g.segment1, g.segment2, g.segment3, g.segment4, g.segment5, g.segment6, g.segment7
from fecxc.fecxc_dep_especiales d, ar.ar_cash_receipts_all__erp_prod b, ar.ar_receivables_trx_all__erp_prod a
left outer join gl.gl_code_combinations__erp_prod g on (a.code_combination_id = g.code_combination_id)
where b.receivables_trx_id = a.receivables_trx_id and b.org_id = a.org_id  and d.no_folio_det = (trim(both replace(translate(b.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric and b.type= 'MISC' and not position('_' in b.receipt_number)>0 and not position('-' in b.receipt_number)>0 and d.procesado = 0 and d.id_status_mov not in ('X','Y','Z') --and d.plataforma = 'O'
;
/* commit; */
/*una vez obtenidos los movimientos verificar si hay duplicados*/
delete from fecxp_misc_folios_repe;
/* commit; */
insert into fecxp_misc_folios_repe(no_folio_det, cuantos)
select no_folio_det, count(*)
from fecxp_misc_ini
group by no_folio_det
having count(*)>1
;
/* commit; */
/*dejar bit?cora de repetidos*/
insert into fecxp_misc_repe(no_folio_det, receipt_number, cash_receipt_id)
select a.no_folio_det, a.receipt_number, a.cash_receipt_id
from fecxp_misc_ini a,
fecxp_misc_folios_repe b
where a.no_folio_det = b.no_folio_det
;
/* commit; */
/*marcar los que est?n duplicados*/
update  fecxp_misc_ini a
set es_repetido=1
where exists (  select 1
from fecxp_misc_folios_repe b
where b.no_folio_det = a.no_folio_det
)
;
/* commit; */
-------
perform dbms_output.put_line('PASO POR BANDERA 1');
-------
/*pasar a bit?cora de miscel?neos los registros que no son duplicados*/
/* insert into fecxp_bit_ingr_misc (no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, receivables_trx_id, status_recibo, secuencia_dep_especiales, id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select a.no_empresa, a.no_folio_det, a.receipt_number, a.num_recibo,
a.fec_valor, a.id_status_mov, a.id_tipo_operacion_set, a.fecha_actualizacion,
a.cash_receipt_id, a.receivables_trx_id, a.status_recibo, a.secuencia_dep_especiales, a.id_divisa, a.importe, a.importe_recibo,
a.code_combination, a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from  fecxp_misc_ini a
where a.es_repetido =0;
/* commit; */*/
------------------------------------------aplicando cursor 1 ----------------------------------------------------------------------
for contador_1 in cursor_1 loop
begin
insert into fecxp_bit_ingr_misc(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, receivables_trx_id, status_recibo, secuencia_dep_especiales, id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7) values ( contador_1.no_empresa,       contador_1.no_folio_det,       contador_1.receipt_number,        contador_1.num_recibo,
contador_1.fec_valor,        contador_1.id_status_mov,      contador_1.id_tipo_operacion_set, contador_1.fecha_actualizacion,
contador_1.cash_receipt_id,  contador_1.receivables_trx_id, contador_1.status_recibo,         contador_1.secuencia_dep_especiales, contador_1.id_divisa, contador_1.importe, contador_1.importe_recibo,
contador_1.code_combination, contador_1.oracle_segmento1,   contador_1.oracle_segmento2,      contador_1.oracle_segmento3,
contador_1.oracle_segmento4, contador_1.oracle_segmento5,   contador_1.oracle_segmento6,      contador_1.oracle_segmento7
);
exception
when unique_violation then
null;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
end;
end loop;
---------------------------------------------------------------------------------------------------------------------
-------
perform dbms_output.put_line('PASO POR BANDERA 2');
-------
--eliminar en detalle especiales si existe una cuenta previa por cambio de tipo de empresa
delete from fecxc_dep_especiales_d d
where exists (
select 1
from fecxp_misc_ini a
where a.secuencia_dep_especiales = d.secuencia_dep_especiales
and a.es_repetido = 0
)
;
/*generar el detalle de cuentas para los ingresos encontrados*/
insert into fecxc_dep_especiales_d(secuencia_det_dep_esp, secuencia_dep_especiales, code_combination,importe_linea,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7)
select nextval('secuencia_det_dep_esp'), -------------verificar el contador
a.secuencia_dep_especiales, a.code_combination, a.importe,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from fecxp_misc_ini a
where a.es_repetido =0;
/* commit; */
/*pasar a bit?cora de ingresos primero los ingresos que encontraron su cuenta y cerrarlos*/
/*s?lo aquellos que no est?n ya en bit?cora, es decir que hayan estado pendientes */
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,code_combination,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
id_divisa, fec_valor, importe
)
select a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
'MISC', 'C', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7,
a.id_divisa, a.fec_valor, a.importe
from fecxp_misc_ini a,
fecxc_dep_especiales_d d
where a.secuencia_dep_especiales = d.secuencia_dep_especiales
and a.es_repetido =0
and not exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
)
;
/* commit; */
/*pasar a la bit?cora los que tuvieron m?s de una cuenta y marcarlos como 'V'arias ctas*/
/*s?lo insertar los que no existan previemente por estar pendientes*/
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,
id_divisa, fec_valor, importe
)
select a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
'MISC', 'V', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.id_divisa, a.fec_valor, a.importe
from fecxp_misc_ini a,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = d.secuencia_dep_especiales
and a.es_repetido =1
and not exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
)
group by      a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
a.id_divisa, a.fec_valor, a.importe
;
/* commit; */
/*cerrar los folios que estuvieron pendientes y ya encontraron una sola cuenta contable*/
/*si est? pendiente no existen r?plicas del cancelado*/
update fecxp_bit_ingr_cc a
set( code_combination, oracle_segmento1,oracle_segmento2,
oracle_segmento3,oracle_segmento4,oracle_segmento5,
oracle_segmento6,oracle_segmento7,estatus_din_cc, fec_ultima_ejecucion) =
(select b.code_combination, b.oracle_segmento1,b.oracle_segmento2,
b.oracle_segmento3,b.oracle_segmento4,b.oracle_segmento5,
b.oracle_segmento6,b.oracle_segmento7,'C', v_fec_fec_ejecucion
from  fecxp_misc_ini b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.es_repetido =0
)
where estatus_din_cc = 'P'
and exists (
select 1
from fecxp_misc_ini c
where c.secuencia_dep_especiales = a.secuencia_dep_especiales
and c.es_repetido =0
);
/* commit; */
/*marcar como folio con varias cuentas si estaba pendiente*/
/*si est? pendiente no hay r?plica del cancelado*/
update fecxp_bit_ingr_cc a
set estatus_din_cc = 'V',
fec_ultima_ejecucion = v_fec_fec_ejecucion
where estatus_din_cc = 'P'
and exists (
select 1
from fecxp_misc_ini b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.es_repetido =1
);
/* commit; */
/*replicar para los estatus cancelados para los cerrados y repetidos*/
/*identificar los folios que tienen r?plica cancelada s?lo para los que cerraron o tienen varias cuentas de esta ejecuci?n*/
/*si quedaran pendientes s?lo estar?an los aplicados*/
delete  from fecxp_crear_miscelaneos;
/* commit; */
insert into fecxp_crear_miscelaneos
select a.no_empresa, a.no_folio_det, d.secuencia_dep_especiales, a.secuencia_dep_especiales as secuencia_aplicada, a.estatus_din_cc
from fecxp_bit_ingr_cc a,
fecxc.fecxc_dep_especiales d
where  a.no_empresa = d.no_empresa
and    a.no_folio_det = d.no_folio_det
and a.tipo_cuenta = 'MISC'
and    d.id_status_mov in ('X','Y','Z')
and    d.procesado = 0
--and a.fec_ultima_ejecucion = v_fec_fec_ejecucion
and a.estatus_din_cc in ('C', 'V', 'S')
;
/* commit; */
/*una vez identificados replicar las cuentas para aquellos que est?n cerrados*/
--eliminar en detalle especiales si existe una cuenta previa por cambio de tipo de empresa
delete from fecxc_dep_especiales_d d
where exists (
select 1
from fecxp_bit_ingr_cc a,
fecxp_crear_miscelaneos b
where d.secuencia_dep_especiales = b.secuencia_dep_especiales
and a.secuencia_dep_especiales = b.secuencia_aplicada
and a.estatus_din_cc = 'C'
)
;
/*primero pasar las cuentas al detalle*/
/*generar el detalle de cuentas para los ingresos encontrados*/
insert into fecxc_dep_especiales_d(secuencia_det_dep_esp, secuencia_dep_especiales, code_combination,importe_linea,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7)
select nextval('secuencia_det_dep_esp'),
b.secuencia_dep_especiales, a.code_combination, (-1) * a.importe,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from fecxp_bit_ingr_cc a,
fecxp_crear_miscelaneos b
where a.secuencia_dep_especiales = b.secuencia_aplicada
and a.estatus_din_cc = 'C'
;
/* commit; */
/*generar las bit?coras*/
/*la de miscel?neos*/
/*insert into fecxp_bit_ingr_misc (no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, receivables_trx_id, status_recibo, secuencia_dep_especiales, id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select a.no_empresa, a.no_folio_det, a.receipt_number, a.num_recibo,
d.fec_valor, d.id_status_mov, a.id_tipo_operacion_set, a.fecha_actualizacion,
a.cash_receipt_id, a.receivables_trx_id, a.status_recibo, d.secuencia_dep_especiales, a.id_divisa, d.importe, a.importe_recibo,
a.code_combination, a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from  fecxp_bit_ingr_misc a,
fecxp_crear_miscelaneos b,
fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales
and b.estatus_din_cc_apli = 'C'
;
/* commit; */*/
-------
perform dbms_output.put_line('PASO POR BANDERA 4');
-------
------------------------------------------aplicando cursor 2 ----------------------------------------------------------------------
for contador_2 in cursor_2 loop
c_2:= contador_2.secuencia_dep_especiales;
begin
insert into fecxp_bit_ingr_misc(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, receivables_trx_id, status_recibo, secuencia_dep_especiales, id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7) values (contador_2.no_empresa,       contador_2.no_folio_det,       contador_2.receipt_number,        contador_2.num_recibo,
contador_2.fec_valor,        contador_2.id_status_mov,      contador_2.id_tipo_operacion_set, contador_2.fecha_actualizacion,
contador_2.cash_receipt_id,  contador_2.receivables_trx_id, contador_2.status_recibo,         contador_2.secuencia_dep_especiales, contador_2.id_divisa, contador_2.importe, contador_2.importe_recibo,
contador_2.code_combination, contador_2.oracle_segmento1,   contador_2.oracle_segmento2,      contador_2.oracle_segmento3,
contador_2.oracle_segmento4, contador_2.oracle_segmento5,   contador_2.oracle_segmento6,      contador_2.oracle_segmento7
);
exception
when unique_violation then
null;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
end;
end loop;
---------------------------------------------------------------------------------------------------------------------
-------
perform dbms_output.put_line('PASO POR BANDERA 5');
-------
/*la bit?cora de ingresos*/
/*insert into fecxp_bit_ingr_cc (secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,code_combination,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
id_divisa, fec_valor, importe
)
select distinct d.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, d.id_status_mov,
'MISC', a.estatus_din_cc, v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7,
a.id_divisa, d.fec_valor, d.importe
from fecxp_bit_ingr_cc a,
fecxp_crear_miscelaneos b,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales
;*/
----------------------------------------aplicando cursor 3 ----------------------------------------------------------------------
for contador_3 in cursor_3 loop
--c_3:= contador_3.secuencia_dep_especiales;
begin
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,code_combination,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
id_divisa, fec_valor, importe
) values (    contador_3.secuencia_dep_especiales,  contador_3.no_empresa,       contador_3.no_folio_det,         contador_3.id_status_mov,
contador_3.misc,                      contador_3.estatus_din_cc,   contador_3.v_fec_fec_ejecucion1, contador_3.v_fec_fec_ejecucion2,contador_3.code_combination,
contador_3.oracle_segmento1 ,         contador_3.oracle_segmento2, contador_3.oracle_segmento3,
contador_3.oracle_segmento4 ,         contador_3.oracle_segmento5, contador_3.oracle_segmento6,     contador_3.oracle_segmento7,
contador_3.id_divisa,                 contador_3.fec_valor,        contador_3.importe
);
exception
when unique_violation then
null;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
null;
end;
end loop;
---------------------------------------------------------------------------------------------------------------------
-------
perform dbms_output.put_line('PASO POR BANDERA 6');
-------
/* commit; */
/* termina cancelados*/
/*marcar los miscel?neos encontrados: cerrados, con varias cuentas y sin encontrar cuenta */
update fecxc.fecxc_dep_especiales a
set procesado = 1
where procesado= 0
and exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.tipo_cuenta = 'MISC'
and b.estatus_din_cc in ('C','V','S')
)
;
/* commit; */
/*===============================================================================================================================*/
/***---------------------cobranza--------------------------*/
/*===============================================================================================================================*/
/*una vez obtenidas las cuentas de recibos miscel?neos obtener las cuentas de factura para cobranza*/
delete from fecxp_fact_ini;
/* commit; */
insert into fecxp_fact_ini(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, customer_trx_id,customer_trx_line_id,
status_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select d.no_empresa, d.no_folio_det,r.receipt_number,
(trim(both replace(translate(r.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric  as num_recibo,
d.fec_valor, d.id_status_mov,d.id_tipo_operacion_set, v_fec_fec_ejecucion,
r.cash_receipt_id, a.applied_customer_trx_id,f.customer_trx_line_id,
r.status as status_recibo,  d.secuencia_dep_especiales,d.id_divisa, d.importe, r.amount,
h.code_combination_id, g.segment1, g.segment2, g.segment3, g.segment4, g.segment5, g.segment6, g.segment7
from    ar.ar_cash_receipts_all__erp_prod r,
apps.ar_receivable_applications_all__erp_prod a,
ar.ra_customer_trx_all__erp_prod  ct,
ar.ra_customer_trx_lines_all__erp_prod f,
ar.ra_cust_trx_line_gl_dist_all__erp_prod h,
gl.gl_code_combinations__erp_prod g,
fecxc.fecxc_dep_especiales d
where not position('_' in r.receipt_number)>0
and not position('-' in r.receipt_number)>0
and r.type='CASH'
and d.procesado = 0
and d.id_status_mov not in ('X','Y','Z')
--and d.plataforma = 'O'
and d.no_folio_det= (trim(both replace(translate(r.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',' '),' ','')))::numeric
and a.cash_receipt_id = r.cash_receipt_id
and a.org_id = r.org_id
and a.status='APP'
and a.display = 'Y'
and    ct.customer_trx_id = a.applied_customer_trx_id
and ct.org_id = a.org_id
and f.org_id = ct.org_id
and f.customer_trx_id = ct.customer_trx_id
--para facturas
--and f.customer_trx_line_id = ff.link_to_cust_trx_line_id (+)
--and ct.org_id = h.org_id
--and ct.customer_trx_id = h.customer_trx_id
and f.line_type ='LINE'
and h.customer_trx_line_id = f.customer_trx_line_id
and    h.account_class in ('REV')
and g.code_combination_id = h.code_combination_id
group by  d.no_empresa, d.no_folio_det,r.receipt_number,
(trim(both replace(translate(r.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric ,
d.fec_valor, d.id_status_mov,d.id_tipo_operacion_set, v_fec_fec_ejecucion,
r.cash_receipt_id, a.applied_customer_trx_id,f.customer_trx_line_id,
r.status,  d.secuencia_dep_especiales,d.id_divisa, d.importe, r.amount,
h.code_combination_id, g.segment1, g.segment2, g.segment3, g.segment4, g.segment5, g.segment6, g.segment7
;
/* commit; */
/*se agrupan las cuentas por recibo para trabajar sobre las diferencias*/
/*posibilidades:  un folio con varios recibos, las cuentas finales pueden coincidir o no*/
/*un folio con un recibo y varias aplicaciones cuyas cuentas pueden coincidir o no*/
delete from fecxp_fact_grp1;
/* commit; */
/*insert into fecxp_fact_grp1 (no_empresa, no_folio_det,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select no_empresa, no_folio_det,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_fact_ini
group by no_empresa, no_folio_det,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
;*/
----------------------------------------aplicando cursor 4 ----------------------------------------------------------------------
for contador_4 in cursor_4 loop
begin
insert into fecxp_fact_grp1(no_empresa, no_folio_det,fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
secuencia_dep_especiales,id_divisa, importe,code_combination,oracle_segmento1, oracle_segmento2,
oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
values (    contador_4.no_empresa,              contador_4.no_folio_det,    contador_4.fec_valor,        contador_4.id_status_mov,   contador_4.id_tipo_operacion_set,contador_4.fecha_actualizacion,
contador_4.secuencia_dep_especiales,contador_4.id_divisa,       contador_4.importe,          contador_4.code_combination,contador_4.oracle_segmento1,     contador_4.oracle_segmento2,
contador_4.oracle_segmento3,        contador_4.oracle_segmento4,contador_4.oracle_segmento5, contador_4.oracle_segmento6,contador_4.oracle_segmento7
);
exception
when unique_violation then
null;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
end;
end loop;
---------------------------------------------------------------------------------------------------------------------
-------
perform dbms_output.put_line('PASO POR BANDERA 7');
-------
/* commit; */
/*una vez agrupado identificar los folios que tienen varias cuentas contables para un mismo folio*/
/*una vez obtenidos los movimientos verificar si hay duplicados*/
delete from fecxp_fact_folios_var;
/* commit; */
insert into fecxp_fact_folios_var(no_folio_det, cuantos)
select no_folio_det, count(*)
from fecxp_fact_grp1
group by no_folio_det
having count(*)>1
;
/* commit; */
/*dejar una bit?cora de folios de factura con m?s de una cuenta contable*/
insert into fecxp_fact_var(no_folio_det, receipt_number, cash_receipt_id, customer_trx_id, customer_trx_line_id, code_combination)
select a.no_folio_det, a.receipt_number, a.cash_receipt_id, a.customer_trx_id, a.customer_trx_line_id, a.code_combination
from fecxp_fact_ini a,
fecxp_fact_folios_var b
where a.no_folio_det = b.no_folio_det
group by a.no_folio_det, a.receipt_number, a.cash_receipt_id, a.customer_trx_id, a.customer_trx_line_id, a.code_combination
;
/* commit; */
/*marcar en la tabla agrupada los folios que est?n repetidos*/
update fecxp_fact_grp1 a
set es_repetido = 1
where exists (
select 1
from fecxp_fact_folios_var b
where b.no_folio_det = a.no_folio_det
);
/* commit; */
/*una vez agrupados e identificados los de cuenta m?ltiple, tomar los que son v?lidos*/
/*existe la posibilidad de que un mismo folio se haya ligado a varias cuentas y que al final todas coincidan*/
/*se esta duplicando informacion
insert into fecxp_bit_ingr_fact (no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, customer_trx_id,customer_trx_line_id,
status_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select  a.no_empresa, a.no_folio_det, b.receipt_number, b.num_recibo,
a.fec_valor, a.id_status_mov,a.id_tipo_operacion_set,a.fecha_actualizacion,
b.cash_receipt_id, b.customer_trx_id,b.customer_trx_line_id,
b.status_recibo, a.secuencia_dep_especiales,a.id_divisa, a.importe, b.importe_recibo,
a.code_combination,a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from   fecxp_fact_grp1 a,
fecxp_fact_ini b
where a.no_folio_det = b.no_folio_det
and    a.es_repetido=0
group by a.no_empresa, a.no_folio_det, b.receipt_number, b.num_recibo,
a.fec_valor, a.id_status_mov,a.id_tipo_operacion_set,a.fecha_actualizacion,
b.cash_receipt_id, b.customer_trx_id,b.customer_trx_line_id,
b.status_recibo, a.secuencia_dep_especiales,a.id_divisa, a.importe, b.importe_recibo,
a.code_combination,a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
;
*/
for u in cursor_5 loop
folio_c:=u.no_folio_det;
begin
insert into fecxp_bit_ingr_fact(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, customer_trx_id,customer_trx_line_id,
status_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
values (
u.no_empresa,       u.no_folio_det,            u.receipt_number, u.num_recibo,
u.fec_valor,        u.id_status_mov,           u.id_tipo_operacion_set,u.fecha_actualizacion,
u.cash_receipt_id,  u.customer_trx_id,         u.customer_trx_line_id,
u.status_recibo,    u.secuencia_dep_especiales,u.id_divisa, u.importe, u.importe_recibo,
u.code_combination, u.oracle_segmento1,        u.oracle_segmento2, u.oracle_segmento3,
u.oracle_segmento4, u.oracle_segmento5,        u.oracle_segmento6, u.oracle_segmento7);
exception
when unique_violation then
null;
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat(folio_c, 'Error:' , sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
end;
end loop;
/* commit; */
--eliminar si existiese un detalle previo por cambio de empresa
delete from fecxc_dep_especiales_d d
where exists (
select 1
from fecxp_fact_grp1 a
where d.secuencia_dep_especiales = a.secuencia_dep_especiales
and a.es_repetido =0
);
/*generar el detalle de cuentas para los ingresos encontrados*/
insert into fecxc_dep_especiales_d(secuencia_det_dep_esp, secuencia_dep_especiales, code_combination,importe_linea,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7)
select nextval('secuencia_det_dep_esp'), -------------verificar el contador
a.secuencia_dep_especiales, a.code_combination, a.importe,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from fecxp_fact_grp1 a
where a.es_repetido =0;
/* commit; */
/*pasar a bit?cora de ingresos primero los ingresos que encontraron su cuenta y cerrarlos*/
/*ingresa s?lo los folios que no exist?an */
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,code_combination,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
id_divisa, fec_valor, importe
)
select a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
'CASH', 'C', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7,
a.id_divisa, a.fec_valor, a.importe
from fecxp_fact_grp1 a,
fecxc_dep_especiales_d d
where a.secuencia_dep_especiales = d.secuencia_dep_especiales
and a.es_repetido =0
and not exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
)
;
/* commit; */
/*pasar a la bit?cora los que tuvieron m?s de una cuenta y marcarlos como 'V'arias ctas*/
/*ingresa s?lo los folios que no exist?an*/
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,
id_divisa, fec_valor, importe
)
select a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
'CASH', 'V', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.id_divisa, a.fec_valor, a.importe
from fecxp_fact_grp1 a,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = d.secuencia_dep_especiales
and a.es_repetido =1
and not exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
)
group by      a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
a.id_divisa, a.fec_valor, a.importe
;
/* commit; */
/*cerrar los folios que estuvieron pendientes y ya encontraron una sola cuenta contable*/
/*si est? pendiente no existe r?plica cancelada si la tuviera*/
update fecxp_bit_ingr_cc a
set( code_combination, oracle_segmento1,oracle_segmento2,
oracle_segmento3,oracle_segmento4,oracle_segmento5,
oracle_segmento6,oracle_segmento7,estatus_din_cc, fec_ultima_ejecucion) =
(select b.code_combination, b.oracle_segmento1,b.oracle_segmento2,
b.oracle_segmento3,b.oracle_segmento4,b.oracle_segmento5,
b.oracle_segmento6,b.oracle_segmento7,'C', v_fec_fec_ejecucion
from  fecxp_fact_grp1 b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.es_repetido =0
)
where estatus_din_cc = 'P'
and exists (
select 1
from fecxp_fact_grp1 c
where c.secuencia_dep_especiales = a.secuencia_dep_especiales
and c.es_repetido =0
);
/* commit; */
/*marcar como folio con varias cuentas si estaba pendiente*/
update fecxp_bit_ingr_cc a
set estatus_din_cc = 'V'
where exists (
select 1
from fecxp_fact_grp1 b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.es_repetido =1
);
/* commit; */
/*cancelados  para cobranza*/
/*replicar para los estatus cancelados para los cerrados y repetidos*/
/*identificar los folios que tienen r?plica cancelada s?lo para los que cerraron o tienen varias cuentas de esta ejecuci?n*/
/*si quedaran pendientes s?lo estar?an los aplicados*/
delete  from fecxp_crear_fact;
/* commit; */
insert into fecxp_crear_fact
select a.no_empresa, a.no_folio_det, d.secuencia_dep_especiales, a.secuencia_dep_especiales as secuencia_aplicada, a.estatus_din_cc
from fecxp_bit_ingr_cc a,
fecxc.fecxc_dep_especiales d
where  a.no_empresa = d.no_empresa
and    a.no_folio_det = d.no_folio_det
and a.tipo_cuenta = 'CASH'
and    d.id_status_mov in ('X','Y','Z')
and    d.procesado = 0
--and a.fec_ultima_ejecucion = v_fec_fec_ejecucion
and a.estatus_din_cc in ('C', 'V', 'S')
;
/* commit; */
/*una vez identificados replicar las cuentas para aquellos que est?n cerrados*/
delete from fecxc_dep_especiales_d d
where exists (
select 1
from fecxp_bit_ingr_cc a,
fecxp_crear_fact b
where d.secuencia_dep_especiales = b.secuencia_dep_especiales
and a.secuencia_dep_especiales = b.secuencia_aplicada
and a.estatus_din_cc = 'C'
)
;
/*primero pasar las cuentas al detalle*/
/*generar el detalle de cuentas para los ingresos encontrados*/
insert into fecxc_dep_especiales_d(secuencia_det_dep_esp, secuencia_dep_especiales, code_combination,importe_linea,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7)
select nextval('secuencia_det_dep_esp'),
b.secuencia_dep_especiales, a.code_combination, (-1) * a.importe,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from fecxp_bit_ingr_cc a,
fecxp_crear_fact b
where a.secuencia_dep_especiales = b.secuencia_aplicada
and a.estatus_din_cc = 'C'
;
/* commit; */
/*generar las bit?coras*/
/*la de facturas*/
insert into fecxp_bit_ingr_fact(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, customer_trx_id,customer_trx_line_id,
status_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo,
code_combination,oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select  a.no_empresa, a.no_folio_det, a.receipt_number, a.num_recibo,
d.fec_valor, d.id_status_mov,a.id_tipo_operacion_set,a.fecha_actualizacion,
a.cash_receipt_id, a.customer_trx_id,a.customer_trx_line_id,
a.status_recibo, d.secuencia_dep_especiales,a.id_divisa, d.importe, a.importe_recibo,
a.code_combination,a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3,
a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7
from   fecxp_bit_ingr_fact a,
fecxp_crear_fact b,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales
and b.estatus_din_cc_apli = 'C'
;
/* commit; */
/*la bit?cora de ingresos*/
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,code_combination,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
id_divisa, fec_valor, importe
)
select d.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, d.id_status_mov,
'CASH', a.estatus_din_cc, v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.code_combination,
a.oracle_segmento1, a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4,
a.oracle_segmento5, a.oracle_segmento6, a.oracle_segmento7,
a.id_divisa, d.fec_valor, d.importe
from fecxp_bit_ingr_cc a,
fecxp_crear_fact b,
fecxc.fecxc_dep_especiales d
where a.secuencia_dep_especiales = b.secuencia_aplicada
and d.secuencia_dep_especiales = b.secuencia_dep_especiales
;
/* commit; */
/* termina cancelados para cobranza*/
/*marcar los de cobranza*/
/*marcar los miscel?neos encontrados */
update fecxc.fecxc_dep_especiales a
set procesado = 2
where procesado= 0
and exists (
select 1
from fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
and b.tipo_cuenta = 'CASH'
and b.estatus_din_cc in ('C','V','S')
)
;
/* commit; */
/*ya que se han marcado todos los folios identificar los que no amarraron y que por tanto quedar?an pendientes*/
-- maneja la ?ltima fecha de procesamiento para los pendientes--
update    fecxp_bit_ingr_cc
set        fec_ultima_ejecucion = v_fec_fec_ejecucion
where    estatus_din_cc = 'P';
---insertar en una estructura aquellos que tienen recibos
delete from fecxp_pend_recibos
;
/* commit; */
insert into fecxp_pend_recibos(no_empresa, no_folio_det,receipt_number, num_recibo,
fec_valor, id_status_mov,id_tipo_operacion_set,fecha_actualizacion,
cash_receipt_id, status_recibo, tipo_recibo, secuencia_dep_especiales,id_divisa, importe, importe_recibo)
select d.no_empresa, d.no_folio_det,b.receipt_number,
(trim(both replace(translate(b.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric  as num_recibo,
d.fec_valor, d.id_status_mov,d.id_tipo_operacion_set, v_fec_fec_ejecucion,
b.cash_receipt_id, b.status as status_recibo, b.type,
d.secuencia_dep_especiales,d.id_divisa, d.importe, b.amount
from    ar.ar_cash_receipts_all__erp_prod b
,fecxc.fecxc_dep_especiales d
where d.no_folio_det = (trim(both replace(translate(b.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric
and not position('_' in b.receipt_number)>0
and not position('-' in b.receipt_number)>0
and d.procesado = 0
and d.id_status_mov not in ('X','Y','Z')
group by d.no_empresa, d.no_folio_det,b.receipt_number,
(trim(both replace(translate(b.receipt_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-',' '),' ','')))::numeric ,
d.fec_valor, d.id_status_mov,d.id_tipo_operacion_set, v_fec_fec_ejecucion,
b.cash_receipt_id, b.status, b.type,
d.secuencia_dep_especiales,d.id_divisa, d.importe, b.amount
;
/* commit; */
--una vez identificados  insertar a la bit?cora de ingresos con estatus pendiente y que no existan previamente
insert into fecxp_bit_ingr_cc(secuencia_dep_especiales, no_empresa, no_folio_det, id_status_mov,
tipo_cuenta, estatus_din_cc, fec_primera_ejecucion, fec_ultima_ejecucion,
id_divisa, fec_valor, importe
)
select a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
a.tipo_recibo, 'P', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.id_divisa, a.fec_valor, a.importe
from     fecxp_pend_recibos a
where not exists (
select 1
from   fecxp_bit_ingr_cc b
where b.secuencia_dep_especiales = a.secuencia_dep_especiales
)
group by   a.secuencia_dep_especiales, a.no_empresa, a.no_folio_det, a.id_status_mov,
a.tipo_recibo, 'P', v_fec_fec_ejecucion, v_fec_fec_ejecucion,
a.id_divisa, a.fec_valor, a.importe
;
/* commit; */
/*iniciar la ejecuci?n autom?tica detalle reales*/
/*se desactiva el detalle de reales oracle 24-oct-2011, esto se desactivo por que durante las noches o temrina de ejecutarse ya que bajan el erp */
/*se reactiva el detalle de reales oracle 12/ene/2012, se le quito la aperturacion para que se ejecute 1/2 en la noche y la paerturacion por las ma?anas*/
update fecxp_ppto_extraccion_params
set fec_ini = clock_timestamp(),
estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN EJECUCION'
where proceso_id = 11;
update fecxp_ppto_extraccion_params
set estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN ESPERA'
where proceso_id =12;
/*se activa el detalle de reales soin 24-oct-2011 */
/*se desactiva y se deja como originalmente estaba 12/01/2012*/
/*update fecxp_ppto_extraccion_params
set fec_ini = sysdate,
estatus_ext_ult_ejecucion = 'ERROR',
alertar=0,
estatus_proceso='EN EJECUCION'
where proceso_id = 12;*/
/* commit; */
perform dbms_output.put_line('TERMINO CORRECTAMENTE');
exception
when no_data_found then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
end;
$body$
language plpgsql
;
