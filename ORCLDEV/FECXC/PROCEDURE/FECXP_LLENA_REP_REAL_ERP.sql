create or replace procedure fecxc."fecxp_llena_rep_real_erp"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo int:= 2005; -- parametros de entrada
v_mes int:= 1;*/
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_id_sesion numeric:= (to_char(clock_timestamp(),'YYYYMMDD'))::numeric;
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
cursor_clasificacion_fe cursor for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	 fecxp_politicas_erp
where  	 activa_regla = 1
order by prioridad asc;
begin 

delete from fecxp_rep_real_erp
where periodo = v_periodo
and mes = v_mes;
/* commit; */
--=== seleccionamos las distintas cuentas q generaron fe ===--
insert into fecxp_cuentas_erp_caratula(oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select distinct det.oracle_segmento1, det.oracle_segmento2, det.oracle_segmento3, det.oracle_segmento4,
det.oracle_segmento5, det.oracle_segmento6, det.oracle_segmento7
from fecxp_enc_pagos_erp enc,
fecxp_det_pagos_procesados det
where (to_char(fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and (to_char(fecha_aplicacion, 'MM'))::numeric  = v_mes
and enc.secuencia_pagos_erp = det.secuencia_pagos_erp;
---=== las clasificamos ===---
open  cursor_clasificacion_fe;
loop
fetch cursor_clasificacion_fe
into  v_cla_fe_id, v_prioridad, v_politica_erp_id, v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe */
update	fecxp_cuentas_erp_caratula
set	cla_fe_id = v_cla_fe_id
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
and 	coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe;
--- llenamos el reporte  - --
insert into fecxp_rep_real_erp(
cod_empresa, des_empresa, cla_id_fe, cla_fe_des, rubro, orden_id,
id_sesion, periodo, mes, fecha_aplicacion, moneda, tipo_cambio, importe_linea,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	pp.e_codigo, e.des_empresa, c.cla_fe_id, cfe.cla_fe_des, cfe.cla_atributo2, cfe.cla_atributo1,
v_id_sesion,v_periodo, v_mes, enc.fecha_aplicacion,	m.mon_oracle, m.tipo_cambio, pp.importe_linea*cfe.cla_atributo3,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4,
pp.oracle_segmento5, pp.oracle_segmento6, pp.oracle_segmento7
from	fecxc_empresas e,
fecxp_monedas m,
fecxp_clasificacion_fe cfe,
fecxp_cuentas_erp_caratula c,
fecxp_enc_pagos_erp enc,
fecxp_det_pagos_procesados pp
where	e.e_codigo = pp.e_codigo
and		enc.secuencia_pagos_erp = pp.secuencia_pagos_erp
and		m.mon_set = c.moneda
and 	m.mes = (to_char(enc.fecha_aplicacion,'MM'))::numeric
and		cfe.cla_fe_id = c.cla_fe_id
and		e.e_codigo = pp.e_codigo
and		c.oracle_segmento1 = pp.oracle_segmento1
and		c.oracle_segmento2 = pp.oracle_segmento2
and		c.oracle_segmento3 = pp.oracle_segmento3
and		c.oracle_segmento4 = pp.oracle_segmento4
and		c.oracle_segmento5 = pp.oracle_segmento5
and		c.oracle_segmento6 = pp.oracle_segmento6
and		c.oracle_segmento7 = pp.oracle_segmento7;
/* commit; */
end;
$body$
language plpgsql
;
