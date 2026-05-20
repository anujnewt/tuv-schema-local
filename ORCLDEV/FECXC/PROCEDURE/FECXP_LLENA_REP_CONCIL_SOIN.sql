create or replace procedure fecxc."fecxp_llena_rep_concil_soin"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo      int:= 2005;
v_mes 	       int:= 01;   */
v_id_sesion    varchar(25):= to_char(clock_timestamp(),'YYYYMMDD');
v_cla_fe_id    fecxp_politicas_soin.cla_fe_id%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_prioridad    fecxp_politicas_soin.prioridad%type;
v_ctam01_ini   fecxp_politicas_soin.ctam01_ini%type;
v_ctam01_fin   fecxp_politicas_soin.ctam01_fin%type;
v_ctam02_ini   fecxp_politicas_soin.ctam02_ini%type;
v_ctam02_fin   fecxp_politicas_soin.ctam02_fin%type;
v_ctam03_ini   fecxp_politicas_soin.ctam03_ini%type;
v_ctam03_fin   fecxp_politicas_soin.ctam03_fin%type;
v_tipo_ini     fecxp_politicas_soin.tipo_ini%type;
v_tipo_fin     fecxp_politicas_soin.tipo_fin%type;
v_division_ini fecxp_politicas_soin.division_ini%type;
v_division_fin fecxp_politicas_soin.division_fin%type;
v_rubro_ini	   fecxp_politicas_soin.rubro_ini%type;
v_rubro_fin    fecxp_politicas_soin.rubro_fin%type;
cursor_clasificacion_fe cursor for
select	 cla_fe_id, prioridad, politica_soin_id, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin,
ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin
from	 fecxp_politicas_soin
where  	 activa_regla = 1
order by prioridad asc;
begin 

insert	 into fecxp_cuentas_soin_caratula(e_codigo, ctam01, ctam02, ctam03, tipo, division, rubro,moneda)
select	distinct cs.e_codigo, cs.ctam01, cs.ctam02, cs.ctam03, cs.ctatip, cs.cg13di, cs.cg13ru, rs.moneda
from	fecxp_rep_real_soin rs,
fecxp_cat_cuentas_soin cs
where	cs.e_codigo = rs.cod_empresa
and		cs.ctam01 	= rs.ctam01
and		cs.ctam02 	= rs.ctam02
and		cs.ctam03 	= rs.ctam03
and		(to_char(rs.fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and		(to_char(rs.fecha_aplicacion, 'MM'))::numeric  = v_mes;
open  cursor_clasificacion_fe;
loop
--- clasificacion de las cuentas segun flujo de efectivo
fetch cursor_clasificacion_fe
into  v_cla_fe_id, v_prioridad, v_politica_soin_id, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin;
exit when not found; /* apply on cursor_clasificacion_fe */
update	fecxp_cuentas_soin_caratula
set		cla_fe_id = v_cla_fe_id
where (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and (tipo >= coalesce(v_tipo_ini, '0'))
and (tipo <= coalesce(v_tipo_fin, 'z'))
and (division >= coalesce(v_division_ini, 0))
and (division <= coalesce(v_division_fin, 9999))
and (rubro >= coalesce(v_rubro_ini, 0))
and (rubro <= coalesce(v_rubro_fin, 9999))
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe;
-----------------------       insercion de reales  		            -----------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.cod_empresa, rs.des_empresa, rs.cla_id_fe, rs.cla_fe_des, '1REAL' as concepto,
rs.moneda, rs.importe_linea, rs.fecha_aplicacion, rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_rep_real_soin rs,
fecxp_cuentas_soin_caratula cs
where (to_char(rs.fecha_aplicacion,'MM'))::numeric  =   v_mes
and (to_char(rs.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and cs.e_codigo = rs.cod_empresa
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;
-----------------------       insercion de moivimientos complementarios            -----------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.cod_empresa, rs.des_empresa, rs.cla_id_fe, rs.cla_fe_des, '6MC_DEB' as concepto,
rs.moneda, rs.importe_debito, rs.fecha_aplicacion, rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_rep_mvcomp_soin  rs,
fecxp_cuentas_soin_caratula cs
where (to_char(rs.fecha_aplicacion,'MM'))::numeric  = v_mes
and (to_char(rs.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and cs.e_codigo = rs.cod_empresa
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.cod_empresa, rs.des_empresa, rs.cla_id_fe, rs.cla_fe_des, '7MC_CRE' as concepto,
rs.moneda, rs.importe_credito, rs.fecha_aplicacion, rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_rep_mvcomp_soin  rs,
fecxp_cuentas_soin_caratula cs
where (to_char(rs.fecha_aplicacion,'MM'))::numeric  = 05--v_mes
and (to_char(rs.fecha_aplicacion,'YYYY'))::numeric  = 2001 --v_periodo
and cs.e_codigo = rs.cod_empresa
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;/* dmap converted statement start */
------------------------ insercion de saldos ------------------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.e_codigo, e.des_empresa, cf.cla_fe_id, cf.cla_fe_des, '4SAL_DEB' as concepto,
rs.moneda, rs.saldo_inicial_mo,to_date concat(to_date, rs.mes, '-', rs.periodo) ,'MM-YYYY'), rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_saldos_operativo_soin  rs,
fecxp_cuentas_soin_caratula cs,
fecxp_clasificacion_fe cf,
fecxc_empresas e
where rs.mes = 05--v_mes
and rs.periodo = 2001 --v_periodo
and cf.cla_fe_id = cs.cla_fe_id
and e.e_codigo = rs.e_codigo
and cs.e_codigo = rs.e_codigo
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.e_codigo, e.des_empresa, cf.cla_fe_id, cf.cla_fe_des, '5SAL_CRE' as concepto,
rs.moneda, rs.saldo_inicial_mo,to_date concat(to_date, rs.mes, '-', rs.periodo) ,'MM-YYYY'), rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_saldos_operativo_soin  rs,
fecxp_cuentas_soin_caratula cs,
fecxp_clasificacion_fe cf,
fecxc_empresas e
where rs.mes = 05--v_mes
and rs.periodo = 2001 --v_periodo
and cf.cla_fe_id = cs.cla_fe_id
and e.e_codigo = rs.e_codigo
and cs.e_codigo = rs.e_codigo
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;/* dmap converted statement end *//* dmap converted statement start */
------------------------------------ insercion de presupuesto       ----------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
tipo_cambio, fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.cod_empresa, rs.des_empresa, rs.cla_id_fe, rs.cla_fe_des, '2PPTO_FE' as concepto,
rs.moneda, rs.importe_linea, rs.tipo_cambio, to_date concat(to_date, rs.mes, '-', rs.periodo)) , rs.ctam01, rs.ctam02, rs.ctam03
from fecxp_rep_ppto_soin rs,
fecxp_cuentas_soin_caratula cs
where rs.mes = 05--v_mes
and rs.periodo = 2001 --v_periodo
and cs.e_codigo = rs.cod_empresa
and cs.ctam01 = rs.ctam01
and cs.ctam02 = rs.ctam02
and cs.ctam03 = rs.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto, moneda, importe_linea,
tipo_cambio, fecha_aplicacion, ctam01, ctam02, ctam03)
select rs.e_codigo, rs.e_codigo, cs.cla_fe_id, cf.cla_fe_des, '3PPTO_OP' as concepto,
rs.moneda, rs.importe_linea, rs.tipo_cambio,to_date concat(to_date, rs.mes_extraccion, '-', rs.periodo_extraccion)) , rs.arsmap, rs.aejmap, rs.cncmap
from fecxp_ppto_operativo_soin rs,
fecxp_cuentas_soin_caratula cs,
fecxp_clasificacion_fe cf
where rs.mes_extraccion = 05--v_mes
and rs.periodo_extraccion = 2001 --v_periodo
and cf.cla_fe_id = cs.cla_fe_id
and cs.e_codigo = rs.e_codigo
and cs.ctam01 = rs.arsmap
and cs.ctam02 = rs.aejmap
and cs.ctam03 = rs.cncmap;/* dmap converted statement end *//* dmap converted statement start */
------------------------------------      ------------------------------------      ------------------------------------
------------------------------------      llenar a '0s'       ----------------------
------------------------------------      ------------------------------------      ------------------------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '2PPTO_FE' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '2PPTO_FE') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '3PPTO_OP' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '3PPTO_OP') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '6MC_DEB' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '6MC_DEB') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '7MC_CRE' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '7MC_CRE') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '5SAL_CRE' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '5SAL_CRE') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end *//* dmap converted statement start */
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select distinct b.cod_empresa, b.des_empresa, b.cla_id_fe, b.cla_fe_des, '4SAL_DEB' as concepto,
moneda, 0 as importe, to_date concat(to_date, v_mes, '-', v_periodo) ,'MM-YYYY'), b.ctam01, b.ctam02, b.ctam03
from (select ctam01, ctam02, ctam03
from fecxp_cuentas_soin_caratula
except
select distinct ctam01, ctam02, ctam03
from fecxp_rep_conciliacion_soin
where concepto = '4SAL_DEB') a, fecxp_rep_conciliacion_soin b
where a.ctam01 = b.ctam01
and a.ctam02 = b.ctam02
and a.ctam03 = b.ctam03;/* dmap converted statement end */
/* commit; */
------------------------------       ------------------------------       ------------------------------
------------------------------                tipo de cambio			  ------------------------------
------------------------------       ------------------------------       ------------------------------
update fecxp_rep_conciliacion_soin rs
set    tipo_cambio = (select m.tipo_cambio from fecxp_monedas m
where m.mon_oracle = rs.moneda
and m.mes = (to_char(rs.fecha_aplicacion,'MM'))::numeric );
------------------------------       ------------------------------       ------------------------------
------------------------------           todo a pss						  ------------------------------
------------------------------       ------------------------------       ------------------------------
insert into fecxp_rep_conciliacion_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, concepto,
moneda, importe_linea, fecha_aplicacion, ctam01, ctam02, ctam03)
select	a.cod_empresa, a.des_empresa, a.cla_id_fe, a.cla_fe_des, a.concepto, 'PSS' as moneda, a.importe_linea*b.tipo_cambio, a.fecha_aplicacion, a.ctam01, a.ctam02, a.ctam03
from fecxp_rep_conciliacion_soin a,
fecxp_monedas b
where (to_char(a.fecha_aplicacion,'YYYY'))::numeric  = v_periodo
and (to_char(a.fecha_aplicacion,'MM'))::numeric  = v_mes
and b.mon_oracle = a.moneda
and b.mes = (to_char(a.fecha_aplicacion,'MM'))::numeric;end;
$body$
language plpgsql
;
