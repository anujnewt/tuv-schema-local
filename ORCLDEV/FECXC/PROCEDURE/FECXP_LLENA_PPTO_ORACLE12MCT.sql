create or replace procedure fecxc."fecxp_llena_ppto_oracle12mct"  () as $body$
declare
flg0 text;
-- pgv moved types end
begin 

-------------------------------------------------------------------------
-- consulta comparativa del ppto de soin operativo vs flujo
-------------------------------------------------------------------------
-- consulta comparativa del ppto de oracle operativo vs flujo
declare
-- pgv moved types start
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
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
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
cursor_clasificacion_fe_oracle cursor  for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin, tipo_operacion_ini, tipo_operacion_fin
from	 fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
order by  prioridad asc;
begin
insert	into fecxp_rep_ppto_com_cta_erp(cla_fe_id, e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|', e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_ppto_opera_erp
where	periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_de_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
open  cursor_clasificacion_fe_oracle;
loop
fetch cursor_clasificacion_fe_oracle
into  v_cla_fe_id, v_prioridad, v_politica_erp_id, v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin, v_tipo_operacion_ini, v_tipo_operacion_fin;
flg0 := found;
exit when (not flg0);/* apply on cursor_clasificacion_fe_oracle */
-- clasificacion de cuentas contables erp.
update	fecxp_rep_ppto_com_cta_erp
set		cla_fe_id = v_cla_fe_id
where (oracle_segmento1 >= coalesce(v_ora_s1_ini, '0'))
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
and		coalesce(v_tipo_operacion_ini, 0) = 0
and		coalesce(v_tipo_operacion_fin, 0) = 0
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe_oracle;
delete	from fecxp_rep_ppto_comp_o_erp;
delete	from fecxp_rep_ppto_comp_c_erp;
insert	into fecxp_rep_ppto_comp_o_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
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
select	e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
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
ppto_12, pss_12, usd_12, eur_12
from	fecxp_ppto_opera_erp
where	periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_de_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_01, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 1
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_02, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 2
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_03, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 3
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_04, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 4
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_05, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 5
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_06, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 6
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_07, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 7
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_08, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 8
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_09, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 9
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_10, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 10
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_11, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 11
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
insert	into fecxp_rep_ppto_comp_c_erp(
e_codigo, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id, moneda, code_combination_id, ppto_12, presupuesto_estatus)
select	e_codigo, periodo_extraccion, mes_extraccion, periodo, libro_id, version_id, moneda, code_combination, importe_linea, presupuesto_estatus
from	fecxp_ppto_conversion_erp
where	mes = 12
and		periodo_extraccion = (to_char(clock_timestamp(), 'YYYY'))::numeric
and		mes_extraccion = (to_char(clock_timestamp(), 'MM'))::numeric;
end;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';
end;
$body$
language plpgsql
;
