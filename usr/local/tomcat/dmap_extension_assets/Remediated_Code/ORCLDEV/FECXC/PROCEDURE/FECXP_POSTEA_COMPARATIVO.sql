-- PROCEDURE: fecxc.fecxp_postea_comparativo(character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS fecxc.fecxp_postea_comparativo(character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE fecxc.fecxp_postea_comparativo(
	IN v_agrupamiento_str_1 character varying DEFAULT 'CLA_ATRIBUTO4'::character varying,
	IN v_agrupamiento_str_2 character varying DEFAULT 'CLA_ATRIBUTO5'::character varying,
	IN v_agrupamiento_str_3 character varying DEFAULT 'CLA_ATRIBUTO6'::character varying)
LANGUAGE 'plpgsql'
AS $BODY$
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
v_sql_cursor :=  concat('SELECT C.CLA_ATRIBUTO4, C.CLA_ATRIBUTO5, C.CLA_ATRIBUTO6, C.CLA_ATRIBUTO2 FROM FECXP_CLASIFICACION_FE C, FECXP_POSTEO_COMPARACION_TMP T WHERE C.CLA_FE_ID = T.CLA_FE_ID AND T.SESION = ''' , v_sesion , ''' GROUP BY C.CLA_ATRIBUTO4, C.CLA_ATRIBUTO5, C.CLA_ATRIBUTO6, C.CLA_ATRIBUTO2 ORDER BY MIN(T.ORDEN)');/* dmap converted statement end */
end;
$BODY$;
ALTER PROCEDURE fecxc.fecxp_postea_comparativo(character varying, character varying, character varying)
    OWNER TO postgres;

