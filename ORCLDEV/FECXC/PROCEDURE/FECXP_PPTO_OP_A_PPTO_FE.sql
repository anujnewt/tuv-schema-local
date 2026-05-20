create or replace procedure fecxc."fecxp_ppto_op_a_ppto_fe"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

----- extrae el presupuesto ----
insert into fecxp_ppto_opera_erp(e_codigo,
secuencia_ptto_oracle,
periodo_extraccion,
mes_de_extraccion,
periodo_ppto,
libro_id,
version_id,
moneda,
code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
ppto_01, pss_01, usd_01, eur_01,
ppto_02, pss_02, usd_02, eur_02,
ppto_03, pss_03, usd_03, eur_03,
ppto_04, pss_04, usd_04, eur_04,
ppto_05, pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06, eur_06,
ppto_07, pss_07, usd_07, eur_07,
ppto_08, pss_08, usd_08, eur_08,
ppto_09, pss_09, usd_09, eur_09,
ppto_10, pss_10, usd_10, eur_10,
ppto_11, pss_11, usd_11, eur_11,
ppto_12, pss_12, usd_12, eur_12)
select  glp.cia,
nextval('secuencia_ptto_oracle'),
(to_char(clock_timestamp(),'YYYY'))::numeric ,
(to_char(clock_timestamp(),'MM'))::numeric ,
glp.yyyy,
glp.libro_id,
glp.version_id,
glp.moneda,
cc.code_combination_id,
glp.cia, glp.neg, glp.cta, glp.scta, glp.cc, glp.icia, glp.top,
glp.ppto_01, tc.pss_01, tc.usd_01, tc.eur_01,
glp.ppto_02, tc.pss_02, tc.usd_02, tc.eur_02,
glp.ppto_03, tc.pss_03, tc.usd_03, tc.eur_03,
glp.ppto_04, tc.pss_04, tc.usd_04, tc.eur_04,
glp.ppto_05, tc.pss_05, tc.usd_05, tc.eur_05,
glp.ppto_06, tc.pss_06, tc.usd_06, tc.eur_06,
glp.ppto_07, tc.pss_07, tc.usd_07, tc.eur_07,
glp.ppto_08, tc.pss_08, tc.usd_08, tc.eur_08,
glp.ppto_09, tc.pss_09, tc.usd_09, tc.eur_09,
glp.ppto_10, tc.pss_10, tc.usd_10, tc.eur_10,
glp.ppto_11, tc.pss_11, tc.usd_11, tc.eur_11,
glp.ppto_12, tc.pss_12, tc.usd_12, tc.eur_12
from	gl.gl_code_combinations__erp_prod cc,
interface.xxglb_pptos__erp_prod glp,
interface.xxglb_pptos_tc__erp_prod tc
where   cc.segment1 = glp.cia
and		cc.segment2 = glp.neg
and		cc.segment3 = glp.cta
and		cc.segment4 = glp.scta
and		cc.segment5 = glp.cc
and		cc.segment6 = glp.icia
and		cc.segment7 = glp.top
and     cc.chart_of_accounts_id = '101'
and		glp.moneda <> 'PSS'
and		tc.libro_id = glp.libro_id;
------------------------------------------------------------------------------------------------------------------------
-- conversion presupuesto soin
-- presupuesto_estatus : 'E' extraido, 'C', convertido, 'I' importado (por archivo de texto)
------------------------------------------------------------------------------------------------------------------------
insert	into fecxp_ppto_conversion_soin(
e_codigo,secuencia_ppto_operativo_soin, periodo, mescod, arsmap, aejmap,
cncmap, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, presupuesto_estatus)
select	e_codigo,nextval('secuencia_ppto_operativo_soin'), periodo, mescod, arsmap, aejmap,
cncmap, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, 'EXTRAIDO'
from	fecxp_ppto_operativo_soin;
--actualiza presupuesto (de operativo a "convertido" )  .
update	fecxp_ppto_conversion_soin pfe
set		importe_linea = 0,
presupuesto_estatus = 'CONVERTIDO'
where	exists (
select	1
from	fecxp_reglas_conversion_ppto rc
where (pfe.arsmap >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pfe.arsmap <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pfe.aejmap >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pfe.aejmap <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pfe.cncmap >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pfe.cncmap <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pfe.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pfe.mescod >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pfe.mescod <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and		rc.plataforma = 'SOIN');
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- conversion presupuesto oracle
-- presupuesto_estatus : 'E' extraido, 'C', convertido, 'I' importado (por archivo de texto)
------------------------------------------------------------------------------------------------------------------------
/*
periodo_extraccion int
mes_extraccion int
presupuesto_estatus varchar (20)
*/
-- dado que no se manejan los sqlstrings, debera ser necesario hacer un insert por cada mes.
--solo para efectos de prueba  .
--truncate table fecxp_ppto_conversion_erp;
--quedaria mejor con "decode" .
-- mes 1
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 1, libro_id, version_id,
moneda, case
when moneda = 'MXP' then pss_01
when moneda = 'USD' then usd_01
when moneda = 'EUR' then eur_01 end,
code_combination_id, ppto_01, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 2
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 2, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_02
when moneda = 'USD' then usd_02
when moneda = 'EUR' then eur_02 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 3
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 3, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_03
when moneda = 'USD' then usd_03
when moneda = 'EUR' then eur_03 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 4
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 4, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_04
when moneda = 'USD' then usd_04
when moneda = 'EUR' then eur_04 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 5
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 5, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_05
when moneda = 'USD' then usd_05
when moneda = 'EUR' then eur_05 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 6
insert	into fecxp_ppto_conversion_erp(
e_codigo,secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 6, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_06
when moneda = 'USD' then usd_06
when moneda = 'EUR' then eur_06 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 7
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion,  periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 7, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_07
when moneda = 'USD' then usd_07
when moneda = 'EUR' then eur_07 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 8
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 8, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_08
when moneda = 'USD' then usd_08
when moneda = 'EUR' then eur_08 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 9
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo, nextval('secuencia_ptto_conversion'),(to_char(clock_timestamp(),'YYYY'))::numeric , 9, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_09
when moneda = 'USD' then usd_09
when moneda = 'EUR' then eur_09 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 10
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo,nextval('secuencia_ptto_conversion'), (to_char(clock_timestamp(),'YYYY'))::numeric , 10, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_10
when moneda = 'USD' then usd_10
when moneda = 'EUR' then eur_10 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 11
insert	into fecxp_ppto_conversion_erp(
e_codigo,secuencia_ptto_conversion,  periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo,nextval('secuencia_ptto_conversion'), (to_char(clock_timestamp(),'YYYY'))::numeric , 11, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_11
when moneda = 'USD' then usd_11
when moneda = 'EUR' then eur_11 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
-- mes 12
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus)
select	e_codigo,nextval('secuencia_ptto_conversion'), (to_char(clock_timestamp(),'YYYY'))::numeric , 12, libro_id, version_id,
moneda,
case
when moneda = 'MXP' then pss_12
when moneda = 'USD' then usd_12
when moneda = 'EUR' then eur_12 end,
code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO'
from	fecxp_ppto_opera_erp;
------------------------------------ fin meses -------------------------------
update	fecxp_ppto_conversion_erp pfe
set		importe_linea = 0,
presupuesto_estatus = 'CONVERTIDO'
where exists (
select 1
from   fecxp_reglas_conversion_ppto rc
where (pfe.oracle_segmento1 >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pfe.oracle_segmento1 <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pfe.oracle_segmento2 >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pfe.oracle_segmento2 <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pfe.oracle_segmento3 >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pfe.oracle_segmento3 <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pfe.oracle_segmento4 >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pfe.oracle_segmento4 <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pfe.oracle_segmento5 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pfe.oracle_segmento5 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pfe.oracle_segmento6 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pfe.oracle_segmento6 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pfe.oracle_segmento7 >= rc.reg_segmento7_ini or nullif(rc.reg_segmento7_ini::text, '') is null)
and (pfe.oracle_segmento7 <= rc.reg_segmento7_fin or nullif(rc.reg_segmento7_fin::text, '') is null)
and (pfe.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pfe.mes >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pfe.mes <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and		rc.plataforma = 'ORACLE');
/* commit; */
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
