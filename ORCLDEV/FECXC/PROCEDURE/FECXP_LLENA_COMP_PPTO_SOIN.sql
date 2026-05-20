create or replace procedure fecxc."fecxp_llena_comp_ppto_soin"  ( v_parametros varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_sesion timestamp(0):= clock_timestamp();
v_conta integer:= 0;
v_linea_id integer:= 0;
v_separador1 integer:= 0;
v_separador2 integer:= 0;
v_cla_fe_id fecxp_politicas_soin.cla_fe_id%type;
v_prioridad fecxp_politicas_soin.prioridad%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_e_codigo_ini fecxp_politicas_soin.e_codigo_ini%type;
v_e_codigo_fin fecxp_politicas_soin.e_codigo_fin%type;
v_ctam01_ini fecxp_politicas_soin.ctam01_ini%type;
v_ctam01_fin fecxp_politicas_soin.ctam01_fin%type;
v_ctam02_ini fecxp_politicas_soin.ctam02_ini%type;
v_ctam02_fin fecxp_politicas_soin.ctam02_fin%type;
v_ctam03_ini fecxp_politicas_soin.ctam03_ini%type;
v_ctam03_fin fecxp_politicas_soin.ctam03_fin%type;
v_tipo_ini fecxp_politicas_soin.tipo_ini%type;
v_tipo_fin fecxp_politicas_soin.tipo_fin%type;
v_division_ini fecxp_politicas_soin.division_ini%type;
v_division_fin fecxp_politicas_soin.division_fin%type;
v_rubro_ini fecxp_politicas_soin.rubro_ini%type;
v_rubro_fin fecxp_politicas_soin.rubro_fin%type;
v_ctacr1_ini fecxp_politicas_soin.ctacr1_ini%type;
v_ctacr1_fin fecxp_politicas_soin.ctacr1_fin%type;
v_ctacr2_ini fecxp_politicas_soin.ctacr2_ini%type;
v_ctacr2_fin fecxp_politicas_soin.ctacr2_fin%type;
cursor_clasificacion_fe_soin cursor for
select	cla_fe_id, politica_soin_id, prioridad,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from	fecxp_politicas_soin
where	activa_regla = 1
and		id_tipo_movto in ('A', 'E')
order by prioridad asc;
begin 

--===============================================================================================--
--== ppto soin ==--
--== limpia tabla de versiones de flujo ==--
delete	from fecxp_rep_ppto_ver where cual_erp = 'S';
--== carga versiones de flujo ==--
v_separador1 := 1;
v_separador2 := (instr(v_parametros, ',', 1, 1))::numeric;
for v_conta in 1..5
loop
v_linea_id := v_linea_id + 1;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_PARAMETROS: ', oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1))) ;/* dmap converted statement end */
insert	into fecxp_rep_ppto_ver(
linea_id, version_fe, tipo_dato, cual_erp)
values (v_linea_id, oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1), 'P', 'S');
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
values (v_linea_id, oracle.substr(v_parametros, v_separador1, v_separador2 - v_separador1), 'I', 'S');
v_separador1 := (instr(v_parametros, ',', 1, v_conta))::numeric  + 1;
v_separador2 := (instr(v_parametros, ',', 1, v_conta + 1))::numeric;
-- dbms_output.put_line ('V_SEPARADOR1: ' || to_char (v_separador1));
-- dbms_output.put_line ('V_SEPARADOR2: ' || to_char (v_separador2));
end loop;
/* commit; */
--== limpia tabla del reporte	==--
delete	from fecxp_rep_ppto_com_ver_soin
where	version_fe > 0;
/* commit; */
--== se carga el presupuesto para clasificarlo	==--
insert	into fecxp_rep_ppto_com_ver_soin(
version_id, version_fe, cla_fe_id, e_codigo, ctam01, ctam02, ctam03, tipo, division, rubro, ctacr1, ctacr2, periodo, mes, moneda, importe_linea, id_sesion)
select	v.linea_id, p.version_fe, '|' as cla_fe_id, p.e_codigo, p.arsmap, p.aejmap, p.cncmap, 0, 0, 0, p.ctacr1, p.ctacr2, p.periodo, p.mescod, m.mon_oracle, p.importe_linea, v_id_sesion
from	fecxp_ppto_conversion_soin p,
fecxp_rep_ppto_ver v,
fecxp_monedas m
where	p.version_fe = v.version_fe
and		v.tipo_dato = 'P'
and		v.cual_erp = 'S'
and		m.mon_sybase = p.moneda
and		m.periodo = p.periodo
and		m.mes = p.mescod;
/* commit; */
--== se cargan los datos importados	==--
insert	into fecxp_rep_ppto_com_ver_erp(
version_id, version_fe, e_codigo, cla_fe_id, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, periodo, mes, moneda, importe_linea, id_sesion)
select	v.linea_id, v.version_fe_vp, p.e_empresa_imp, '|' as cla_fe_id, 0, '', '', '', '', '', '', '', (to_char(p.fecha, 'YYYY'))::numeric  periodo, p.mes, p.moneda_imp, sum(p.importe_linea), v_id_sesion
from	fecxp_importacion_datos_hist p,
(
select	vp.linea_id, vp.version_fe version_fe_vp, vi.version_fe version_fe_vi
from	fecxp_rep_ppto_ver vp,
fecxp_rep_ppto_ver vi
where	vp.linea_id = vi.linea_id
and		vp.tipo_dato = 'P'
and		vi.tipo_dato = 'I'
and		vp.cual_erp = 'S'
) v
where	p.tipo_importacion = 'P'
and		(p.atributo_3)::numeric  = v.version_fe_vi
group by v.linea_id, v.version_fe_vp, p.e_empresa_imp, (to_char(p.fecha, 'YYYY'))::numeric , p.mes, p.moneda_imp;
/* commit; */
--== actualiza division y rubro		==--
update	fecxp_rep_ppto_com_ver_soin c1
set(division, rubro) =	(
select	c2.cg13di, c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where	c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
)
where	exists (
select	c2.cg13di, c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where	c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
);
/* commit; */
--==		clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open	cursor_clasificacion_fe_soin;
loop
fetch	cursor_clasificacion_fe_soin
into	v_cla_fe_id, v_politica_soin_id, v_prioridad,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* dmap converted statement start *//* apply on cursor_clasificacion_fe_soin */
-- dbms_output.put_line ('V_CLA_FE_ID: ' || v_cla_fe_id || ' V_POLITICA_SOIN_ID: ' || v_politica_soin_id || '  V_PRIORIDAD: ' ||  v_prioridad || ' V_E_CODIGO_INI: ' || v_e_codigo_ini || ' V_E_CODIGO_FIN: ' || v_e_codigo_fin ||' V_CTAM01_INI: ' || v_ctam01_ini);
-- dbms_output.put_line ('V_CTAM01_FIN: ' || nvl (v_ctam01_fin, ' ') ||' V_CTAM02_INI: ' || nvl (v_ctam02_ini, ' ') ||' V_CTAM02_FIN: ' || nvl (v_ctam02_fin, ' ') ||' V_CTAM03_INI: ' || nvl (v_ctam03_ini, ' ') ||' V_CTAM03_FIN: ' || nvl (v_ctam03_fin, ' '));
perform dbms_output.put_line( concat('V_DIVISION_INI: ', coalesce(v_division_ini, 0) , ' V_DIVISION_FIN: ' , coalesce(v_division_fin, 0) , ' V_RUBRO_INI: ' , coalesce(v_rubro_ini, 0) , ' V_RUBRO_FIN: ' , coalesce(v_rubro_fin, 0) , ' V_CTACR1_INI: ' , coalesce(v_ctacr1_ini, ' ') , ' V_CTACR1_FIN: ' , coalesce(v_ctacr1_fin, ' ') , ' V_CTACR2_INI: ' , coalesce(v_ctacr2_ini, ' ') , ' V_CTACR2_FIN: ' , coalesce(v_ctacr2_fin, ' '))) ;/* dmap converted statement end */
update	fecxp_rep_ppto_com_ver_soin
set		cla_fe_id = v_cla_fe_id
where (e_codigo >= coalesce(v_e_codigo_ini, 0))
and (e_codigo <= coalesce(v_e_codigo_fin, 9999))
and (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and (coalesce(division, 0) >= coalesce(v_division_ini, 0))
and (coalesce(division, 0) <= coalesce(v_division_fin, 9999))
and (coalesce(rubro, 0) >= coalesce(v_rubro_ini, 0))
and (coalesce(rubro, 0) <= coalesce(v_rubro_fin, 9999))
and (lpad(ctacr1::text, 4, '0'::text) >= coalesce(lpad(v_ctacr1_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr1::text, 4, '0'::text) <= coalesce(lpad(v_ctacr1_fin::text, 4, '0'::text), 'zzzz'))
and (lpad(ctacr2::text, 4, '0'::text) >= coalesce(lpad(v_ctacr2_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr2::text, 4, '0'::text) <= coalesce(lpad(v_ctacr2_fin::text, 4, '0'::text), 'zzzz'))
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_soin;
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
