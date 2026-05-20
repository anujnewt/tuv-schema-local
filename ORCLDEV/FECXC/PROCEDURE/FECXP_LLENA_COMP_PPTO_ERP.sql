create or replace procedure fecxc."fecxp_llena_comp_ppto_erp"  ( v_parametros varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_sesion timestamp(0):= clock_timestamp();
v_conta integer:= 0;
v_linea_id integer:= 0;
v_separador1 integer:= 0;
v_separador2 integer:= 0;
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
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
cursor_clasificacion_fe_oracle cursor for
select	cla_fe_id, politica_erp_id, prioridad,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
and		coalesce(tipo_operacion_ini, 0) = 0
and		coalesce(tipo_operacion_fin, 0) = 0
and		coalesce(id_banco_ini, 0) = 0
and		coalesce(id_banco_fin, 0) = 0
and		coalesce(lpad(id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		coalesce(lpad(id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
order by prioridad asc;
begin 

--===============================================================================================--
--== empieza ppto ==--
--== limpia tabla de versiones de flujo ==--
delete	from fecxp_rep_ppto_ver where cual_erp = 'O';
--== carga versiones de flujo ==--
v_separador1 := 1;
v_separador2 := (instr(v_parametros, ',', 1, 1))::numeric;
for v_conta in 1..5
loop
v_linea_id := v_linea_id + 1;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_PARAMETROS: ', oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1))) ;/* dmap converted statement end */
insert	into fecxp_rep_ppto_ver(
linea_id, version_fe, tipo_dato, cual_erp)
values (v_linea_id, oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1), 'P', 'O');
v_separador1 := (instr(v_parametros, ',', 1, v_conta))::numeric  + 1;
v_separador2 := (instr(v_parametros, ',', 1, v_conta + 1))::numeric;
-- dbms_output.put_line ('V_SEPARADOR1: ' || to_char (v_separador1));
-- dbms_output.put_line ('V_SEPARADOR2: ' || to_char (v_separador2));
end loop;
--== carga versiones de datos importados ==--
v_linea_id := 0;
for v_conta in 6..10
loop
v_linea_id := v_linea_id + 1;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_PARAMETROS: ', oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1))) ;/* dmap converted statement end */
insert	into fecxp_rep_ppto_ver(
linea_id, version_fe, tipo_dato, cual_erp)
values (v_linea_id, oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1), 'I', 'O');
v_separador1 := (instr(v_parametros, ',', 1, v_conta))::numeric  + 1;
v_separador2 := (instr(v_parametros, ',', 1, v_conta + 1))::numeric;
-- dbms_output.put_line ('V_SEPARADOR1: ' || to_char (v_separador1));
-- dbms_output.put_line ('V_SEPARADOR2: ' || to_char (v_separador2));
end loop;
/* commit; */
--== limpia tabla del reporte	==--
delete	from fecxp_rep_ppto_com_ver_erp
where	version_fe > 0;
/* commit; */
--== se carga el presupuesto para clasificarlo	==--
insert	into fecxp_rep_ppto_com_ver_erp(
version_id, version_fe, e_codigo, cla_fe_id, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, periodo, mes, moneda, importe_linea, id_sesion)
select	v.linea_id, p.version_fe, p.e_codigo, '|' as cla_fe_id, p.code_combination, p.oracle_segmento1, p.oracle_segmento2, p.oracle_segmento3,p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7, p.periodo, p.mes, p.moneda, p.importe_linea, v_id_sesion
from	fecxp_ppto_conversion_erp p,
fecxp_rep_ppto_ver v
where	p.version_fe = v.version_fe
and		v.tipo_dato = 'P'
and		v.cual_erp = 'O';
/* commit; */
--== se cargan los datos importados	==--
insert	into fecxp_rep_ppto_com_ver_erp(
version_id, version_fe, e_codigo, cla_fe_id, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, periodo, mes, moneda, importe_linea, id_sesion)
select	v.linea_id, v.version_fe_vp, p.e_empresa_imp, p.cla_fe_id_imp, 0, '', '', '', '', '', '', '', (to_char(p.fecha, 'YYYY'))::numeric  periodo, p.mes, p.moneda_imp, sum(p.importe_linea), v_id_sesion
from	fecxp_importacion_datos_hist p,
(
select	vp.linea_id, vp.version_fe version_fe_vp, vi.version_fe version_fe_vi
from	fecxp_rep_ppto_ver vp,
fecxp_rep_ppto_ver vi
where	vp.linea_id = vi.linea_id
and		vp.tipo_dato = 'P'
and		vi.tipo_dato = 'I'
and		vp.cual_erp = 'O'
) v
where	p.tipo_importacion = 'P'
and		(p.atributo_3)::numeric  = v.version_fe_vi
group by v.linea_id, v.version_fe_vp, p.e_empresa_imp, p.cla_fe_id_imp, (to_char(p.fecha, 'YYYY'))::numeric , p.mes, p.moneda_imp;
/* commit; */
--==		clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open		cursor_clasificacion_fe_oracle;
loop
fetch	cursor_clasificacion_fe_oracle
into	v_cla_fe_id, v_politica_erp_id, v_prioridad,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* dmap converted statement start *//* apply on cursor_clasificacion_fe_oracle */
perform dbms_output.put_line( concat('V_CLA_FE_ID: ', v_cla_fe_id , ' V_POLITICA_ERP_ID: ' , v_politica_erp_id , ' V_PRIORIDAD: ' , v_prioridad)) ; -- || ' V_ORA_S1_INI: ' || v_ora_s1_ini || ' V_ORA_S1_FIN: ' || v_ora_s1_fin || ' V_ORA_S2_INI: ' || v_ora_s2_ini || ' V_ORA_S2_FIN: ' || v_ora_s2_fin || ' V_ORA_S3_INI: ' || v_ora_s3_ini || ' V_ORA_S3_FIN: ' || v_ora_s3_fin || ' V_ORA_S4_INI: ' || v_ora_s4_ini || ' V_ORA_S4_FIN: ' || v_ora_s4_fin || ' V_ORA_S5_INI: ' || v_ora_s5_ini || ' V_ORA_S5_FIN: ' || v_ora_s5_fin || ' V_ORA_S6_INI: ' || v_ora_s6_ini || ' V_ORA_S6_FIN: ' || v_ora_s6_fin || ' V_ORA_S7_INI: ' || v_ora_s7_ini || ' V_ORA_S7_FIN: ' || v_ora_s7_fin);
/* dmap converted statement end */
update	fecxp_rep_ppto_com_ver_erp
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
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_oracle;
--===============================================================================================--
--== termina ppto ==--
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
