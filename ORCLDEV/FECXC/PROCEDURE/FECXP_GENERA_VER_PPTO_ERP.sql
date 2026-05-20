create or replace procedure fecxc."fecxp_genera_ver_ppto_erp"  ( v_version_fe integer, v_usuario_id varchar, v_comentario varchar, v_periodo_extraccion integer, v_version_extraccion integer, v_estatus_extraccion varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_registros_version integer;
valores_cortar VARCHAR(10)[];

contador_mensual integer;

/*modificado 20090713  abrir presupuesto a varias monedas*/
-- v_e_codigo integer;

/*    v_version_fe integer:= 11;

v_usuario_id varchar2 (25):= 'fecxc';

v_comentario varchar2 (255):= 'Prueba para Empresa SOIN';

v_periodo_extraccion integer:= 2007;

v_version_extraccion integer:= 0;

v_estatus_extraccion varchar2 (255):= 'EXITOSO';

*/
begin 

select    coalesce(count(1), 0) cuenta
into strict    v_registros_version
from    gl.gl_code_combinations__erp_prod cc,
interface.xxglb_pptos__erp_prod glp,
gl.gl_sets_of_books__erp_prod     sob,
gl.gl_translation_rates__erp_prod tc,
gl.gl_periods__erp_prod           per
where    sob.set_of_books_id = tc.set_of_books_id
and sob.attribute1      ='O'
and tc.actual_flag      ='B'
and sob.period_set_name = per.period_set_name
and per.period_name     = tc.period_name
and glp.yyyy = v_periodo_extraccion   --parametro
and cc.chart_of_accounts_id = sob.chart_of_accounts_id
and glp.moneda <> sob.currency_code
and per.period_year = glp.yyyy
and sob.set_of_books_id = glp.libro_id
and        cc.segment1 = glp.cia
and        cc.segment2 = glp.neg
and        cc.segment3 = glp.cta
and        cc.segment4 = glp.scta
and        cc.segment5 = glp.cc
and        cc.segment6 = glp.icia
and        cc.segment7 = glp.top
and        glp.moneda = tc.to_currency_code  ---ligar por moneda
;/* dmap converted statement start */
valores_cortar := arreglo( concat('ENE-', to_char(clock_timestamp(),'YY')) , concat('FEB-', to_char(clock_timestamp(),'YY')) , concat('MAR-', to_char(clock_timestamp(),'YY')) , concat('ABR-', to_char(clock_timestamp(),'YY')) , concat('MAY-', to_char(clock_timestamp(),'YY')) , concat('JUN-', to_char(clock_timestamp(),'YY')) , concat('JUL-', to_char(clock_timestamp(),'YY')) , concat('AGO-', to_char(clock_timestamp(),'YY')) , concat('SEP-', to_char(clock_timestamp(),'YY')) , concat('OCT-', to_char(clock_timestamp(),'YY')) , concat('NOV-', to_char(clock_timestamp(),'YY')) , concat('DIC-', to_char(clock_timestamp(),'YY'))) ;/* dmap converted statement end *//* dmap converted statement start */
if v_registros_version > 0 then
delete    from fecxp_ppto_opera_erp
where    version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
delete    from fecxp_ppto_conversion_erp
where    version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end */
/* commit; */
/*agregado 08/11/2010*/
delete from fecxc.fecxp_ppto_opera_erp_tmp;/* dmap converted statement start */
/* commit; */
/*modificado 08/11/2010 extraer los datos sin sumarizar a una tabla intermedia (fecxc.fecxp_ppto_opera_erp_tmp) y de ahi sumarizarlos hacia la tabla original(fecxp_ppto_opera_erp)*/
/*modificado 10/11/2010 para extraer los datos mensualmente*/
for contador_mensual in 1..12 loop
perform dbms_output.put_line( concat('PERIODO-> ', valores_cortar[contador_mensual], ' INICIA', to_char(clock_timestamp(), 'HH:MI:SS'))) ;/* dmap converted statement end */
insert into fecxc.fecxp_ppto_opera_erp_tmp(periodo_extraccion, mes_extraccion, yyyy,libro_id, version_id, moneda,code_combination_id, cia, neg,
cta, scta, cc,icia, top, ppto_01,ppto_02, ppto_03, ppto_04,ppto_05, ppto_06, ppto_07, ppto_08, ppto_09, ppto_10,
ppto_11, ppto_12, tc_01, tc_02, tc_03, tc_04, tc_05, tc_06, tc_07, tc_08, tc_09, tc_10, tc_11, tc_12, mf, mo, version_fe)
select                               (to_char(clock_timestamp(),'YYYY'))::numeric  periodo_extraccion,
(to_char(clock_timestamp(),'MM'))::numeric  mes_extraccion,
glp.yyyy,
glp.libro_id,
glp.version_id,
glp.moneda,
cc.code_combination_id,
glp.cia, glp.neg, glp.cta, glp.scta, glp.cc, glp.icia, glp.top,
glp.ppto_01,
glp.ppto_02,
glp.ppto_03,
glp.ppto_04,
glp.ppto_05,
glp.ppto_06,
glp.ppto_07,
glp.ppto_08,
glp.ppto_09,
glp.ppto_10,
glp.ppto_11,
glp.ppto_12,
case when per.period_num= 1 then tc.eop_rate else 0 end tc_01,
case when per.period_num= 2 then tc.eop_rate else 0 end tc_02,
case when per.period_num= 3 then tc.eop_rate else 0 end tc_03,
case when per.period_num= 4 then tc.eop_rate else 0 end tc_04,
case when per.period_num= 5 then tc.eop_rate else 0 end tc_05,
case when per.period_num= 6 then tc.eop_rate else 0 end tc_06,
case when per.period_num= 7 then tc.eop_rate else 0 end tc_07,
case when per.period_num= 8 then tc.eop_rate else 0 end tc_08,
case when per.period_num= 9 then tc.eop_rate else 0 end tc_09,
case when per.period_num=10 then tc.eop_rate else 0 end tc_10,
case when per.period_num=11 then tc.eop_rate else 0 end tc_11,
case when per.period_num=12 then tc.eop_rate else 0 end tc_12,
sob.currency_code     mf,
tc.to_currency_code   mo,
v_version_fe
from    gl.gl_code_combinations__erp_prod cc,
interface.xxglb_pptos__erp_prod glp,
gl.gl_sets_of_books__erp_prod     sob,
gl.gl_translation_rates__erp_prod tc,
gl.gl_periods__erp_prod           per
where    sob.set_of_books_id = tc.set_of_books_id
and sob.attribute1      ='O'
and tc.actual_flag      ='B'
and sob.period_set_name = per.period_set_name
and per.period_name     = tc.period_name
and glp.yyyy = v_periodo_extraccion   --parametro
and cc.chart_of_accounts_id = sob.chart_of_accounts_id
and glp.moneda <> sob.currency_code
and per.period_year = glp.yyyy
and sob.set_of_books_id = glp.libro_id
and        cc.segment1 = glp.cia
and        cc.segment2 = glp.neg
and        cc.segment3 = glp.cta
and        cc.segment4 = glp.scta
and        cc.segment5 = glp.cc
and        cc.segment6 = glp.icia
and        cc.segment7 = glp.top
and        glp.moneda = tc.to_currency_code   --ligar por moneda
and        per.period_name     = valores_cortar[contador_mensual];   ---para hacerlo mensualmente
/* dmap converted statement start */
perform dbms_output.put_line( concat('PERIODO-> ', valores_cortar[contador_mensual], ' TERMINA', to_char(clock_timestamp(), 'HH:MI:SS'))) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
/*los tipos de cambio ahora estaran en las columnas tc_01, tc_02...tc_n*/
insert    into fecxp_ppto_opera_erp(e_codigo, secuencia_ptto_oracle, periodo_extraccion, mes_de_extraccion, periodo_ppto, libro_id, version_id,
moneda, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
ppto_01, pss_01, usd_01, eur_01,ppto_02, pss_02, usd_02, eur_02,ppto_03, pss_03, usd_03, eur_03,
ppto_04, pss_04, usd_04, eur_04, ppto_05, pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06, eur_06, ppto_07, pss_07, usd_07, eur_07,
ppto_08, pss_08, usd_08, eur_08, ppto_09, pss_09, usd_09, eur_09,
ppto_10, pss_10, usd_10, eur_10, ppto_11, pss_11, usd_11, eur_11,
ppto_12, pss_12, usd_12, eur_12, version_fe, tc_01, tc_02, tc_03, tc_04, tc_05, tc_06,
tc_07, tc_08, tc_09, tc_10, tc_11, tc_12, mon_func,  mon_orig
)
select          e.e_codigo,
nextval('fecxc.secuencia_ptto_oracle'),
p.periodo_extraccion,
p.mes_extraccion,
p.yyyy,
p.libro_id,
p.version_id,
p.moneda,
p.code_combination_id,
p.cia, p.neg, p.cta, p.scta, p.cc, p.icia, p.top,
p.ppto_01, 1,1,1,
p.ppto_02, 1,1,1,
p.ppto_03, 1,1,1,
p.ppto_04, 1,1,1,
p.ppto_05, 1,1,1,
p.ppto_06, 1,1,1,
p.ppto_07, 1,1,1,
p.ppto_08, 1,1,1,
p.ppto_09, 1,1,1,
p.ppto_10, 1,1,1,
p.ppto_11, 1,1,1,
p.ppto_12, 1,1,1,
v_version_fe,
p.tc_01,
p.tc_02,
p.tc_03,
p.tc_04,
p.tc_05,
p.tc_06,
p.tc_07,
p.tc_08,
p.tc_09,
p.tc_10,
p.tc_11,
p.tc_12,
p.mf,
p.mo
from (
select
p.periodo_extraccion,
p.mes_extraccion,
p.yyyy,
p.libro_id,
p.version_id,
p.moneda,
p.code_combination_id,
p.cia, p.neg, p.cta, p.scta, p.cc, p.icia, p.top,
p.ppto_01,
p.ppto_02,
p.ppto_03,
p.ppto_04,
p.ppto_05,
p.ppto_06,
p.ppto_07,
p.ppto_08,
p.ppto_09,
p.ppto_10,
p.ppto_11,
p.ppto_12,
sum(tc_01) tc_01,
sum(tc_02) tc_02,
sum(tc_03) tc_03,
sum(tc_04) tc_04,
sum(tc_05) tc_05,
sum(tc_06) tc_06,
sum(tc_07) tc_07,
sum(tc_08) tc_08,
sum(tc_09) tc_09,
sum(tc_10) tc_10,
sum(tc_11) tc_11,
sum(tc_12) tc_12,
p.mf,
p.mo
from   fecxc.fecxp_ppto_opera_erp_tmp p
group by p.yyyy,
p.libro_id,
p.version_id,
p.moneda,
p.code_combination_id,
p.cia, p.neg, p.cta, p.scta, p.cc, p.icia, p.top,
p.ppto_01,
p.ppto_02,
p.ppto_03,
p.ppto_04,
p.ppto_05,
p.ppto_06,
p.ppto_07,
p.ppto_08,
p.ppto_09,
p.ppto_10,
p.ppto_11,
p.ppto_12,
p.mf,
p.mo,
p.periodo_extraccion,
p.mes_extraccion) p,
fecxc.fecxc_empresas e
where ltrim(e.e_codigo_soin::text,'0') = ltrim(p.cia::text,'0');/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
update    fecxp_ppto_opera_erp
set        moneda = 'MXP'
where    moneda = 'PSS'
and        version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
/*manejar la moneda bov como usd*/
update    fecxp_ppto_opera_erp
set        moneda = 'USD'
where    moneda = 'BOV'
and        version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
/*manejar la funcional usp como usd*/
update    fecxp_ppto_opera_erp
set        moneda = 'USD'
where    moneda = 'USP'
and        mon_func = 'USD'
and        version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
/*manejar la funcional usp como usd*/
update    fecxp_ppto_opera_erp
set        moneda = 'ARS'
where    moneda = 'ARG'
and        mon_func = 'ARS'
and        version_fe = v_version_fe; -- and e_codigo = coalesce (v_e_codigo, e_codigo);
/* dmap converted statement end */
/* commit; */
delete    from fecxp_ppto_opera_erp_enc
where    version_fe = v_version_fe;
/* commit; */
delete    from fecxp_ppto_conversion_erp_enc
where    version_fe = v_version_fe;
/* commit; */
insert    into fecxc.fecxp_ppto_opera_erp_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select    version_fe, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, version_id, v_estatus_extraccion, 0
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe
group by version_fe, periodo_extraccion, version_id;/* dmap converted statement start */
/* commit; */
insert    into fecxp_ppto_bitacora_procesos(
sec_ext_bitacora, proceso_id, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, version_ppto_generado)
select    nextval('sec_ext_bitacora'), 1, clock_timestamp(), 'EXTRACCION EXITOSA', periodo_extraccion, version_id, v_estatus_extraccion, version_fe
from (
select    periodo_extraccion, version_id, version_fe
from    fecxp_ppto_opera_erp
where    version_fe = v_version_fe -- and e_codigo = coalesce (v_e_codigo, e_codigo)
group by periodo_extraccion, version_id, version_fe
) alias3;/* dmap converted statement end */
/* commit; */
else
update    fecxc.fecxp_ppto_opera_erp_enc
set        comentario = 'ESTA VERSION DE PRESUPUESTO NO EXISTE'
where    version_fe = v_version_fe;
/* commit; */
end if;
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';/* dmap converted statement start */
when others then
--dbms_output.put_line('ERROR '||sqlerrm||' '||sqlcode);
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
