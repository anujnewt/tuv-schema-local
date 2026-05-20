create or replace procedure fecxc."fecxp_llena_rep_ppto_erp"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo int:= to_number(to_char(sysdate::text, 'YYYY'));
v_mes int:= to_number(to_char(sysdate::text, 'MM'));*/
v_id_sesion numeric:= (to_char(clock_timestamp(),'YYYYMMDD'))::numeric;
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
cursor_clasificacion_fe cursor for
select cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from fecxp_politicas_erp
where activa_regla = 1
order by prioridad asc;
begin 

delete from fecxp_rep_ppto_erp;
insert into fecxp_cuentas_erp_caratula(e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select distinct e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_ppto_conversion_erp
where periodo_extraccion = v_periodo
and	mes_extraccion = v_mes;
open  cursor_clasificacion_fe;
loop
--***** debug *****-- v_existe:= null;
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
insert into fecxp_rep_ppto_erp(
cod_empresa, des_empresa, rubro, orden_id, cla_id_fe, cla_fe_des, id_sesion,
periodo, mes, moneda, tipo_cambio, importe_linea,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7)
select	em.e_codigo, em.des_empresa, cf.cla_atributo2, (cf.cla_atributo1)::numeric , cf.cla_fe_id, cf.cla_fe_des, v_id_sesion,
pp.periodo, pp.mes, pp.moneda, m.tipo_cambio, pp.importe_linea,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5,
pp.oracle_segmento6, pp.oracle_segmento7
from	fecxc_empresas em,
fecxp_clasificacion_fe cf,
fecxp_cuentas_erp_caratula c,
fecxp_ppto_conversion_erp pp,
fecxp_monedas m
where	 pp.periodo_extraccion = v_periodo
and 	 pp.mes_extraccion = pp.mes
and		 em.e_codigo = c.e_codigo
and		 cf.cla_fe_id = c.cla_fe_id
and		 m.mes = pp.mes
and 	 c.oracle_segmento1 = pp.oracle_segmento1
and	 	 c.oracle_segmento2 = pp.oracle_segmento2
and		 c.oracle_segmento3 = pp.oracle_segmento3
and		 c.oracle_segmento4 = pp.oracle_segmento4
and		 c.oracle_segmento5 = pp.oracle_segmento5
and		 c.oracle_segmento6 = pp.oracle_segmento6
and		 c.oracle_segmento7 = pp.oracle_segmento7;end;
$body$
language plpgsql
;
