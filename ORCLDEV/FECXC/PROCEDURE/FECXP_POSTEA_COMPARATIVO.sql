create or replace procedure fecxc."fecxp_postea_comparativo"  ( v_agrupamiento_str_1 varchar2default 'CLA_ATRIBUTO4', v_agrupamiento_str_2 varchar2default 'CLA_ATRIBUTO5', v_agrupamiento_str_3 varchar2default 'CLA_ATRIBUTO6' ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_agrupamiento_1 varchar(255):= null;
v_agrupamiento_2 varchar(255):= null;
v_agrupamiento_3 varchar(255):= null;
v_orden_agrupamiento_1 integer:= (oracle.substr(v_agrupamiento_str_1, 13, 1))::numeric  - 3;
v_orden_agrupamiento_2 integer:= (oracle.substr(v_agrupamiento_str_2, 13, 1))::numeric  - 3;
v_orden_agrupamiento_3 integer:= (oracle.substr(v_agrupamiento_str_3, 13, 1))::numeric  - 3;
cursor_clasificacion_fe refcursor;
cla_fe_rec  fecxp_clasificacion_fe%rowtype;
v_sql_cursor varchar(2000);
v_sql_insert varchar(2000);
v_sesion varchar(100):= to_char(clock_timestamp(), 'YYYYMMDD HH:MM:SS');
v_saldo_final_real varchar(25):= 'SF';
v_saldo_final_ppto varchar(25):= 'SF';
v_factor numeric:= 1000;
v_factor_titulo varchar(100);
v_rubro fecxp_clasificacion_fe.cla_atributo2%type;
v_periodo integer:= 2006;
v_mes integer:= 6;
v_e_codigo integer:= 284;
begin 

delete	from fecxp_posteo_comparacion_tmp;
delete	from fecxp_posteo
where	xml_doc = 'CE_FE_002.xml';
-----------------------------------------------------------------------------------------
-- mete saldos iniciales reales pptos
insert	into fecxp_posteo_comparacion_tmp(orden, cla_atributo2, cla_fe_id, cla_fe_des, monto_real, monto_ppto, monto_var, sesion)
select	(cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, c.cla_fe_des, round(sum(c.importe_linea * m.tipo_cambio / v_factor))::numeric, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), 0, v_sesion
from	fecxp_monedas m,
fecxp_clasificacion_fe cf,
fecxp_ppto_caratula c,
fecxc_emp_x_segmento a
where	c.cla_fe_id = 'SI'
and		c.e_codigo = a.e_codigo
and		c.periodo = coalesce(v_periodo, (to_char(clock_timestamp(), 'YYYY'))::numeric ) and c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.mes = 1
and		c.cla_fe_id = cf.cla_fe_id
and		a.id_segmento = 23
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by (cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, c.cla_fe_des;
-----------------------------------------------------------------------------------------
-- mete saldos finales reales pptos
insert	into fecxp_posteo_comparacion_tmp(orden, cla_atributo2, cla_fe_id, cla_fe_des, monto_real, monto_ppto, monto_var, sesion)
select	(cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), 0, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), v_sesion
from	fecxp_monedas m,
fecxp_clasificacion_fe cf,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		c.cla_fe_id = v_saldo_final_real
and		c.periodo = coalesce(v_periodo, (to_char(clock_timestamp(), 'YYYY'))::numeric ) and c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.mes = coalesce(v_mes, (to_char(clock_timestamp(), 'MM'))::numeric  - 1)
and		c.cla_fe_id = cf.cla_fe_id
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by (cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des;
insert	into fecxp_posteo_comparacion_tmp(orden, cla_atributo2, cla_fe_id, cla_fe_des, monto_real, monto_ppto, monto_var, sesion)
select	(cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des, 0, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), -1 * round(sum(c.importe_linea * m.tipo_cambio / v_factor)), v_sesion
from	fecxp_monedas m,
fecxp_clasificacion_fe cf,
fecxp_ppto_caratula c,
fecxc_emp_x_segmento a
where	a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		c.cla_fe_id = v_saldo_final_real
and		c.periodo = coalesce(v_periodo, (to_char(clock_timestamp(), 'YYYY'))::numeric ) and c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.mes = coalesce(v_mes, (to_char(clock_timestamp(), 'MM'))::numeric  - 1)
and		c.cla_fe_id = cf.cla_fe_id
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by (cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des;
-----------------------------------------------------------------------------------------
-- mete movimientos caratula reales pptos
insert	into fecxp_posteo_comparacion_tmp(orden, cla_atributo2, cla_fe_id, cla_fe_des, monto_real, monto_ppto, monto_var, sesion)
select	(cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), 0, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), v_sesion
from	fecxp_monedas m,
fecxp_clasificacion_fe cf,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		c.cla_fe_id not in ('SI', 'SF')
and		c.cla_fe_id <> v_saldo_final_real
and		c.periodo = coalesce(v_periodo, (to_char(clock_timestamp(), 'YYYY'))::numeric ) and c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.mes <= coalesce(v_mes, (to_char(clock_timestamp(), 'MM'))::numeric  - 1)
and		c.cla_fe_id = cf.cla_fe_id
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by (cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des;
insert	into fecxp_posteo_comparacion_tmp(orden, cla_atributo2, cla_fe_id, cla_fe_des, monto_real, monto_ppto, monto_var, sesion)
select	(cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des, 0, round(sum(c.importe_linea * m.tipo_cambio / v_factor)), -1 * round(sum(c.importe_linea * m.tipo_cambio / v_factor)), v_sesion
from	fecxp_monedas m,
fecxp_clasificacion_fe cf,
fecxp_ppto_caratula c,
fecxc_emp_x_segmento a
where	a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		c.cla_fe_id not in ('SI', 'SF')
and		c.periodo = coalesce(v_periodo, (to_char(clock_timestamp(), 'YYYY'))::numeric ) and c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.mes <= coalesce(v_mes, (to_char(clock_timestamp(), 'MM'))::numeric  - 1)
and		c.cla_fe_id = cf.cla_fe_id
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by (cf.cla_atributo3)::numeric , cf.cla_atributo2, c.cla_fe_id, cf.cla_fe_des;/* dmap converted statement start */
v_factor_titulo:= case v_factor
when 1 then 'Montos en Pesos'
when 100 then 'Cientos de Pesos'
when 1000 then 'Miles de Pesos'
when 1000000 then 'Millones de Pesos'
else  concat('Montos x ', v_factor)  end;/* dmap converted statement end */
-----------------------------------------------------------------------------------------
-- genera xml
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml', '<?xml version="1.0" encoding="UTF-8"?>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml', '<!DOCTYPE xliff PUBLIC "-//XLIFF//DTD XLIFF//EN" "http://www.oasis-open.org/committees/xliff/documents/xliff.dtd" >', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml', '<xliff version="1.0" xml:lang="es">', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml',  concat('		  <Encabezado Titulo = "Comparativo Reales vs Ppto Flujo de Efectivo Mensual" Subtitulo = "', v_factor_titulo , ' nominales. ' , initcap(to_char(add_months(clock_timestamp(), -1), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH')) , ' (' , to_char(add_months(clock_timestamp(), -1), 'YYYY') , ')" Fecha "' , to_char(clock_timestamp(), 'YYYYMMDD') , '">') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
v_sql_cursor :=  concat('SELECT C.CLA_ATRIBUTO4, C.CLA_ATRIBUTO5, C.CLA_ATRIBUTO6, C.CLA_ATRIBUTO2 FROM FECXP_CLASIFICACION_FE C, FECXP_POSTEO_COMPARACION_TMP T WHERE C.CLA_FE_ID = T.CLA_FE_ID AND GROUP BY C.CLA_ATRIBUTO4, C.CLA_ATRIBUTO5, C.CLA_ATRIBUTO6, C.CLA_ATRIBUTO2  ORDER BY  C. ', v_agrupamiento_str_1 , ' , C. ' , v_agrupamiento_str_2 , ' , C. ' , v_agrupamiento_str_3) ; /* dmap converted statement end *//* dmap converted statement */
-- dbms_output.put_line (v_sql_cursor);
-- insert into fecxp_debuguea_string (sec_string, sql_string) values (sec_string.nextval, v_sql_cursor);
open cursor_clasificacion_fe for execute v_sql_cursor; -- using my_job;
loop
fetch cursor_clasificacion_fe
into cla_fe_rec.cla_atributo4, cla_fe_rec.cla_atributo5, cla_fe_rec.cla_atributo6, cla_fe_rec.cla_atributo2;
exit when not found; /* apply on cursor_clasificacion_fe */
v_agrupamiento_1:= cla_fe_rec.cla_atributo4;
v_agrupamiento_2:= cla_fe_rec.cla_atributo5;
v_agrupamiento_3:= cla_fe_rec.cla_atributo6;
v_rubro:= cla_fe_rec.cla_atributo2;/* dmap converted statement start */
------------------------------------------------------------------------------------------------------------
-- titulo del rubro
v_sql_insert:=  concat('INSERT INTO FECXP_POSTEO (ORDEN, XML_DOC, XML_STRING, SESION) VALUES (SEC_FECXP_POSTEO.NEXTVAL, ''CE_FE_002.xml'', ''		<Concepto Tipo = ''''t'''' desc = '''''' || :', v_orden_agrupamiento_1 , ' || '' > '' || :' , v_orden_agrupamiento_2 , ' || '' > '' || :' , v_orden_agrupamiento_3 , ' || '' > '' || :4 || ''''''<concepto/>'', ''' , v_sesion , ''')') ;/* dmap converted statement end */
execute(v_sql_insert)
using v_agrupamiento_1, v_agrupamiento_2, v_agrupamiento_3, v_rubro;
-- insert into fecxp_debuguea_string (sec_string, sql_string) values (sec_string.nextval, v_sql_insert);
------------------------------------------------------------------------------------------------------------
-- detalle del rubro
v_sql_insert:=	 		   			'INSERT INTO FECXP_POSTEO (ORDEN, XML_DOC, XML_STRING, SESION) ';/* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, 'SELECT	SEC_FECXP_POSTEO.NEXTVAL, ''CE_FE_002.xml'', t.xml_string, ''' , v_sesion , ''' ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, 'FROM	(') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		select '' <concepto tipo = ''''l'''' desc = '''''' || t.cla_fe_des || '' nullif(real::text, '') is null || to_char (sum (t.monto_real)) || '' nullif(ppto::text, '') is null || to_char (sum (t.monto_ppto)) || '' nullif(var::text, '') is null || to_char (sum (t.monto_var)) || ''''''></concepto>'' xml_string ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		FROM	FECXP_POSTEO_COMPARACION_TMP T, FECXP_CLASIFICACION_FE C ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		WHERE	T.CLA_FE_ID = C.CLA_FE_ID ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		and		t.sesion = ''' , v_sesion , ''' ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		T.CLA_ATRIBUTO2 = :1 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO4 = :2 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO5 = :3 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO6 = :4 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		GROUP BY TO_NUMBER (T.ORDEN), T.CLA_FE_DES ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		 ORDER BY  TO_NUMBER (T.ORDEN), T.CLA_FE_DES') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, ') T') ;/* dmap converted statement end */
execute(v_sql_insert)
using v_rubro, v_agrupamiento_1, v_agrupamiento_2, v_agrupamiento_3; --, v_sesion;
-- insert into fecxp_debuguea_string (sec_string, sql_string) values (sec_string.nextval, v_agrupamiento_1 || ', ' || v_agrupamiento_2 || ', ' || v_agrupamiento_3 || ', ' || v_rubro  || ' -- ' || v_sql_insert);
------------------------------------------------------------------------------------------------------------
-- corte del rubro
v_sql_insert:=	 		   			'INSERT INTO FECXP_POSTEO (ORDEN, XML_DOC, XML_STRING, SESION) ';/* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, 'SELECT	SEC_FECXP_POSTEO.NEXTVAL, ''CE_FE_002.xml'', t.xml_string, ''' , v_sesion , ''' ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, 'FROM	(') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		select '' <concepto tipo = ''''c'''' desc = ''''total '' || t.cla_atributo2 || '' nullif(real::text, '') is null || to_char (sum (t.monto_real)) || '' nullif(ppto::text, '') is null || to_char (sum (t.monto_ppto)) || '' nullif(var::text, '') is null || to_char (sum (t.monto_var)) || ''''''></concepto>'' xml_string ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		FROM	FECXP_POSTEO_COMPARACION_TMP T, FECXP_CLASIFICACION_FE C ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		WHERE	T.CLA_FE_ID = C.CLA_FE_ID ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		and		t.sesion = ''' , v_sesion , ''' ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		T.CLA_ATRIBUTO2 = :1 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO4 = :2 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO5 = :3 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		AND		C.CLA_ATRIBUTO6 = :4 ') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, '		GROUP BY T.CLA_ATRIBUTO2') ;/* dmap converted statement end *//* dmap converted statement start */
v_sql_insert:=  concat(v_sql_insert, ') T') ;/* dmap converted statement end */
execute(v_sql_insert)
using v_rubro, v_agrupamiento_1, v_agrupamiento_2, v_agrupamiento_3; --, v_sesion;
-- insert into fecxp_debuguea_string (sec_string, sql_string) values (sec_string.nextval, v_agrupamiento_1 || ', ' || v_agrupamiento_2 || ', ' || v_agrupamiento_3 || ', ' || v_rubro  || ' -- ' || v_sql_insert);
end loop;
close	cursor_clasificacion_fe;
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml', '		</Encabezado>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_002.xml', '</xliff>', v_sesion);
/* commit; */
end;
$body$
language plpgsql
;
