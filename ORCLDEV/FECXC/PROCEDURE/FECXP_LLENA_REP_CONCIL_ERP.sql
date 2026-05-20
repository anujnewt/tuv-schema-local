create or replace procedure fecxc."fecxp_llena_rep_concil_erp"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo      int:= 2005;
v_mes 	       int:= 01;   */
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
v_cla_fe_des fecxp_clasificacion_fe.cla_fe_des%type;
cursor_clasificacion_fe cursor for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	 fecxp_politicas_erp
where  	 activa_regla = 1
order by prioridad asc;
begin 

--truncate table fecxp_rep_conciliacion_erp;
--delete from fecxp_rep_conciliacion_erp
--where fecha_aplicacion > = to_date('01-'||v_mes||'-'||v_periodo,'DD-MM-YYYY');
/* commit; */
insert into fecxp_rep_conciliacion_erp_tmp(oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, atributo1)
select distinct re.oracle_segmento1, re.oracle_segmento2, re.oracle_segmento3, re.oracle_segmento4,
re.oracle_segmento5, re.oracle_segmento6, re.oracle_segmento7, re.moneda
from fecxp_rep_real_erp re
where (to_char(fecha_aplicacion,'MM'))::numeric  = v_mes
and (to_char(fecha_aplicacion,'YYYY'))::numeric  = v_periodo
order by  re.oracle_segmento1;
---  se actualiza el id de flujo de efectivo   ---
open  cursor_clasificacion_fe;
loop
fetch cursor_clasificacion_fe
into  v_cla_fe_id, v_prioridad, v_politica_erp_id, v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe */
update	fecxp_rep_conciliacion_erp_tmp
set	cla_id_fe = v_cla_fe_id
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
and 	coalesce(cla_id_fe, '|') = '|';
end loop;
close cursor_clasificacion_fe;
---------------------			---------------------			--------------------
---							descripcion de clasificacion fe						----
---------------------			---------------------			---------------------
update fecxp_rep_conciliacion_erp_tmp t
set cla_fe_des = (select cf.cla_fe_des from fecxp_clasificacion_fe cf
where t.cla_id_fe = cf.cla_fe_id);
---------------------			---------------------			--------------------
---							descripcion de segmentos oracle						----
---------------------			---------------------			---------------------
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento1_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007915'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento1 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento2_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007916'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento2 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento3_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007917'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento3 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento4_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007918'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento4 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento5_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007919'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento5 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento6_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007921'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento6 = a.flex_value_meaning);
update fecxp_rep_conciliacion_erp_tmp t
set oracle_segmento7_des = (select a.description
from fnd_flex_values_tl__erp_prod a, fnd_flex_values__erp_prod b
where b.flex_value_set_id = '1007920'
and a.flex_value_id = b.flex_value_id
and a.language = 'ESA'
and enabled_flag = 'Y'
and b.summary_flag = 'N'
and t.oracle_segmento7 = a.flex_value_meaning);
---------------------			---------------------			--------------------
---							   insercion de movimientos de real						    ----
---------------------			---------------------			---------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select rr.cla_id_fe, rr.cla_fe_des, '1REAL' as concepto, rr.moneda, rr.importe_linea, rr.fecha_aplicacion, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_rep_real_erp rr
where (to_char(rr.fecha_aplicacion,'MM'))::numeric  = v_mes
and (to_char(rr.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;
---------------------			---------------------			--------------------
---					insercion de movimientos complementarios	(debito y credito)		 ----
---------------------			---------------------			---------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select rr.cla_id_fe, rr.cla_fe_des, '6MC_DEB' as concepto, rr.moneda, rr.importe_debito, rr.fecha_aplicacion, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_rep_mvcomp_erp  rr
where (to_char(rr.fecha_aplicacion,'MM'))::numeric  = v_mes
and (to_char(rr.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select rr.cla_id_fe, rr.cla_fe_des, '7MC_CRE' as concepto, rr.moneda, rr.importe_credito, rr.fecha_aplicacion, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_rep_mvcomp_erp  rr
where  (to_char(rr.fecha_aplicacion,'MM'))::numeric  = v_mes
and (to_char(rr.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;/* dmap converted statement start */
------------------------------ 					  ------------------------------
------------------------------    presupuesto fe	  ------------------------------
---------------------------------------------------------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select rr.cla_id_fe, rr.cla_fe_des, '2PPTO_FE' as concepto, rr.moneda, rr.importe_linea, to_date( concat(to_char(rr.mes), '-', rr.periodo) ,'MM-YYYY') as fecha, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_rep_ppto_erp  rr
where rr.mes  = v_mes
and rr.periodo = v_periodo
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
-------------------------------------- 			--------------------------
------------------------------		 presupuesto operativo  -------------------------
--------------------------------------	   		--------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_01,
case when moneda = 'MXP' then po.pss_01
when moneda = 'USD' then po.usd_01
when moneda = 'EUR' then po.eur_01 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 01) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_02,
case when moneda = 'MXP' then po.pss_02
when moneda = 'USD' then po.usd_02
when moneda = 'EUR' then po.eur_02 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 02) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_03,
case when moneda = 'MXP' then po.pss_03
when moneda = 'USD' then po.usd_03
when moneda = 'EUR' then po.eur_03 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 03) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_04,
case when moneda = 'MXP' then po.pss_04
when moneda = 'USD' then po.usd_04
when moneda = 'EUR' then po.eur_04 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 04) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_05,
case when moneda = 'MXP' then po.pss_05
when moneda = 'USD' then po.usd_05
when moneda = 'EUR' then po.eur_05 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 05) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_06,
case when moneda = 'MXP' then po.pss_06
when moneda = 'USD' then po.usd_06
when moneda = 'EUR' then po.eur_06 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 06) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_07,
case when moneda = 'MXP' then po.pss_07
when moneda = 'USD' then po.usd_07
when moneda = 'EUR' then po.eur_07 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 07) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_08,
case when moneda = 'MXP' then po.pss_08
when moneda = 'USD' then po.usd_08
when moneda = 'EUR' then po.eur_08 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 08) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_09,
case when moneda = 'MXP' then po.pss_09
when moneda = 'USD' then po.usd_09
when moneda = 'EUR' then po.eur_09 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 09) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_10,
case when moneda = 'MXP' then po.pss_10
when moneda = 'USD' then po.usd_10
when moneda = 'EUR' then po.eur_10 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 10) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_01,
case when moneda = 'MXP' then po.pss_11
when moneda = 'USD' then po.usd_11
when moneda = 'EUR' then po.eur_11 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 11) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, tipo_cambio, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des,
oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des,
oracle_segmento7_des)
select	t.cla_id_fe, t.cla_fe_des, '3PPTO_OP' as concepto, po.moneda, po.ppto_01,
case when moneda = 'MXP' then po.pss_12
when moneda = 'USD' then po.usd_12
when moneda = 'EUR' then po.eur_12 end as tipo_cambio,
to_date( concat(po.periodo_ppto, '-', 12) ,'YYYY-MM') as fecha,
po.oracle_segmento1, po.oracle_segmento2, po.oracle_segmento3,
po.oracle_segmento4, po.oracle_segmento5, po.oracle_segmento6, po.oracle_segmento7, t.oracle_segmento1_des, t.oracle_segmento2_des,
t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des, t.oracle_segmento6_des,	t.oracle_segmento7_des
from	fecxp_ppto_opera_erp po,
fecxp_rep_conciliacion_erp_tmp t
where   t.oracle_segmento1 = po.oracle_segmento1
and   t.oracle_segmento2 = po.oracle_segmento2
and   t.oracle_segmento3 = po.oracle_segmento3
and   t.oracle_segmento4 = po.oracle_segmento4
and   t.oracle_segmento5 = po.oracle_segmento5
and   t.oracle_segmento6 = po.oracle_segmento6
and   t.oracle_segmento7 = po.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
------------------------------							------------------------------
------------------------------			saldos			------------------------------
--------------------------------------------------------------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select t.cla_id_fe, t.cla_fe_des, '4SAL_DEB' as concepto, rr.moneda, rr.debito_inicial_mo, to_date( concat(to_char(rr.mes), '-', rr.periodo) ,'MM-YYYY') as fecha, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_saldos_operativo_erp  rr
where rr.periodo =v_periodo
and rr.mes  = v_mes
and rr.periodo_extraccion =v_periodo
and rr.mes_de_extraccion  = v_mes
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, oracle_segmento1_des, oracle_segmento2_des, oracle_segmento3_des,
oracle_segmento4_des, oracle_segmento5_des, oracle_segmento6_des, oracle_segmento7_des)
select t.cla_id_fe, t.cla_fe_des, '5SAL_CRE' as concepto, rr.moneda, rr.credito_inicial_mo, to_date( concat(to_char(rr.mes), '-', rr.periodo) ,'MM-YYYY') as fecha, rr.oracle_segmento1,
rr.oracle_segmento2, rr.oracle_segmento3, rr.oracle_segmento4, rr.oracle_segmento5, rr.oracle_segmento6, rr.oracle_segmento7,
t.oracle_segmento1_des, t.oracle_segmento2_des, t.oracle_segmento3_des, t.oracle_segmento4_des, t.oracle_segmento5_des,
t.oracle_segmento6_des, t.oracle_segmento7_des
from fecxp_rep_conciliacion_erp_tmp t,
fecxp_saldos_operativo_erp  rr
where rr.periodo =v_periodo
and rr.mes  = v_mes
and rr.periodo_extraccion =v_periodo
and rr.mes_de_extraccion  = v_mes
and t.oracle_segmento1 = rr.oracle_segmento1
and t.oracle_segmento2 = rr.oracle_segmento2
and t.oracle_segmento3 = rr.oracle_segmento3
and t.oracle_segmento4 = rr.oracle_segmento4
and t.oracle_segmento5 = rr.oracle_segmento5
and t.oracle_segmento6 = rr.oracle_segmento6
and t.oracle_segmento7 = rr.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
-------------------------------------------------------------------------
-------------------------------- llenamos a 0's las cuentas de saldos q aparecen en real pero no en saldos ---------------------------------------------------------
-------------------------------------------------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '4SAL_DEB' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '4SAL_DEB') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '5SAL_CRE' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '5SAL_CRE') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
-------------------------------------------------------------------------
-------------------- llenamos a 0's las cuentas de mov complementarios q aparecen en real pero no en mov comp ---------------------------------------------------------
-------------------------------------------------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '6MC_DEB' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '6MC_DEB') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '7MC_CRE' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '7MC_CRE') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
-------------------------------------------------------------------------
---------------------------------- llenamos a 0's las cuentas de pptps q aparecen en real pero no en ppto ---------------------------------------------------------
---------------------------------------------------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '2PPTO_FE' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '2PPTO_FE') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select b.cla_id_fe, b.cla_fe_des, '3PPTO_OP' concepto, b.atributo1, 0 as monto,to_date( concat(to_char(v_mes), '-', v_periodo) ,'MM-YYYY') as fecha,
b.oracle_segmento1, b.oracle_segmento2, b.oracle_segmento3, b.oracle_segmento4,
b.oracle_segmento5, b.oracle_segmento6, b.oracle_segmento7, b.oracle_segmento1_des, b.oracle_segmento2_des,
b.oracle_segmento3_des, b.oracle_segmento4_des, b.oracle_segmento5_des, b.oracle_segmento6_des, b.oracle_segmento7_des
from (select oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp_tmp
except
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_rep_conciliacion_erp
where concepto = '3PPTO_OP') a, fecxp_rep_conciliacion_erp_tmp b
where a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7;/* dmap converted statement end */
------------------------------       ------------------------------       ------------------------------
------------------------------                tipo de cambio			  ------------------------------
------------------------------       ------------------------------       ------------------------------
update fecxp_rep_conciliacion_erp rs
set    tipo_cambio = (select m.tipo_cambio from fecxp_monedas m
where m.mon_oracle = rs.moneda
and (to_char(rs.fecha_aplicacion,'MM'))::numeric  = m.mes);
------------------------------       ------------------------------       ------------------------------
------------------------------           todo a pss						  ------------------------------
------------------------------       ------------------------------       ------------------------------
insert into fecxp_rep_conciliacion_erp(cla_id_fe, cla_fe_des, concepto, moneda, importe_linea, fecha_aplicacion,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7, oracle_segmento1_des,
oracle_segmento2_des, oracle_segmento3_des, oracle_segmento4_des, oracle_segmento5_des,
oracle_segmento6_des, oracle_segmento7_des)
select 	a.cla_id_fe, a.cla_fe_des, a.concepto, 'PSS' as moneda, a.importe_linea*b.tipo_cambio as importe, a.fecha_aplicacion, a.oracle_segmento1,
a.oracle_segmento2, a.oracle_segmento3, a.oracle_segmento4, a.oracle_segmento5, a.oracle_segmento6,
a.oracle_segmento7, a.oracle_segmento1_des, a.oracle_segmento2_des, a.oracle_segmento3_des, a.oracle_segmento4_des,
a.oracle_segmento5_des, a.oracle_segmento6_des, a.oracle_segmento7_des
from fecxp_rep_conciliacion_erp a,
fecxp_monedas b
where (to_char(a.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and (to_char(a.fecha_aplicacion,'MM'))::numeric  = v_mes
and b.mon_oracle = a.moneda
and b.mes = (to_char(a.fecha_aplicacion,'MM'))::numeric;end;
$body$
language plpgsql
;
