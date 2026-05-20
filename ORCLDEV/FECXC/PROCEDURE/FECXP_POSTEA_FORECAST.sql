create or replace procedure fecxc."fecxp_postea_forecast"  ( v_com_mes1 varchar, v_com_mes2 varchar, v_com_mes3 varchar, v_com_mes4 varchar, v_com_mes5 varchar, v_com_mes6 varchar, v_com_mes7 varchar, v_com_mes8 varchar, v_com_mes9 varchar, v_com_mes10 varchar, v_com_mes11 varchar, v_com_mes12 varchar, v_com_fijo1 varchar, v_com_fijo2 varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_saldo_final_real varchar(3):= 'SF2';
v_saldo_final_forecast varchar(3):= 'SF';
v_sesion varchar(25):= null;
v_factor numeric:= 1000;
v_factor_titulo varchar(100);
begin 

/* dmap converted statement start */
v_factor_titulo:= case v_factor
when 1 then 'Montos en Pesos'
when 100 then 'Cientos de Pesos'
when 1000 then 'Miles de Pesos'
when 1000000 then 'Millones de Pesos'
else  concat('Montos x ', v_factor)  end;/* dmap converted statement end */
delete	from fecxp_posteo
where	xml_doc = 'CE_FE_001.xml';
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '<?xml version="1.0" encoding="UTF-8"?>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '<!DOCTYPE xliff PUBLIC "-//XLIFF//DTD XLIFF//EN" "http://www.oasis-open.org/committees/xliff/documents/xliff.dtd" >', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '<xliff version="1.0" xml:lang="es">', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat(' <Encabezado Titulo = "Forecast Flujo de Efectivo" Subtitulo = "', v_factor_titulo , ' nominales. ' , initcap(to_char(add_months(clock_timestamp(), -1), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH')) , ' (' , to_char(add_months(clock_timestamp(), -1), 'YYYY') , ')" Fecha = "' , to_char(clock_timestamp(), 'YYYYMMDD hh24mmss') , '">') , v_sesion);/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<mxp>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) select	nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', xml_string, v_sesion
from (
select	 concat('		<mes', to_char(c.mes) , '>' , ltrim(to_char(sum(c.importe_linea * m.tipo_cambio / v_factor)::text, '9999999999999999999999999.9')) , '</mes' , to_char(c.mes) , '>')  xml_string
from	fecxp_monedas m,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	c.cla_fe_id = case when c.mes < (to_char(clock_timestamp(), 'MM'))::numeric  then v_saldo_final_real else v_saldo_final_forecast end
and		c.moneda = 'MXP'
and		c.periodo = (to_char(clock_timestamp(),'YYYY'))::numeric
and		a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by c.mes
) alias13;/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</mxp>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<otm>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) select	nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', xml_string, v_sesion
from (
select	 concat('		<mes', to_char(c.mes) , '>' , ltrim(to_char(sum(c.importe_linea * m.tipo_cambio / v_factor)::text, '9999999999999999999999999.9')) , '</mes' , to_char(c.mes) , '>')  xml_string
from	fecxp_monedas m,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	c.cla_fe_id = case when c.mes < (to_char(clock_timestamp(), 'MM'))::numeric  then v_saldo_final_real else v_saldo_final_forecast end
and		c.moneda <> 'MXP'
and		c.periodo = (to_char(clock_timestamp(),'YYYY'))::numeric
and		a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by c.mes
) alias13;/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</otm>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<tot>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) select	nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', xml_string, v_sesion
from (
select	 concat('		<mes', to_char(c.mes) , '>' , ltrim(to_char(sum(c.importe_linea * m.tipo_cambio / v_factor)::text, '9999999999999999999999999.9')) , '</mes' , to_char(c.mes) , '>')  xml_string
from	fecxp_monedas m,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	c.cla_fe_id = case when c.mes < (to_char(clock_timestamp(), 'MM'))::numeric  then v_saldo_final_real else v_saldo_final_forecast end
and		c.periodo = (to_char(clock_timestamp(),'YYYY'))::numeric
and		a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by c.mes
) alias13;/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</tot>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<com>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes1>', v_com_mes1 , '</mes1>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes2>', v_com_mes2 , '</mes2>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes3>', v_com_mes3 , '</mes3>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes4>', v_com_mes4 , '</mes4>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes5>', v_com_mes5 , '</mes5>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes6>', v_com_mes6 , '</mes6>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes7>', v_com_mes7 , '</mes7>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes8>', v_com_mes8 , '</mes8>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes9>', v_com_mes9 , '</mes9>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes10>', v_com_mes10 , '</mes10>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes11>', v_com_mes11 , '</mes11>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<mes12>', v_com_mes12 , '</mes12>') , v_sesion);/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</com>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<mes>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) select	nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', xml_string, v_sesion
from (
select	 concat('		<mes', to_char(c.mes) , '>' , to_char(to_timestamp(c.mes,'MM'), 'MON', 'NLS_DATE_LANGUAGE=SPANISH') , '</mes' , to_char(c.mes) , '>')  xml_string
from	fecxp_monedas m,
fecxp_real_caratula c,
fecxc_emp_x_segmento a
where	c.periodo = (to_char(clock_timestamp(),'YYYY'))::numeric
and		a.id_segmento = 23
and		c.e_codigo = a.e_codigo
and		m.mon_oracle = c.moneda
and		m.periodo = c.periodo
and		m.mes = c.mes
group by c.mes
) alias9;/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</mes>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	<com>', v_sesion);/* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<com1>', v_com_fijo1 , '</com1>') , v_sesion);/* dmap converted statement end *//* dmap converted statement start */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml',  concat('		<com2>', v_com_fijo2 , '</com2>') , v_sesion);/* dmap converted statement end */
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '	</com>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', ' </Encabezado>', v_sesion);
insert	into fecxp_posteo(orden, xml_doc, xml_string, sesion) values (nextval('sec_fecxp_posteo'), 'CE_FE_001.xml', '</xliff>', v_sesion);
/* commit; */
end;
$body$
language plpgsql
;
