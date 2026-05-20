create or replace procedure fecxc."fecxp_llena_rep_mcomp_erp"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo      int:= 2005;
v_mes 	       int:= 01;   */
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

delete from fecxp_rep_mvcomp_erp
where (to_char(fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and (to_char(fecha_aplicacion, 'MM'))::numeric  = v_mes;
insert into fecxp_cuentas_erp_caratula(oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select distinct oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from fecxp_mov_comple_opera_erp
where	(to_char(fecha_efectiva, 'YYYY'))::numeric  = v_periodo
and	(to_char(fecha_efectiva, 'MM'))::numeric  = v_mes;
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
insert into fecxp_rep_mvcomp_erp(
cod_empresa, des_empresa, cla_id_fe, cla_fe_des, rubro,
orden_id, fecha_aplicacion, tipo_cambio, moneda, importe_debito, importe_credito,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	e.e_codigo, e.des_empresa, c.cla_fe_id, cfe.cla_fe_des, cfe.cla_atributo2, cfe.cla_atributo1,
mc.fecha_efectiva, m.tipo_cambio, mc.moneda, mc.monto_deb_mon_orig, mc.monto_cre_mon_orig,
mc.oracle_segmento1, mc.oracle_segmento2, mc.oracle_segmento3, mc.oracle_segmento4,
mc.oracle_segmento5, mc.oracle_segmento6, mc.oracle_segmento7
from	fecxc_empresas e,
fecxp_clasificacion_fe cfe,
fecxp_monedas m,
fecxp_cuentas_erp_caratula c,
fecxp_mov_comple_opera_erp mc
where	e.e_codigo = (mc.oracle_segmento1)::numeric
and		cfe.cla_fe_id = c.cla_fe_id
and		m.mon_oracle = mc.moneda
and		m.mes = (to_char(mc.fecha_efectiva,'MM'))::numeric
and		c.oracle_segmento1 = mc.oracle_segmento1
and		c.oracle_segmento2 = mc.oracle_segmento2
and		c.oracle_segmento3 = mc.oracle_segmento3
and		c.oracle_segmento4 = mc.oracle_segmento4
and		c.oracle_segmento5 = mc.oracle_segmento5
and		c.oracle_segmento6 = mc.oracle_segmento6
and		c.oracle_segmento7 = mc.oracle_segmento7;
/* commit; */
end;
$body$
language plpgsql
;
