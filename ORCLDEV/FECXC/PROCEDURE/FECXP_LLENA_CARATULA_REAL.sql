create or replace procedure fecxc."fecxp_llena_caratula_real"  ( v_mes_desde varchar, v_periodo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
/*v ariables para la bitacora*/
v_usuario_ejecucion varchar(25);
v_id_ejecucion integer:=0;
v_id_sesion varchar(25) := to_char(clock_timestamp(),'DD-MM-YYYY');
v_periodo_act integer:= (v_periodo)::numeric;
v_mes_act integer:= (v_mes_desde)::numeric;
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
v_id_banco_ini fecxp_politicas_erp.id_banco_ini%type;
v_id_banco_fin fecxp_politicas_erp.id_banco_fin%type;
v_id_chequera_ini fecxp_politicas_erp.id_chequera_ini%type;
v_id_chequera_fin fecxp_politicas_erp.id_chequera_fin%type;
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
v_contador_reg integer :=0;
cursor_clas_fe_oracle_ing cursor for
select    cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from    fecxp_politicas_erp
where    id_tipo_movto in ('A', 'I')
and        activa_regla = 1
order by prioridad asc;
cursor_clas_fe_soin_ing cursor for
select    cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin
from    fecxp_politicas_soin
where    id_tipo_movto in ('A', 'I')
and        activa_regla = 1
order by prioridad asc;
cursor_clas_fe_oracle_egr cursor for
select    cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from    fecxp_politicas_erp
where id_tipo_movto in ('A', 'E')
and  activa_regla = 1
order by prioridad asc;
cursor_clas_fe_soin_egr cursor for
select    cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from    fecxp_politicas_soin
where    id_tipo_movto in ('A', 'E')
and        activa_regla = 1
order by prioridad asc;
cursor_movtos_coinversion_egr cursor for --cursor de los movimientos de egresos para la caratula de coinversion
select  p.cla_fe_id,e.no_cuenta, e.folio_set,e.secuencia_pagos_erp, e.tipo_operacion, e.fecha_aplicacion,  m.mon_oracle, e.importe,
d.importe_linea,c.des_empresa, e.estatus_movimiento,(to_char(e.fecha_aplicacion,'YYYY')) periodo, (to_char(e.fecha_aplicacion,'MM')) mes,m.tipo_cambio,p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from    fecxc.fecxp_enc_pagos_erp e,
fecxc.fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.fecha_aplicacion >= to_date(v_periodo || lpad(v_mes_desde::text, 2, '0'::text) || '01', 'YYYYMMDD')
and        e.e_codigo =999
and     e.tipo_operacion in (3706,7001,7002,7003)
and        d.secuencia_pagos_erp = e.secuencia_pagos_erp
and        d.e_codigo= e.e_codigo
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'E'
and        p.tipo_clave = 'CO'
and     c.e_codigo = e.no_cuenta
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        not exists (
select    1
from    fecxp_movs_coinversion i
where    e.folio_set = i.folio_set
and    e.estatus_movimiento = i.id_status_mov  --para cancelados
);
cursor_movtos_coinversion_ing cursor for --cursor de los movimientos de ingresos para la caratula de coinversio
select  p.cla_fe_id,  e.no_cuenta, e.no_folio_det, e.secuencia_dep_especiales, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.importe,
coalesce(d.importe_linea, e.importe) importe_linea,'I', c.des_empresa, e.id_status_mov,(to_char(e.fec_valor,'YYYY')) periodo, (to_char(e.fec_valor,'MM')) mes,m.tipo_cambio, p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc.fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= to_date(v_periodo || lpad(v_mes_desde::text, 2, '0'::text) || '01', 'YYYYMMDD') and e.no_empresa = 999 and e.id_tipo_operacion_set in (3705,7000,7005)  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'CO' and c.e_codigo = e.no_cuenta and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select    1
from    fecxp_movs_coinversion i
where    e.no_folio_det = i.folio_set
and    e.id_status_mov = i.id_status_mov  --para cancelados
);
begin 

/*modificaci?n dic 08 v2.*/
/*modificaci?n marzo 09 v3 caratulas coin e inv*/
/*modificaci?n mayo 09 v4 importados coin e inv*/
/*modificaci?n junio 09 v9 coinversi?n e inversi?n inclu?dos por fecha*/
/*modificaci?n oct 29 09 v10  cta ctable ingresos*/
/*modificacion jun 29 09 eliminacion de folios duplicados y cambio de signo a los folios cancelados*/
/*24082011 se agrega bitacora de ejecucion*/
begin
perform dbms_output.put_line('ENTRA BITACORA');
select  coalesce(usuario_ppto_sig_ejecucion,user) into strict v_usuario_ejecucion from fecxp_ppto_extraccion_params a , dual b where proceso_id=7;
select  coalesce((max(id_ejecucion)+1),0) into strict v_id_ejecucion from fecxc.fecxp_bitacora_procesamiento;/* dmap converted statement start */
insert into fecxc.fecxp_bitacora_procesamiento(id_ejecucion,usuario, fecha, parametros,estatus_terminado,v_error ,proceso)
values (v_id_ejecucion,v_usuario_ejecucion, to_date(to_char(clock_timestamp(), 'DD-MM-YYYY HH:MI:SS'),'DD-MM-YYYY HH:MI:SS'),  concat(v_mes_desde, ' ', v_periodo) ,'EN PROCESO',null,'1 REPORTE REALES CARATULA');/* dmap converted statement end */
/* commit; */
perform dbms_output.put_line('SALE BITACORA');
exception
when others then
null;/* dmap converted statement start */
perform dbms_output.put_line( concat('ERROR BITACORA', sqlerrm)) ;/* dmap converted statement end */
end;
delete    from fecxp_ingresos_caratula_d_tmp;/* dmap converted statement start */
--== inicializa la tabla ==--
delete    from fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        to_date( concat(to_char(c.periodo), lpad(c.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
;/* dmap converted statement end *//* dmap converted statement start */
-----------------------------------------------borrar folios repetidos  ambas plataformas
delete from fecxc.fecxc_dep_especiales where no_folio_det in (
select no_folio_det from fecxc.fecxc_dep_especiales
where fec_valor between to_date( concat('01/JAN/', to_char(clock_timestamp(),'YYYY')) ) and  to_date( concat('31/DEC/', to_char(clock_timestamp(),'YYYY'))
) and concepto ='DEP S B COBRO'
group by
no_empresa, no_folio_det ,
id_divisa, tipo_cambio, importe, concepto,
plataforma
having count(*) > 1)
and  id_status_mov='P';/* dmap converted statement end */
-----------------------------------------------
--== mete el saldo inicial ==--
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea, c.tipo_caratula
from    fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo
and        c.mes = v_mes_desde - 1
and        v_mes_desde <> 1
and        c.cla_fe_id = 'SF'
and        c.tipo_caratula = 'CH';/* dmap converted statement start */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- ingresos
------------------------------------------------------------------------------------------------
--== clasifica e inserta ingresos cobranza e icia ==--
insert    into fecxp_ingresos_caratula_d_tmp(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, importe, id_banco, id_chequera, referencia,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, cual_erp, tipo_clasificacion,id_status_mov)
select    i.cod_valor,  i.no_empresa, i.no_folio_det, i.id_tipo_operacion_set, i.fec_valor, i.moneda, i.importe, i.id_banco, i.id_chequera, i.referencia,
case  when i.importe > 0 then i.importe_linea else case when i.importe_linea < 0 then i.importe_linea else (i.importe_linea*-1)  end end, '000', '00', '000', '000000', '00000000', '000', '0', i.cual_erp, case coalesce(i.cod_valor, '|') when '|' then null else 'MODULO FECXC' end,
i.id_status_mov  --cancelados
from    (
select    coalesce(b.cod_valor, '|') cod_valor,
a.no_empresa,
a.no_folio_det,
a.fec_valor,
a.importe,
m.mon_oracle moneda,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
sum(coalesce(b.importe_detalle, a.importe)) importe_linea,
a.referencia,
c.cual_erp,
a.id_status_mov --para cancelados
from    fecxc.fecxc_dep_especiales a,
fecxp_monedas m,
(
select    base_inf.codfolio, base_inf.e_codigo, base_inf.segmento1, base_inf.codoperacion, base_inf.tipocambio, base_inf.importe, base_inf.importe_detalle,
base_inf.f_deposito,  base_inf.segmento2, base_inf.cod_sec_det,
base_inf.cod_sec_catclas, base_inf.secmoneda,cod_flujo.cod_valor, cod_flujo.desc_valor
from (
select    a.codfolio, a.e_codigo, b.segmento1, a.codoperacion, a.tipocambio, a.importe, b.importe as importe_detalle,
a.f_deposito,  coalesce(b.segmento2, -1) as segmento2, b.cod_sec_det,
b.cod_sec_catclas, a.secmoneda
from    fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_det_clasfecxc i
where    a.e_codigo = b.e_codigo
and        a.cod_sec_clasifica = b.cod_sec_clasifica
and        b.cod_sec_det = i.cod_sec_det
and        b.cod_sec_catclas = i.cod_sec_catclas
--and        i.excluir_enreportes = 'NO'
and        nullif(b.segmento1::text, '') is not null
) base_inf
left outer join (
select    g1.cod_sec_lin, g1.sec_flujo_detcat, h1.cod_valor,
h1.desc_valor, g1.sec_concepto_detcat, g1.cod_sec_det, g1.cod_sec_catclas
from    fecxc_mapeo_flujo g1, fecxc_det_catalogos h1
where    g1.sec_flujo_detcat = h1.cod_sec_lin
and        h1.tipo_cat = 'FLUJO'
union
select    -1, -1, 'NO MAPEADOS', 'NO MAPEADOS', -1,-1,-1
) cod_flujo on (base_inf.segmento1 = cod_flujo.cod_sec_lin and base_inf.segmento2 = cod_flujo.sec_concepto_detcat and base_inf.cod_sec_catclas = cod_flujo.cod_sec_catclas and base_inf.cod_sec_det = cod_flujo.cod_sec_det) ) b,
fecxc_empresas c
where    a.no_empresa = b.e_codigo
and        a.no_folio_det = b.codfolio
and        a.fec_valor >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     a.no_empresa = c.e_codigo
and        m.mon_set = a.id_divisa
and        (to_char(a.fec_valor, 'MM'))::numeric  = m.mes
and        (to_char(a.fec_valor, 'YYYY'))::numeric  = m.periodo
group by -- coalesce (case when id_tipo_operacion_set = 3101 and a.id_banco = 14  and id_chequera in ('51451001688') then 'ING01' else b.cod_valor end, '|'),
coalesce(b.cod_valor, '|'),
a.no_empresa,
a.no_folio_det,
a.fec_valor,
a.importe,
m.mon_oracle,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
a.referencia,
c.cual_erp,
a.id_status_mov --para cancelados
) i
where    i.no_empresa = coalesce(v_e_codigo, i.no_empresa);/* dmap converted statement end *//* dmap converted statement start */
--== inserta el resto de ingresos con detalle contable donde aplica ==--
insert    into fecxp_ingresos_caratula_d_tmp(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, importe, id_banco, id_chequera, referencia,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, cual_erp, tipo_clasificacion,id_status_mov)
select    '|',  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.importe, e.id_banco, e.id_chequera, e.referencia,
coalesce(d.importe_linea, e.importe) importe_linea,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,
coalesce(d.ora_soin_segmento2, case c.cual_erp when 'O' then '00' else '000' end) ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, case c.cual_erp when 'O' then '000' else '000' end) ora_soin_segmento3,
coalesce(d.oracle_segmento4, case c.cual_erp when 'O' then '000000' else null end) ora_soin_segmento4,
coalesce(d.oracle_segmento5, case c.cual_erp when 'O' then '00000000' else null end) ora_soin_segmento5,
coalesce(d.oracle_segmento6, case c.cual_erp when 'O' then '000' else null end) ora_soin_segmento6,
coalesce(d.oracle_segmento7, case c.cual_erp when 'O' then '0' else null end) ora_soin_segmento7,
c.cual_erp,  null, e.id_status_mov
from fecxp_monedas m, fecxc_empresas c, fecxc.fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD') and e.no_empresa = coalesce(v_e_codigo, e.no_empresa)  and e.no_empresa = c.e_codigo and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select    1
from    fecxp_ingresos_caratula_d_tmp i
where    e.no_empresa = i.e_codigo
and        e.no_folio_det = i.folio_set
and    e.id_status_mov = i.id_status_mov --para cancelados
);/* dmap converted statement end */
-- clasifica conforme a referencias todo lo que no tenga cuenta ni venga clasificado de fecxc
update    fecxp_ingresos_caratula_d_tmp a
set(a.cla_fe_id, a.tipo_clasificacion) =
(
select    b.cla_fe_id, 'REFERENCIAS'
from    fecxp_cat_subcodigo b
where    b.no_empresa = a.e_codigo
and        b.id_codigo = oracle.substr(a.referencia, 1, 2)
and        b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and        b.estatus = 'ACTIVO'
and        nullif(b.cla_fe_id::text, '') is not null
)
where    1=1
--    and a.ora_soin_segmento1 = '000' 04062012 se modifica para que aun con cuentas contables se clasifique por ereferencias
and        oracle.substr(a.referencia, 3, 1) = '9'
and        coalesce(a.cla_fe_id, '|') = '|'
and        length(a.referencia) = 7
and        exists (
select    1
from    fecxp_cat_subcodigo b
where    b.no_empresa = a.e_codigo
and        b.id_codigo = oracle.substr(a.referencia, 1, 2)
and        b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and        b.estatus = 'ACTIVO'
and        nullif(b.cla_fe_id::text, '') is not null
);
--==  clasificacion de ingresos oracle segun politicas de clasificacion de fe ==--
open    cursor_clas_fe_oracle_ing;
loop
fetch    cursor_clas_fe_oracle_ing
into    v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clas_fe_oracle_ing */
--== clasificaci.n de cuentas contables erp ==--
update    fecxp_ingresos_caratula_d_tmp
set        cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POL?TICAS'
where (e_codigo >= coalesce(v_ora_s1_ini, 0))
and (e_codigo <= coalesce(v_ora_s1_fin, 9999))
and (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (ora_soin_segmento1 >= coalesce(v_ora_s1_ini, '0'))
and (ora_soin_segmento1 <= coalesce(v_ora_s1_fin, 'z'))
and (ora_soin_segmento2 >= coalesce(v_ora_s2_ini, '0'))
and (ora_soin_segmento2 <= coalesce(v_ora_s2_fin, 'z'))
and (ora_soin_segmento3 >= coalesce(v_ora_s3_ini, '0'))
and (ora_soin_segmento3 <= coalesce(v_ora_s3_fin, 'z'))
and (oracle_segmento4 >= coalesce(v_ora_s4_ini, '0'))
and (oracle_segmento4 <= coalesce(v_ora_s4_fin, 'z'))
and (oracle_segmento5 >= coalesce(v_ora_s5_ini, '0'))
and (oracle_segmento5 <= coalesce(v_ora_s5_fin, 'z'))
and (oracle_segmento6 >= coalesce(v_ora_s6_ini, '0'))
and (oracle_segmento6 <= coalesce(v_ora_s6_fin, 'z'))
and (oracle_segmento7 >= coalesce(v_ora_s7_ini, '0'))
and (oracle_segmento7 <= coalesce(v_ora_s7_fin, 'z'))
and        e_codigo = coalesce(v_e_codigo, e_codigo)
and        cual_erp = 'O'
and        coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clas_fe_oracle_ing;
--==  clasificacion de ingresos soin segun politicas de clasificacion de fe ==--
open    cursor_clas_fe_soin_ing;
loop
fetch    cursor_clas_fe_soin_ing
into    v_cla_fe_id, v_politica_soin_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin;
exit when not found; /* apply on cursor_clas_fe_soin_ing */
--== clasificaci.n de cuentas contables erp ==--
update    fecxp_ingresos_caratula_d_tmp
set        cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POL?TICAS'
where (e_codigo >= coalesce(v_e_codigo_ini, 0)) --para homologar con detalle soin
and (e_codigo <= coalesce(v_e_codigo_fin, 9999))  --para homologar con detalle soin
and (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (ora_soin_segmento1 >= coalesce(v_ctam01_ini, '0'))
and (ora_soin_segmento1 <= coalesce(v_ctam01_fin, 'z'))
and (ora_soin_segmento2 >= coalesce(v_ctam02_ini, '0'))
and (ora_soin_segmento2 <= coalesce(v_ctam02_fin, 'z'))
and (ora_soin_segmento3 >= coalesce(v_ctam03_ini, '0'))
and (ora_soin_segmento3 <= coalesce(v_ctam03_fin, 'z'))
and        e_codigo = coalesce(v_e_codigo, e_codigo)
and        coalesce(cla_fe_id, '|') = '|'
and        cual_erp = 'S';
end loop;
close cursor_clas_fe_soin_ing;
--26/08/2011
--aperturacion de iva y otros
begin
call fecxc.fecxp_base_iva_inter_caratula (v_mes_desde,v_periodo);
end;
perform dbms_output.put_line('si paso esta madre');
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    t.e_codigo, e.des_empresa, v_id_sesion, (to_char(t.fecha, 'YYYY'))::numeric  periodo, (to_char(t.fecha, 'MM'))::numeric  mes, t.moneda, m.tipo_cambio, t.cla_fe_id, cf.cla_fe_des, sum(t.importe_linea * (cf.cla_atributo3::numeric)::numeric ), 'CH'
from    fecxp_clasificacion_fe cf,
fecxp_ingresos_caratula_d_tmp t,
fecxc_empresas e,
fecxp_monedas m
where    e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and        t.e_codigo = e.e_codigo
and        t.cla_fe_id = cf.cla_fe_id
and        m.mon_oracle = t.moneda
and        m.periodo = (to_char(t.fecha, 'YYYY'))::numeric
and        m.mes = (to_char(t.fecha, 'MM'))::numeric
group by t.e_codigo, e.des_empresa, (to_char(t.fecha, 'YYYY'))::numeric , (to_char(t.fecha, 'MM'))::numeric , t.moneda, m.tipo_cambio, t.cla_fe_id, cf.cla_fe_des;/* dmap converted statement start */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- egresos
------------------------------------------------------------------------------------------------
--== cargamos las cuentas contables que generaron movimiento durante el mes  ==--
insert    into fecxc.fecxp_ctas_erp_caratula_tmp(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select    distinct '|' as cla_fe_id,
d.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7
from    fecxc.fecxp_enc_pagos_erp e,
fecxc.fecxp_det_pagos_procesados d
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp;/* dmap converted statement end *//* dmap converted statement start */
insert    into fecxc.fecxp_ctas_soin_caratula2_tmp(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select    distinct '|' as cla_fe_id,
e.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.ctam01, d.ctam02, d.ctam03, 0, 0, '0', '0'
from    fecxc.fecxp_enc_pagos_soin e,
fecxc.fecxp_det_pagos_soin d
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_soin = d.secuencia_pagos_soin;/* dmap converted statement end */
update    fecxc.fecxp_ctas_soin_caratula2_tmp c1
set        division =
(
select    c2.cg13di
from    fecxc.fecxp_cat_cuentas_soin c2
where      c1.ctam01 = c2.ctam01
and        c1.ctam02 = c2.ctam02
and        c1.ctam03 = c2.ctam03
),
rubro =
(
select    c2.cg13ru
from    fecxc.fecxp_cat_cuentas_soin c2
where      c1.ctam01 = c2.ctam01
and        c1.ctam02 = c2.ctam02
and        c1.ctam03 = c2.ctam03
)
where    exists (
select    c2.cg13ru
from    fecxc.fecxp_cat_cuentas_soin c2
where    c1.ctam01 = c2.ctam01
and        c1.ctam02 = c2.ctam02
and        c1.ctam03 = c2.ctam03
)
and        c1.e_codigo  = coalesce(v_e_codigo, c1.e_codigo);
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open    cursor_clas_fe_oracle_egr;
loop
fetch    cursor_clas_fe_oracle_egr
into    v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clas_fe_oracle_egr */
--== clasificaci.n de cuentas contables erp ==--
update    fecxc.fecxp_ctas_erp_caratula_tmp
set        cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (oracle_segmento1 >= coalesce(v_ora_s1_ini, '0'))
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
and        coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clas_fe_oracle_egr;
--== clasificacion flujo de efectivo para soin ==--
open    cursor_clas_fe_soin_egr;
loop
fetch    cursor_clas_fe_soin_egr
into    v_cla_fe_id, v_politica_soin_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clas_fe_soin_egr */
--== se clasifican las cuentas de soin ==--
update    fecxc.fecxp_ctas_soin_caratula2_tmp
set        cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (e_codigo >= coalesce(v_e_codigo_ini, 0))
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
and        e_codigo = coalesce(v_e_codigo, e_codigo)
and        coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clas_fe_soin_egr;/* dmap converted statement start */
--==  inicia la inclusi.n de informaci.n del erp ==--
insert    into fecxp_erp_caratula_tmp(
e_codigo, des_empresa, periodo, mes,
mon_oracle, tipo_cambio, importe, oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, tipo_operacion, id_banco, id_chequera)
select    pe.e_codigo, e.des_empresa, (to_char(pe.fecha_aplicacion,'YYYY')) as periodo, (to_char(pe.fecha_aplicacion,'MM')) as mes,
m.mon_oracle, m.tipo_cambio,  (pp.importe_linea) importe, pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3,
pp.oracle_segmento4, pp.oracle_segmento5, pp.oracle_segmento6, pp.oracle_segmento7, pe.tipo_operacion, pe.id_banco, pe.id_chequera
from    fecxc.fecxp_enc_pagos_erp pe,
fecxc.fecxp_det_pagos_procesados pp,
fecxc_empresas e,
fecxp_monedas m
where    pe.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     pe.e_codigo = coalesce(v_e_codigo, pe.e_codigo)
and        m.mes = (to_char(pe.fecha_aplicacion,'MM'))::numeric
and        m.periodo = (to_char(pe.fecha_aplicacion,'YYYY'))::numeric
and        m.mon_set = pe.moneda
and        e.e_codigo = pe.e_codigo
and        pe.secuencia_pagos_erp = pp.secuencia_pagos_erp
and        pe.e_codigo     = pp.e_codigo;/* dmap converted statement end */
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea,tipo_caratula)
select    a.e_codigo, a.des_empresa,  v_id_sesion, a.periodo, a.mes, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(a.importe * (b.cla_atributo3::numeric)::numeric ), 'CH'
from    fecxp_erp_caratula_tmp a,
(
select    c.e_codigo, c.tipo_operacion, c.id_banco, c.id_chequera, b.cla_fe_id, b.cla_fe_des, b.cla_atributo3, c.oracle_segmento1, c.oracle_segmento2, c.oracle_segmento3, c.oracle_segmento4, c.oracle_segmento5, c.oracle_segmento6, c.oracle_segmento7
from    fecxp_clasificacion_fe b,
fecxc.fecxp_ctas_erp_caratula_tmp c
where    b.cla_fe_id = c.cla_fe_id
) b
where    a.e_codigo = b.e_codigo
and        a.tipo_operacion = b.tipo_operacion
and        a.id_banco = b.id_banco
and        a.id_chequera = b.id_chequera
and        a.oracle_segmento1 = b.oracle_segmento1
and        a.oracle_segmento2 = b.oracle_segmento2
and        a.oracle_segmento3 = b.oracle_segmento3
and        a.oracle_segmento4 = b.oracle_segmento4
and        a.oracle_segmento5 = b.oracle_segmento5
and        a.oracle_segmento6 = b.oracle_segmento6
and        a.oracle_segmento7 = b.oracle_segmento7
and        a.e_codigo = coalesce(v_e_codigo, a.e_codigo)
group by a.e_codigo, a.des_empresa,  a.periodo, a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;/* dmap converted statement start */
--==  termina la inclusi.n de registros car?tula erp  ==--
--==  inicia la inclusi.n de registros car?tula soin  ==--
insert    into fecxp_soin_caratula_tmp(
e_codigo, des_empresa, periodo, mes,
mon_oracle, tipo_cambio, importe, ctam01, ctam02, ctam03, tipo_operacion, id_banco, id_chequera)
select    ep.e_codigo, e.des_empresa, (to_char(ep.fecha_aplicacion,'YYYY')) as periodo, (to_char(ep.fecha_aplicacion,'MM')) as mes,
m.mon_oracle, m.tipo_cambio, ps.importe_linea  as importe, ps.ctam01, ps.ctam02, ps.ctam03, ep.tipo_operacion, ep.id_banco, ep.id_chequera
from    fecxc.fecxp_enc_pagos_soin ep,
fecxc.fecxp_det_pagos_soin ps,
fecxc_empresas e,
fecxp_monedas m
where    ep.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     m.mes = (to_char(ep.fecha_aplicacion, 'MM'))::numeric
and        m.periodo = (to_char(ep.fecha_aplicacion, 'YYYY'))::numeric
and        m.mon_set = ep.moneda
and        e.e_codigo = ep.e_codigo
and        ep.secuencia_pagos_soin = ps.secuencia_pagos_soin
and        ep.e_codigo    = ps.e_codigo
and        e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and        ps.ctam01 <> '000';/* dmap converted statement end */
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    a.e_codigo, a.des_empresa, v_id_sesion,  a.periodo,  a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(importe*b.cla_atributo3), 'CH'
from    fecxp_soin_caratula_tmp a,
(
select    c.e_codigo, c.tipo_operacion, c.id_banco, c.id_chequera, b.cla_fe_id, b.cla_atributo3,b.cla_fe_des,  c.ctam01, c.ctam02, c.ctam03
from    fecxp_clasificacion_fe b, fecxc.fecxp_ctas_soin_caratula2_tmp c
where    b.cla_fe_id = c.cla_fe_id
) b
where    a.e_codigo = b.e_codigo
and        a.tipo_operacion = b.tipo_operacion
and        a.id_banco = b.id_banco
and        a.id_chequera = b.id_chequera
and        a.ctam01 = b.ctam01
and        a.ctam02  = b.ctam02
and        a.ctam03  = b.ctam03
and        a.e_codigo = coalesce(v_e_codigo, a.e_codigo)
group by a.e_codigo, a.des_empresa, 1,  a.periodo,  a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;/* dmap converted statement start */
--==  termina la inclusi.n de registros car?tula soin  ==--
--==  inicia la inclusi.n de registros importados ==--
---v4 importados
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus, tipo_caratula)
select    e.e_codigo, e.des_empresa, v_id_sesion, (to_char(d.fecha, 'YYYY'))::numeric , d.mes, d.moneda_imp, m.tipo_cambio,
c.cla_fe_id, c.cla_fe_des, (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO',
case when c.cla_fe_id in ('SI COIN','SF COIN','INGCOIN','EGRCOIN') then 'CO'
when c.cla_fe_id in ('SI INV','SF INV','INGINV','EGRINV') then 'IN'
else 'CH'
end tipo_caratula
from    fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where    d.estatus_origen = 'IMPORTADO'
and        e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and        to_date( concat(to_char(d.fecha, 'YYYY'), lpad(d.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     d.tipo_importacion in ('R', 'S')
and        e.e_codigo = d.e_empresa_imp
and        m.mon_oracle = d.moneda_imp
and        m.mes = d.mes
and        m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and        c.cla_fe_id = d.cla_fe_id_imp;/* dmap converted statement end */
--== c?lcula saldos finales ==--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--== c?lcula e inserta saldos ==--
loop
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF', 'SALDO FINAL', sum(c.importe_linea), 'CH'
from    fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo_act
and        c.mes = v_mes_act
and        cf.genera_saldo = 1
and        cf.cla_fe_id = c.cla_fe_id
and        c.tipo_caratula = 'CH'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea,tipo_caratula )
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea, c.tipo_caratula
from    fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        periodo = v_periodo_act
and        mes = v_mes_act
and        cla_fe_id = 'SF'
and        tipo_caratula='CH';
exit when v_mes_act >= 12;
v_mes_act:= v_mes_act + 1;
end loop;/* dmap converted statement start */
-- calcula saldo sf2
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF2', 'POSICION CON FACULTAD DECISION', sum(c.importe_linea), 'CALCULADO' estatus, 'CH'
from (
select    c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des, sum(c.importe_linea) importe_linea
from    fecxp_real_caratula c
where    c.cla_fe_id = 'SF'
and     c.tipo_caratula='CH'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des
union all
select    c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des, sum(c.importe_linea) importe_linea
from    fecxp_real_caratula c,
fecxp_clasificacion_fe cf
where    cf.genera_saldo = 0
and        cf.cla_fe_id not in ('ING02', 'EGR02')
and        c.cla_fe_id = cf.cla_fe_id
and        c.tipo_caratula ='CH'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des
) c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        to_date( concat(to_char(c.periodo), lpad(c.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- caratula de coinversi?n
------------------------------------------------------------------------------------------------
--se construye una car?tula desde el punto de vista de la coinversi?n
--los registros se integran a la tabla de car?tula identific?ndolas como de coinversi?n
delete from fecxp_movs_coinversion
where    e_codigo = coalesce(v_e_codigo, e_codigo)
and        to_date( concat(to_char(periodo), lpad(mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
;/* dmap converted statement end */
--== mete el saldo inicial ==--
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI COIN', 'SDO INICIAL COINVERSION', c.importe_linea, c.tipo_caratula
from    fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo
and        c.mes = v_mes_desde - 1
and        v_mes_desde <> 1
and        c.cla_fe_id = 'SF COIN'
and        c.tipo_caratula = 'CO';
/* commit; */
--obtener los egresos de coinversi?n y darles clave de flujo, se abre por detalle de pago
v_contador_reg:=0;
for i in cursor_movtos_coinversion_egr  loop
insert  into fecxp_movs_coinversion(cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda,
importe,importe_linea,id_tipo_movto, des_empresa,id_status_mov, periodo, mes,tipo_cambio, cla_fe_des,
cla_atributo1, cla_atributo2, cla_atributo3)
values (i.cla_fe_id   ,   i.no_cuenta,     i.folio_set,i.secuencia_pagos_erp, i.tipo_operacion, i.fecha_aplicacion,  i.mon_oracle,
i.importe,i.importe_linea,'E',i.des_empresa, i.estatus_movimiento,i.periodo, i.mes,i.tipo_cambio,i.cla_fe_des,
i.cla_atributo1, i.cla_atributo2, i.cla_atributo3);
v_contador_reg:=v_contador_reg+1;
if v_contador_reg = 30 then
/* commit; */
v_contador_reg:=0;
end if;
end loop;
/* commit; */
-- se obtienen los ingresos por barrido e inversiones (3705, 7000)   y se da su clave de flujo
v_contador_reg:=0;
for con in cursor_movtos_coinversion_ing  loop
insert  into fecxp_movs_coinversion(cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda,
importe,importe_linea,id_tipo_movto,des_empresa, id_status_mov,periodo, mes,tipo_cambio, cla_fe_des,
cla_atributo1, cla_atributo2, cla_atributo3)
values (con.cla_fe_id,  con.no_cuenta, con.no_folio_det, con.secuencia_dep_especiales, con.id_tipo_operacion_set, con.fec_valor, con.mon_oracle, con.importe,
con.importe_linea,'I', con.des_empresa, con.id_status_mov,con.periodo, con.mes,con.tipo_cambio, con.cla_fe_des,
con.cla_atributo1, con.cla_atributo2, con.cla_atributo3);
v_contador_reg:=v_contador_reg+1;
if v_contador_reg = 30 then
/* commit; */
v_contador_reg:=0;
end if;
end loop;/* dmap converted statement start */
/* commit; */
--  los detalles clasificados tienen que sumarizarse para entrar a la car?tula
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select a.e_codigo, a.des_empresa,  v_id_sesion, a.periodo, a.mes, a.moneda, a.tipo_cambio,
a.cla_fe_id,a.cla_fe_des, sum(a.importe_linea * (a.cla_atributo3::numeric)::numeric ) ,'CO'
from fecxp_movs_coinversion a
where to_date( concat(to_char(a.periodo), lpad(a.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
group by a.e_codigo, a.des_empresa,  a.periodo, a.mes,a.moneda, a.tipo_cambio, a.cla_fe_id, a.cla_fe_des;/* dmap converted statement end */
/*
--al generar los saldos se tienen que crear los correspondientes a la empresa 999 (total de todas)
insert into fecxp_real_caratula (
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select 999, 'TELEVISA COINVERSION',  v_id_sesion, a.periodo, a.mes, a.moneda, a.tipo_cambio,
a.cla_fe_id,a.cla_fe_des, sum (a.importe_linea * to_number (a.cla_atributo3)) ,'CO'
from fecxp_movs_coinversion a
group by a.periodo, a.mes,a.moneda, a.tipo_cambio, a.cla_fe_id, a.cla_fe_des;*/
--realizar el c?lculo de los saldos finales de coinversi?n
v_mes_act:= (v_mes_desde)::numeric;
loop
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF COIN', 'SDO FINAL COINVERSION', sum(c.importe_linea),'CO'
from    fecxp_real_caratula c
where    c.tipo_caratula = 'CO'
and         c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo_act
and        c.mes = v_mes_act
and        c.cla_fe_id <> 'SF COIN'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI COIN', 'SDO INICIAL COINVERSION', c.importe_linea, 'CO'
from    fecxp_real_caratula c
where    c.tipo_caratula = 'CO'
and        c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        periodo = v_periodo_act
and        mes = v_mes_act
and        cla_fe_id = 'SF COIN';
exit when v_mes_act >= 12;
v_mes_act:= v_mes_act + 1;
end loop;/* dmap converted statement start */
/* commit; */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- caratula de inversi?n
------------------------------------------------------------------------------------------------
--se construye una car?tula desde el punto de vista de la inversi?n, esto es tiene una interpretaci?n opuesta a la chequera
--los registros se integran a la tabla de car?tula identific?ndolas como de inversi?n
delete from fecxp_movs_inversion
where    e_codigo = coalesce(v_e_codigo, e_codigo)
and        to_date( concat(to_char(periodo), lpad(mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
;/* dmap converted statement end */
--== mete el saldo inicial ==--
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI INV', 'SDO INICIAL INVERSION', c.importe_linea, c.tipo_caratula
from    fecxp_real_caratula c
where    c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo
and        c.mes = v_mes_desde - 1
and        v_mes_desde <> 1
and        c.cla_fe_id = 'SF INV'
and        c.tipo_caratula = 'IN';/* dmap converted statement start */
--1obtener los ingresos de inversi?n y darles clave de flujo, se abre por detalle de pago
--1.1 obtener inversiones oracle y regrso de isr
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa,id_status_mov, periodo, mes,tipo_cambio, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3)
select  p.cla_fe_id,e.e_codigo, e.folio_set,e.secuencia_pagos_erp, e.tipo_operacion, e.fecha_aplicacion,  m.mon_oracle, e.importe,
d.importe_linea,'I',c.des_empresa, e.estatus_movimiento,(to_char(e.fecha_aplicacion,'YYYY')), (to_char(e.fecha_aplicacion,'MM')),m.tipo_cambio,p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from    fecxc.fecxp_enc_pagos_erp e,
fecxc.fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.tipo_operacion in (4001,4104)
and        d.secuencia_pagos_erp = e.secuencia_pagos_erp
and        d.e_codigo= e.e_codigo
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'I'
and        p.tipo_clave = 'IN'
and     c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        not exists (
select    1
from    fecxp_movs_inversion i
where    e.folio_set = i.folio_set
and    e.estatus_movimiento = i.id_status_mov --para cancelados
and i.id_tipo_movto='I'
);/* dmap converted statement end *//* dmap converted statement start */
--1.2 obtener inversiones soin y regreso de isr
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa,id_status_mov, periodo, mes,tipo_cambio, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3)
select  p.cla_fe_id,e.e_codigo, e.folio_set,e.secuencia_pagos_soin, e.tipo_operacion, e.fecha_aplicacion,  m.mon_oracle, e.importe,
d.importe_linea,'I',c.des_empresa, e.estatus_movimiento,(to_char(e.fecha_aplicacion,'YYYY')), (to_char(e.fecha_aplicacion,'MM')),m.tipo_cambio,p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from    fecxc.fecxp_enc_pagos_soin e,
fecxc.fecxp_det_pagos_soin d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.tipo_operacion in (4001,4104)
and        d.secuencia_pagos_soin = e.secuencia_pagos_soin
and        d.e_codigo= e.e_codigo
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'I'
and        p.tipo_clave = 'IN'
and     c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        not exists (
select    1
from    fecxp_movs_inversion i
where    e.folio_set = i.folio_set
and    e.estatus_movimiento = i.id_status_mov
and i.id_tipo_movto = 'I' --para cancelados
);/* dmap converted statement end *//* dmap converted statement start */
---1.3 obtener la 4103  como ingreso
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa, id_status_mov,periodo, mes,tipo_cambio, cla_fe_des,cla_atributo1, cla_atributo2, cla_atributo3)
select    p.cla_fe_id,  e.no_empresa, e.no_folio_det, e.secuencia_dep_especiales, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.importe,
coalesce(d.importe_linea, e.importe) importe_linea,'I', c.des_empresa, e.id_status_mov,(to_char(e.fec_valor,'YYYY')), (to_char(e.fec_valor,'MM')),m.tipo_cambio, p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc.fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD') and e.id_tipo_operacion_set =4103  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'IN' and c.e_codigo = e.no_empresa and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select    1
from    fecxp_movs_inversion i
where    e.no_folio_det = i.folio_set
and    e.id_status_mov = i.id_status_mov
and i.id_tipo_movto='I' --para cancelados
);/* dmap converted statement end *//* dmap converted statement start */
----obtener los egresos de la inversi?n
--- 2.1 obtener el regreso de inversi?n 4102 y el inter?s ganado
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa, id_status_mov,periodo, mes,tipo_cambio, cla_fe_des,cla_atributo1, cla_atributo2, cla_atributo3)
select    p.cla_fe_id,  e.no_empresa, e.no_folio_det, e.secuencia_dep_especiales, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.importe,
coalesce(d.importe_linea, e.importe) importe_linea,'E', c.des_empresa, e.id_status_mov,(to_char(e.fec_valor,'YYYY')), (to_char(e.fec_valor,'MM')),m.tipo_cambio, p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc.fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD') and e.id_tipo_operacion_set in (4102,4103)  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'E' and p.tipo_clave = 'IN' and c.e_codigo = e.no_empresa and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select    1
from    fecxp_movs_inversion i
where    e.no_folio_det = i.folio_set
and    e.id_status_mov = i.id_status_mov
and i.id_tipo_movto='E' --para cancelados
);/* dmap converted statement end *//* dmap converted statement start */
--2.2 obtener el isr oracle como egreso
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa,id_status_mov, periodo, mes,tipo_cambio, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3)
select  p.cla_fe_id,e.e_codigo, e.folio_set,e.secuencia_pagos_erp, e.tipo_operacion, e.fecha_aplicacion,  m.mon_oracle, e.importe,
d.importe_linea,'E',c.des_empresa, e.estatus_movimiento,(to_char(e.fecha_aplicacion,'YYYY')), (to_char(e.fecha_aplicacion,'MM')),m.tipo_cambio,p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from    fecxc.fecxp_enc_pagos_erp e,
fecxc.fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.tipo_operacion =4104
and        d.secuencia_pagos_erp = e.secuencia_pagos_erp
and        d.e_codigo= e.e_codigo
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'E'
and        p.tipo_clave = 'IN'
and     c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        not exists (
select    1
from    fecxp_movs_inversion i
where    e.folio_set = i.folio_set
and    e.estatus_movimiento = i.id_status_mov --para cancelados
and i.id_tipo_movto='E'
);/* dmap converted statement end *//* dmap converted statement start */
--2.2 obtener el isr soin como egreso
insert    into fecxp_movs_inversion(
cla_fe_id, e_codigo, folio_set, secuencia_id, tipo_operacion, fecha, moneda, importe,importe_linea,id_tipo_movto,
des_empresa,id_status_mov, periodo, mes,tipo_cambio, cla_fe_des, cla_atributo1, cla_atributo2, cla_atributo3)
select  p.cla_fe_id,e.e_codigo, e.folio_set,e.secuencia_pagos_soin, e.tipo_operacion, e.fecha_aplicacion,  m.mon_oracle, e.importe,
d.importe_linea,'E',c.des_empresa, e.estatus_movimiento,(to_char(e.fecha_aplicacion,'YYYY')), (to_char(e.fecha_aplicacion,'MM')),m.tipo_cambio,p.cla_fe_des,
p.cla_atributo1, p.cla_atributo2, p.cla_atributo3
from    fecxc.fecxp_enc_pagos_soin e,
fecxc.fecxp_det_pagos_soin d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.fecha_aplicacion >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and     e.tipo_operacion =4104
and        d.secuencia_pagos_soin = e.secuencia_pagos_soin
and        d.e_codigo= e.e_codigo
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'E'
and        p.tipo_clave = 'IN'
and     c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        not exists (
select    1
from    fecxp_movs_inversion i
where    e.folio_set = i.folio_set
and    e.estatus_movimiento = i.id_status_mov --para cancelados
and i.id_tipo_movto='E'
);/* dmap converted statement end *//* dmap converted statement start */
--  los detalles clasificados tienen que sumarizarse para entrar a la car?tula
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select a.e_codigo, a.des_empresa,  v_id_sesion, a.periodo, a.mes, a.moneda, a.tipo_cambio,
a.cla_fe_id,a.cla_fe_des, sum(a.importe_linea * (a.cla_atributo3::numeric)::numeric ) ,'IN'
from fecxp_movs_inversion a
where to_date( concat(to_char(a.periodo), lpad(a.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
group by a.e_codigo, a.des_empresa,  a.periodo, a.mes,a.moneda, a.tipo_cambio, a.cla_fe_id, a.cla_fe_des;/* dmap converted statement end */
--realizar el c?lculo de los saldos finales de coinversi?n
v_mes_act:= (v_mes_desde)::numeric;
loop
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF INV', 'SDO FINAL INVERSION', sum(c.importe_linea),'IN'
from    fecxp_real_caratula c
where    c.tipo_caratula = 'IN'
and         c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        c.periodo = v_periodo_act
and        c.mes = v_mes_act
and        c.cla_fe_id <> 'SF INV'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert    into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select    c.e_codigo, c.des_empresa, c.id_sesion_rc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI INV', 'SDO INICIAL INVERSION', c.importe_linea, 'IN'
from    fecxp_real_caratula c
where    c.tipo_caratula = 'IN'
and        c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and        periodo = v_periodo_act
and        mes = v_mes_act
and        cla_fe_id = 'SF INV';
exit when v_mes_act >= 12;
v_mes_act:= v_mes_act + 1;
end loop;
/* commit; */
update fecxc.fecxp_bitacora_procesamiento
set estatus_terminado='EXITOSO'
where id_ejecucion=v_id_ejecucion;
/* commit; */
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
