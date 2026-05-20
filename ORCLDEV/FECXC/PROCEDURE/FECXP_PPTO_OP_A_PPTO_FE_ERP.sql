create or replace procedure fecxc."fecxp_ppto_op_a_ppto_fe_erp"  ( v_version_fe integer, v_usuario_id varchar, v_comentario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
c_code_comb cursor for
select distinct e_codigo as e_codigo from fecxp_ppto_conversion_erp where version_fe=v_version_fe;
/*incluye modificacion de filtro y de periodo*/
/*20090713  modificacion para todas las monedas*/
/*07-dic-2010 modificacion para que tome los meses acumulados de las poiticas*/
/*07-may-2012 se agrega cursor para update por que con el exist no terminaba*/
begin 

delete    from fecxp_ppto_conversion_erp_enc
where    version_fe = v_version_fe;
delete    from fecxp_ppto_conversion_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
-- mes 1
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 1, libro_id, version_id,
moneda, tc_01,code_combination_id, ppto_01, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 2
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 2, libro_id, version_id,
moneda,    tc_02,code_combination_id, ppto_02, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 3
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 3, libro_id, version_id,
moneda,tc_03,code_combination_id, ppto_03, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 4
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 4, libro_id, version_id,
moneda,tc_04,code_combination_id, ppto_04, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 5
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 5, libro_id, version_id,
moneda,tc_05,code_combination_id, ppto_05, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 6
insert    into fecxp_ppto_conversion_erp(
e_codigo,secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 6, libro_id, version_id,
moneda,tc_06,code_combination_id, ppto_06, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 7
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion,  periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 7, libro_id, version_id,
moneda,tc_07,code_combination_id, ppto_07, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 8
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 8, libro_id, version_id,
moneda,tc_08,code_combination_id, ppto_08, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 9
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo, nextval('secuencia_ptto_conversion'), periodo_ppto, 9, libro_id, version_id,
moneda,tc_09,code_combination_id, ppto_09, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 10
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo,nextval('secuencia_ptto_conversion'), periodo_ppto, 10, libro_id, version_id,
moneda,tc_10,code_combination_id, ppto_10, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 11
insert    into fecxp_ppto_conversion_erp(
e_codigo,secuencia_ptto_conversion,  periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo,nextval('secuencia_ptto_conversion'), periodo_ppto, 11, libro_id, version_id,
moneda,tc_11,code_combination_id, ppto_11, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
-- mes 12
insert    into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig)
select    e_codigo,nextval('secuencia_ptto_conversion'), periodo_ppto, 12, libro_id, version_id,
moneda,tc_12,code_combination_id, ppto_12, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, (to_char(clock_timestamp(),'YYYY'))::numeric , (to_char(clock_timestamp(),'MM'))::numeric , 'EXTRAIDO', version_fe,
mon_func, mon_orig
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
;
------------------------------------ fin meses -------------------------------
update    fecxp_ppto_conversion_erp pfe
set        importe_linea = 0,
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
and        rc.plataforma = 'ORACLE'
and        rc.mes_acumulacion = 0)
and        version_fe = v_version_fe
and e_codigo = coalesce(v_e_codigo, e_codigo);
insert into fecxp_ppto_combina_erp_tmp(e_codigo,libro_id,version_id,moneda,code_combination,mes_acumulacion)
select      distinct pa.e_codigo, pa.libro_id, pa.version_id, pa.moneda,pa.code_combination,rc.mes_acumulacion
from      fecxp_ppto_conversion_erp pa,  fecxp_reglas_conversion_ppto rc
where (pa.oracle_segmento1 >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pa.oracle_segmento1 <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pa.oracle_segmento2 >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pa.oracle_segmento2 <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pa.oracle_segmento3 >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pa.oracle_segmento3 <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pa.oracle_segmento4 >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pa.oracle_segmento4 <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pa.oracle_segmento5 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pa.oracle_segmento5 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pa.oracle_segmento6 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pa.oracle_segmento6 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pa.oracle_segmento7 >= rc.reg_segmento7_ini or nullif(rc.reg_segmento7_ini::text, '') is null)
and (pa.oracle_segmento7 <= rc.reg_segmento7_fin or nullif(rc.reg_segmento7_fin::text, '') is null)
and (pa.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pa.mes >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pa.mes <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and        rc.plataforma = 'ORACLE'
--and        rc.mes_acumulacion >= pa.mes --modificado 07/12/2010 para tomar en cuenta todos los meses en las politicas de acumulados
and    pa.version_fe = v_version_fe
and pa.e_codigo = coalesce(v_e_codigo, e_codigo);
insert into fecxp_ppto_acumulado_erp_tmp(e_codigo,libro_id,version_id,moneda,code_combination,periodo_extraccion,mes_extraccion,importe_linea)
select      pa.e_codigo, pa.libro_id, pa.version_id, pa.moneda,pa.code_combination,pa.periodo_extraccion,pa.mes_extraccion,sum(pa.importe_linea) as importe_linea
from      fecxp_ppto_conversion_erp pa
where exists (
select 1
from   fecxp_reglas_conversion_ppto rc
where (pa.oracle_segmento1 >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pa.oracle_segmento1 <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pa.oracle_segmento2 >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pa.oracle_segmento2 <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pa.oracle_segmento3 >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pa.oracle_segmento3 <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pa.oracle_segmento4 >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pa.oracle_segmento4 <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pa.oracle_segmento5 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pa.oracle_segmento5 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pa.oracle_segmento6 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pa.oracle_segmento6 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pa.oracle_segmento7 >= rc.reg_segmento7_ini or nullif(rc.reg_segmento7_ini::text, '') is null)
and (pa.oracle_segmento7 <= rc.reg_segmento7_fin or nullif(rc.reg_segmento7_fin::text, '') is null)
and (pa.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pa.mes >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pa.mes <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and        rc.plataforma = 'ORACLE'
--and        rc.mes_acumulacion >= pa.mes --modificado 07/12/2010 para tomar en cuenta todos los meses en las politicas de acumulados
)
and    pa.version_fe = v_version_fe
and pa.e_codigo = coalesce(v_e_codigo, e_codigo)
group by pa.e_codigo, pa.libro_id, pa.version_id, pa.moneda,pa.code_combination, pa.periodo_extraccion,pa.mes_extraccion;
/*comentado 08052012 por que no terminaba*/
/*update fecxp_ppto_conversion_erp up_table
set importe_linea = 0.00
where exists(select 1
from fecxp_ppto_combina_erp_tmp comb
where comb.e_codigo = up_table.e_codigo
and  comb.libro_id = up_table.libro_id
and  comb.version_id = up_table.version_id
and  comb.moneda     = up_table.moneda
and  comb.code_combination = up_table.code_combination
--and comb.mes_acumulacion >= up_table.mes --modificado 07/12/2010 para tomar en cuenta todos los meses en las politicas de acumulados
)
and    up_table.version_fe = v_version_fe
and up_table.e_codigo = nvl (v_e_codigo, e_codigo);*/
for  contador in c_code_comb loop
update fecxp_ppto_conversion_erp up_table
set importe_linea = 0.00
where exists (select 1
from fecxp_ppto_combina_erp_tmp comb
where comb.e_codigo = up_table.e_codigo
and comb.libro_id = up_table.libro_id
and  comb.version_id = up_table.version_id
and  comb.moneda     = up_table.moneda
and  comb.code_combination = up_table.code_combination
and  comb.e_codigo =contador.e_codigo
)
and    up_table.version_fe = v_version_fe;
end loop;
/*update fecxp_ppto_conversion_erp up_table
set importe_linea = (select importe_linea
from fecxp_ppto_acumulado_erp_tmp acum
where acum.e_codigo = up_table.e_codigo
and acum.libro_id = up_table.libro_id
and acum.version_id = up_table.version_id
and acum.moneda = up_table.moneda
and acum.code_combination =  up_table.code_combination),
presupuesto_estatus = 'CONVERTIDO'
where exists(select 1
from fecxp_ppto_combina_erp_tmp comb
where comb.e_codigo = up_table.e_codigo
and  comb.libro_id = up_table.libro_id
and  comb.version_id = up_table.version_id
and  comb.moneda     = up_table.moneda
and  comb.code_combination = up_table.code_combination
and  comb.mes_acumulacion = up_table.mes)
and    up_table.version_fe = v_version_fe
and up_table.e_codigo = nvl (v_e_codigo, e_codigo);*/
for  contador1 in c_code_comb loop
update fecxp_ppto_conversion_erp up_table
set importe_linea = (select importe_linea
from fecxp_ppto_acumulado_erp_tmp acum
where acum.e_codigo = up_table.e_codigo
and acum.libro_id = up_table.libro_id
and acum.version_id = up_table.version_id
and acum.moneda = up_table.moneda
and acum.code_combination =  up_table.code_combination
and acum.e_codigo =contador1.e_codigo),
presupuesto_estatus = 'CONVERTIDO'
where exists (select 1
from fecxp_ppto_combina_erp_tmp comb
where comb.e_codigo = up_table.e_codigo
and  comb.libro_id = up_table.libro_id
and  comb.version_id = up_table.version_id
and  comb.moneda     = up_table.moneda
and  comb.code_combination = up_table.code_combination
and  comb.mes_acumulacion = up_table.mes
and  comb.e_codigo =contador1.e_codigo)
and    up_table.version_fe = v_version_fe;
end loop;
insert    into fecxp_ppto_conversion_erp_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select    version_fe,v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, version_id, 'V', 0
from    fecxp_ppto_conversion_erp
where    version_fe = v_version_fe
and e_codigo = coalesce(v_e_codigo, e_codigo)
group by version_fe, periodo_extraccion, version_id;
insert    into fecxp_ppto_bitacora_procesos(
sec_ext_bitacora, proceso_id, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, version_ppto_generado)
select    nextval('sec_ext_bitacora'), 2, clock_timestamp(), 'conversi
n exitosa', periodo_origen, version_origen, estatus_origen, 9
from (
select    periodo_origen, version_origen, estatus_origen
from    fecxp_ppto_opera_erp_enc
where    version_fe = v_version_fe
group by periodo_origen, version_origen, estatus_origen) alias3;
/* commit; */
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
