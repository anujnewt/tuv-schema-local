create or replace procedure fecxc."fecxc_llena_reportes_p"  ( p_anio numeric, p_mes numeric, p_fecha timestamp(0), p_tipo numeric, p_inpc numeric, p_formato numeric, p_mensualizado numeric, p_segmentosesp numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_monloc             varchar(2);
v_inpc                  decimal(20,11);
v_inpc2                  decimal(20,11);
tcp_actualizado         decimal(20,11);
tcp_actualizado_dos         decimal(20,11);
no_hubo_inpc       exception;
tipo_reporte_inpc varchar(50);
t_count                 numeric;
t_countdos              numeric;
t_cobranzames_act       numeric;
t_cobranzames_act_dos   numeric;
t_min                   numeric;
t_min_dos               numeric;
/*
// modificaci?n: p_inpc recibir? el valor 2 para los reportes con valores nominales y reales, se agregar?n columnas para valores noinales/reales.
// se hace modificaci?n para reporte de tvlocal, intermex y canales
// fecha:29-mayo-2008
// oscar reyes orm
*/
begin 

if p_inpc = 1 then
tipo_reporte_inpc := 'CIF.ACTUALIZADAS';
select inpc_actual
into strict v_inpc
from fecxc_inpc
where ano_inpc = p_anio
and mes_inpc = p_mes;
elsif p_inpc = 0 then
tipo_reporte_inpc := 'CIFRAS NOMINALES';
v_inpc := 1;
else
/*orm incluye ambas opciones se calcular? la cifra nominal y la real */
tipo_reporte_inpc := 'CIF.ACT. Y NOM.';
/*para el tipo 1 las cifras actuales se calcular?n nominales y las que se adicionan como reales*/
if p_tipo = 1 then
v_inpc := 1;
select inpc_actual
into strict v_inpc2
from fecxc_inpc
where ano_inpc = p_anio
and mes_inpc = p_mes;
else
/*para el tipo 2  y 3 se calcular?n cifras reales y se adicionan las nominales*/
select inpc_actual
into strict v_inpc
from fecxc_inpc
where ano_inpc = p_anio
and mes_inpc = p_mes;
v_inpc2 := 1;
end if;
end if;/* dmap converted statement start */
if p_mensualizado = 0 then
tipo_reporte_inpc :=  concat(tipo_reporte_inpc, '-MENSUALIZADO') ;/* dmap converted statement end *//* dmap converted statement start */
else
tipo_reporte_inpc :=  concat(tipo_reporte_inpc, '-A LA FECHA') ;/* dmap converted statement end */
end if;
if p_tipo = 1  then
/***************************************************************************************************************************
l l e n a d o   d e   e s t r u c t u r a   p a r a   t v   l o c a l
***************************************************************************************************************************/
delete from fecxc_cobranza_deldia;
delete from fecxc_cobranza_delmes;
delete from fecxc_cobranza_alafecha;
delete from fecxc_presup_delmes;
delete from fecxc_cobranza_anterior;
delete from fecxc_presup_alafecha;
delete from fecxc_parametros_tvlocal;
insert into fecxc_parametros_tvlocal(anio,mes,fecha,actualizado)
values (p_anio,p_mes,p_fecha,tipo_reporte_inpc);
/*llena cobranza del dia */
insert into fecxc_cobranza_deldia(e_codigo, segmento,codmoneda, cobranza_dia)
select a.e_codigo, b.segmento1,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_dia
from fecxc_calendario_cob d, fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and a.f_deposito = p_fecha                  ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena cobranza del mes */
if p_mensualizado = 0 then           /* mensualizado... */
insert into fecxc_cobranza_delmes(
e_codigo, segmento,
codmoneda, cobranza_mes)
select a.e_codigo, b.segmento1,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio              --parametro de a?o
and d.mes_cobranza = p_mes              --parametro de mes
and a.f_deposito <= p_fecha   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena cobranza del a la fecha */
insert into fecxc_cobranza_alafecha(e_codigo, segmento,codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo,b.segmento1,c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_alafecha, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_alafecha
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza <= p_mes and a.f_deposito <= p_fecha   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena cobranza anterior mismo dia */
insert into fecxc_cobranza_anterior(e_codigo, segmento,codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1,c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_anterior, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_anterior
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio -1                     --parametro de a?o
and d.mes_cobranza <= p_mes                         --parametro de mes
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena presupuesto del mes */
insert into fecxc_presup_delmes(
segmento, codmoneda, presup_mes, presupreal_mes)
select b.segmento1, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_mes,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                       --parametro de mes
group by b.segmento1, c.codmoneda;
/*llena presupuesto del alafecha */
insert into fecxc_presup_alafecha(
segmento, codmoneda, presup_alafecha, presupreal_alafecha)
select b.segmento1, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_alafecha,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_alafecha
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza <= p_mes                   --parametro del mes
group by b.segmento1, c.codmoneda;
else      /* a una fecha dada */
insert into fecxc_cobranza_delmes(e_codigo, segmento,codmoneda, cobranza_mes)
select a.e_codigo, b.segmento1,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio              --parametro de a?o
and d.mes_cobranza = p_mes              --parametro de mes
and a.f_deposito <= p_fecha and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena cobranza del a la fecha */
insert into fecxc_cobranza_alafecha(
e_codigo, segmento,
codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo, b.segmento1,
c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_alafecha, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_alafecha
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and a.f_deposito <= p_fecha                 ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena cobranza anterior mismo dia */
insert into fecxc_cobranza_anterior(
e_codigo, segmento,
codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1,
c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_anterior, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_anterior
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio -1                     --parametro de a?o
and a.f_deposito <= to_timestamp(p_fecha) - interval '365 day'                  ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda;
/*llena presupuesto del mes */
insert into fecxc_presup_delmes(
segmento, codmoneda, presup_mes, presupreal_mes)
select b.segmento1, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_mes,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                       --parametro de mes
and b.diario <= p_fecha   group by b.segmento1, c.codmoneda;
/*llena presupuesto del alafecha */
insert into fecxc_presup_alafecha(
segmento, codmoneda, presup_alafecha,presupreal_alafecha)
select b.segmento1, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_alafecha,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_alafecha
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and b.diario <= p_fecha   group by b.segmento1, c.codmoneda;
end if;      -- mensualizado
if p_segmentosesp = 1 then
update fecxc_cobranza_deldia up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_cobranza_delmes up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_cobranza_alafecha up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_cobranza_anterior up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
/*
update fecxc_cobranza_deldia up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_cobranza_delmes up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_cobranza_alafecha up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_cobranza_anterior up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
*/
insert into fecxc_cobranza_deldia_tmp(e_codigo, segmento, codmoneda, cobranza_dia)
select e_codigo, segmento, codmoneda, sum(cobranza_dia)
from fecxc_cobranza_deldia
group by e_codigo, segmento, codmoneda;
insert into fecxc_cobranza_delmes_tmp(e_codigo,segmento,codmoneda,cobranza_mes)
select e_codigo,segmento,codmoneda, sum(cobranza_mes)
from fecxc_cobranza_delmes
group by e_codigo,segmento,codmoneda;
insert into fecxc_cobranza_alafecha_tmp(e_codigo, segmento, codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select e_codigo, segmento, codmoneda, sum(cobranza_alafecha), sum(cobranzareal_alafecha)
from fecxc_cobranza_alafecha
group by e_codigo, segmento, codmoneda;
insert into fecxc_cobranza_anterior_tmp(e_codigo, segmento, codmoneda, cobranza_anterior, cobranzareal_anterior)
select e_codigo, segmento, codmoneda, sum(cobranza_anterior), sum(cobranzareal_anterior)
from fecxc_cobranza_anterior
group by e_codigo, segmento, codmoneda;
delete from fecxc_cobranza_deldia;
insert into fecxc_cobranza_deldia(e_codigo, segmento, codmoneda, cobranza_dia)
select e_codigo, segmento, codmoneda, cobranza_dia
from fecxc_cobranza_deldia_tmp;
delete from fecxc_cobranza_delmes;
insert into fecxc_cobranza_delmes(e_codigo,segmento,codmoneda,cobranza_mes)
select e_codigo,segmento,codmoneda,cobranza_mes
from fecxc_cobranza_delmes_tmp;
delete from fecxc_cobranza_alafecha;
insert into fecxc_cobranza_alafecha(e_codigo, segmento, codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select e_codigo, segmento, codmoneda, cobranza_alafecha, cobranzareal_alafecha
from fecxc_cobranza_alafecha_tmp;
delete from fecxc_cobranza_anterior;
insert into fecxc_cobranza_anterior(e_codigo, segmento, codmoneda, cobranza_anterior, cobranzareal_anterior)
select e_codigo, segmento, codmoneda, cobranza_anterior, cobranzareal_anterior
from fecxc_cobranza_anterior_tmp;
end if;
--  realiza la conversi?n de tipo de cambio dependiendo de su moneda inicial a dls. mn y dls se quedan tal cual.
/*
delete from fecxc_tipocambio_tmp;
insert into fecxc_tipocambio_tmp
select m.codmoneda, nvl(t.tipo_cambio_dls, 0)
from
fecxc_monedas m, fecxc_tpc t
where
m.secmoneda = t.secmoneda
and
t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_deldia_tmp;
insert into fecxc_cobranza_deldia_tmp
select c.e_codigo, c.segmento, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_dia / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_cobranza_deldia c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_deldia a
where exists(select b.e_codigo, b.segmento from fecxc_cobranza_deldia_tmp b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_cobranza_deldia
select e_codigo, segmento, codmoneda, cobranza_dia from fecxc_cobranza_deldia_tmp;
delete from fecxc_cobranza_delmes_tmp;
insert into fecxc_cobranza_delmes_tmp
select c.e_codigo, c.segmento, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_cobranza_delmes c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_delmes a
where exists(select b.e_codigo, b.segmento from fecxc_cobranza_delmes_tmp b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_cobranza_delmes
select e_codigo, segmento, codmoneda, cobranza_mes from fecxc_cobranza_delmes_tmp;
delete from fecxc_cobranza_alafecha_tmp;
insert into fecxc_cobranza_alafecha_tmp
select c.e_codigo, c.segmento, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_alafecha / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_alafecha / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_cobranza_alafecha c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_alafecha a
where exists(select b.e_codigo, b.segmento from fecxc_cobranza_alafecha_tmp b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_cobranza_alafecha
select e_codigo, segmento, codmoneda, cobranza_alafecha, cobranzareal_alafecha from fecxc_cobranza_alafecha_tmp;
delete from fecxc_cobranza_anterior_tmp;
insert into fecxc_cobranza_anterior_tmp
select c.e_codigo, c.segmento, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_anterior / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_anterior / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_cobranza_anterior c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_anterior a
where exists(select b.e_codigo, b.segmento from fecxc_cobranza_anterior_tmp b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_cobranza_anterior
select e_codigo, segmento, codmoneda, cobranza_anterior, cobranzareal_anterior from fecxc_cobranza_anterior_tmp;
update fecxc_cobranza_deldia d
set cobranza_dia = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_dia / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_deldia x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS'
where d.codmoneda not in ('MN','DLS');
update fecxc_cobranza_deldia set cobranza_dia = 0 where cobranza_dia is null;
update fecxc_cobranza_delmes d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_delmes x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS'
where d.codmoneda not in ('MN','DLS');
update fecxc_cobranza_delmes set cobranza_mes = 0 where cobranza_mes is null;
update fecxc_cobranza_alafecha d
set cobranza_alafecha = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_alafecha / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_alafecha x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS',
d.cobranzareal_alafecha = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranzareal_alafecha / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_alafecha x where x.e_codigo = d.e_codigo and x.segmento = d.segmento)
where d.codmoneda not in ('MN','DLS');
update fecxc_cobranza_alafecha set cobranza_alafecha = 0, cobranzareal_alafecha = 0 where cobranza_alafecha is null or cobranzareal_alafecha is null;
update fecxc_cobranza_anterior d
set cobranza_anterior = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_anterior / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_anterior x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS',
d.cobranzareal_anterior = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranzareal_anterior / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_cobranza_anterior x where x.e_codigo = d.e_codigo and x.segmento = d.segmento)
where d.codmoneda not in ('MN','DLS');
update fecxc_cobranza_anterior set cobranza_anterior = 0, cobranzareal_anterior = 0 where cobranza_anterior is null or cobranzareal_anterior is null;
*/
--     larg se ingresa codigo para cambiar el tipo de cambio de euros a dolares y el tipo de moneda de euros a dolares cuando la empresa sea 552 y el segmento 13
/*
select count(*)
into t_count
from fecxc_cobranza_deldia a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
if t_count>0 then
select nvl(cobranza_dia*tipo_cambio_dls,0)
into tcp_actualizado
from fecxc_cobranza_deldia a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
update fecxc_cobranza_deldia
set codmoneda='DLS',
cobranza_dia=tcp_actualizado
where e_codigo=552 and segmento=13 and codmoneda='EUR';
select count(*)
into t_countdos
from  fecxc_cobranza_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS';
if t_countdos>1 then
select sum(nvl(cobranza_dia,0))
into t_cobranzames_act
from  fecxc_cobranza_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranza_dia)
into t_min
from  fecxc_cobranza_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS';
delete from fecxc_cobranza_deldia
where cobranza_dia=t_min and e_codigo=552 and segmento=13 and codmoneda='DLS';
update fecxc_cobranza_deldia
set cobranza_dia=t_cobranzames_act
where e_codigo=552 and segmento=13 and codmoneda='DLS';
end if;
end if;
select count(*)
into t_count
from fecxc_cobranza_delmes a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
if t_count>0 then
select nvl(cobranza_mes*tipo_cambio_dls,0)
into tcp_actualizado
from fecxc_cobranza_delmes a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
update fecxc_cobranza_delmes
set  codmoneda='DLS',
cobranza_mes=tcp_actualizado
where e_codigo=552 and segmento=13 and codmoneda='EUR';
select count(*)
into t_countdos
from  fecxc_cobranza_delmes
where e_codigo=552 and segmento=13 and codmoneda='DLS';
if t_countdos>1 then
select sum(nvl(cobranza_mes,0))
into t_cobranzames_act
from  fecxc_cobranza_delmes
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranza_mes)
into t_min
from  fecxc_cobranza_delmes
where e_codigo=552 and segmento=13 and codmoneda='DLS';
delete from fecxc_cobranza_delmes
where cobranza_mes=t_min and e_codigo=552 and segmento=13 and codmoneda='DLS';
update fecxc_cobranza_delmes
set cobranza_mes=t_cobranzames_act
where e_codigo=552 and segmento=13 and codmoneda='DLS';
end if;
end if;
select count(*)
into t_count
from fecxc_cobranza_alafecha a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
if t_count>0 then
select nvl(cobranza_alafecha*tipo_cambio_dls,0),nvl(cobranzareal_alafecha*tipo_cambio_dls,0)
into tcp_actualizado,tcp_actualizado_dos
from fecxc_cobranza_alafecha a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
update fecxc_cobranza_alafecha
set  codmoneda='DLS',
cobranza_alafecha=tcp_actualizado,
cobranzareal_alafecha=tcp_actualizado_dos
where e_codigo=552 and segmento=13 and codmoneda='EUR';
select count(*)
into t_countdos
from  fecxc_cobranza_alafecha
where e_codigo=552 and segmento=13 and codmoneda='DLS';
if t_countdos>1 then
select sum(nvl(cobranza_alafecha,0))
into t_cobranzames_act
from  fecxc_cobranza_alafecha
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranza_alafecha)
into t_min
from  fecxc_cobranza_alafecha
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select sum(nvl(cobranzareal_alafecha,0))
into t_cobranzames_act_dos
from  fecxc_cobranza_alafecha
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranzareal_alafecha)
into t_min_dos
from  fecxc_cobranza_alafecha
where e_codigo=552 and segmento=13 and codmoneda='DLS';
delete from fecxc_cobranza_alafecha
where cobranza_alafecha=t_min and cobranzareal_alafecha=t_min_dos and e_codigo=552 and segmento=13 and codmoneda='DLS';
update fecxc_cobranza_alafecha
set cobranza_alafecha=t_cobranzames_act,
cobranzareal_alafecha=t_cobranzames_act_dos
where e_codigo=552 and segmento=13 and codmoneda='DLS';
end if;
end if;
select count(*)
into t_count
from fecxc_cobranza_anterior a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
if t_count>0 then
select nvl(cobranza_anterior*tipo_cambio_dls,0),nvl(cobranzareal_anterior*tipo_cambio_dls,0)
into tcp_actualizado,tcp_actualizado_dos
from fecxc_cobranza_anterior a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
update fecxc_cobranza_anterior
set  codmoneda='DLS',
cobranza_anterior=tcp_actualizado,
cobranzareal_anterior=tcp_actualizado_dos
where e_codigo=552 and segmento=13 and codmoneda='EUR';
select count(*)
into t_countdos
from  fecxc_cobranza_anterior
where e_codigo=552 and segmento=13 and codmoneda='DLS';
if t_countdos>1 then
select sum(nvl(cobranza_anterior,0))
into t_cobranzames_act
from  fecxc_cobranza_anterior
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranza_anterior)
into t_min
from  fecxc_cobranza_anterior
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select sum(nvl(cobranzareal_anterior,0))
into t_cobranzames_act_dos
from  fecxc_cobranza_anterior
where e_codigo=552 and segmento=13 and codmoneda='DLS';
select min(cobranzareal_anterior)
into t_min_dos
from  fecxc_cobranza_anterior
where e_codigo=552 and segmento=13 and codmoneda='DLS';
delete from fecxc_cobranza_anterior
where cobranza_anterior=t_min and cobranzareal_anterior=t_min_dos and e_codigo=552 and segmento=13 and codmoneda='DLS';
update fecxc_cobranza_anterior
set cobranza_anterior=t_cobranzames_act,
cobranzareal_anterior=t_cobranzames_act_dos
where e_codigo=552 and segmento=13 and codmoneda='DLS';
end if;
end if;
*/
end if;
if p_tipo = 2  then
/***************************************************************************************************************************
l l e n a d o   d e   e s t r u c t u r a   p a r a   c a n a l e s
***************************************************************************************************************************/
/*para este tipo de reporte cuando se elige que se muestren cifras nominales y reales*/
/*las cifras se calcular?n como reales y las agregadas ser?n nominales, las cifras nominales*/
/*quedar?n en campos con "real" en su nombre pero ser?n nominales, se debe a un cambio en la definici?n del requerimiento*/
/*los c?lculos de actualizaci?n o no decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc)*/
/*se modifican ya que se tomar? el inpc para inpc=1,2  y cuando es cero ser? nominal*/
delete from fecxc_cob_canal_deldia;
delete from fecxc_cob_canal_xmes;
delete from fecxc_cob_canal_anterior;
delete from fecxc_presup_canal_delmes;
delete from fecxc_parametros_canales;
insert into fecxc_parametros_canales(anio,mes,fecha,actualizado)
values (p_anio,p_mes,p_fecha,tipo_reporte_inpc);
insert into fecxc_cob_canal_deldia(
e_codigo, segmento,
codmoneda, mes,cobranza_dia)
select a.e_codigo, b.segmento1,
c.codmoneda, 0,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end))/p_formato cobranza_mes
from fecxc_calendario_cob d, fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and a.f_deposito = p_fecha                 ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, d.mes_cobranza, c.codmoneda;
if p_mensualizado = 0 then           /* mensualizado... */
/*se agrega columna para inpc=2*/
insert into fecxc_cob_canal_xmes(
e_codigo, segmento,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato cobranza_mes,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza <= p_mes   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda, d.mes_cobranza;
/* se agrega columna para inpc=2*/
insert into fecxc_cob_canal_anterior(
e_codigo, segmento,
codmoneda, mes,cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato cobranza_anterior,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end))/p_formato cobranzareal_anterior
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio -1                     --parametro de a?o
and d.mes_cobranza <= p_mes   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda, d.mes_cobranza;
/* se agrega columna adicional para ipc=2*/
insert into fecxc_presup_canal_delmes(
segmento, codmoneda, mes, presup_mes, presupreal_mes)
select b.segmento1, c.codmoneda, d.mes_cobranza, sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato presup_mes,
sum(b.importe)/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio and d.mes_cobranza <= p_mes   group by b.segmento1, c.codmoneda, d.mes_cobranza;
else
/* se agrega columna adicional para ipc=2*/
insert into fecxc_cob_canal_xmes(
e_codigo, segmento,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato cobranza_mes,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza <= p_mes   and a.f_deposito <= p_fecha and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda, d.mes_cobranza;
/* se agrega columna adicional para ipc=2*/
insert into fecxc_cob_canal_anterior(
e_codigo, segmento,
codmoneda, mes,cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato cobranza_anterior,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end))/p_formato cobranzareal_anterior
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio -1                     --parametro de a?o
and d.mes_cobranza <= p_mes   and a.f_deposito <= to_timestamp(p_fecha) - interval '365 day'                  ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1, c.codmoneda, d.mes_cobranza;
/* se agrega columna adicional para ipc=2*/
insert into fecxc_presup_canal_delmes(
segmento, codmoneda, mes, presup_mes, presupreal_mes)
select b.segmento1, c.codmoneda, d.mes_cobranza, sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato presup_mes,
sum(b.importe)/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio and d.mes_cobranza <= p_mes and b.diario <= p_fecha   group by b.segmento1, c.codmoneda, d.mes_cobranza;
end if;
if p_segmentosesp = 1 then
update fecxc_cob_canal_deldia up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists (select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin)
and exists (select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (nullif(c.es_moneda_loccal::text, '') is null
or c.es_moneda_loccal = 0));
update fecxc_cob_canal_xmes up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists (select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin)
and exists (select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (nullif(c.es_moneda_loccal::text, '') is null
or c.es_moneda_loccal = 0));
update fecxc_cob_canal_anterior up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists (select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin)
and exists (select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (nullif(c.es_moneda_loccal::text, '') is null
or c.es_moneda_loccal = 0));
insert into fecxc_cob_canal_deldia_tmp(e_codigo, segmento,codmoneda, mes,cobranza_dia)
select e_codigo, segmento,codmoneda, mes, sum(cobranza_dia)
from fecxc_cob_canal_deldia
group by e_codigo, segmento,codmoneda, mes;
insert into fecxc_cob_canal_xmes_tmp(e_codigo, segmento, codmoneda, mes, cobranza_mes, cobranzareal_mes)
select e_codigo, segmento, codmoneda, mes, sum(cobranza_mes), sum(cobranzareal_mes)
from fecxc_cob_canal_xmes
group by e_codigo, segmento, codmoneda, mes;
insert into fecxc_cob_canal_anterior_tmp(e_codigo, segmento, codmoneda, mes, cobranza_anterior, cobranzareal_anterior)
select e_codigo, segmento, codmoneda, mes, sum(cobranza_anterior), sum(cobranzareal_anterior)
from fecxc_cob_canal_anterior
group by e_codigo, segmento, codmoneda, mes;
delete from fecxc_cob_canal_deldia;
insert into fecxc_cob_canal_deldia(e_codigo, segmento,codmoneda, mes,cobranza_dia)
select e_codigo, segmento,codmoneda, mes,cobranza_dia
from fecxc_cob_canal_deldia_tmp;
delete from fecxc_cob_canal_xmes;
insert into fecxc_cob_canal_xmes(e_codigo, segmento, codmoneda, mes, cobranza_mes, cobranzareal_mes)
select e_codigo, segmento, codmoneda, mes, cobranza_mes, cobranzareal_mes
from fecxc_cob_canal_xmes_tmp;
delete from fecxc_cob_canal_anterior;
insert into fecxc_cob_canal_anterior(e_codigo, segmento, codmoneda, mes, cobranza_anterior, cobranzareal_anterior)
select e_codigo, segmento, codmoneda, mes, cobranza_anterior, cobranzareal_anterior
from fecxc_cob_canal_anterior_tmp;
end if;
end if;
if p_tipo = 3 then
/***************************************************************************************************************************
l l e n a d o   d e   e s t r u c t u r a   p a r a   i n t e r m e x
***************************************************************************************************************************/
delete from fecxc_caninter_deldia;
delete from fecxc_caninter_xmes_pre;
delete from fecxc_caninter_xmes_cob_act;
delete from fecxc_caninter_xmes_cob_ant;
delete from fecxc_caninter_alafecha_pre;
delete from fecxc_caninter_alafech_cob_act;
delete from fecxc_caninter_alafech_cob_ant;
delete from fecxc_parametros_intermex;
insert into fecxc_parametros_intermex(anio,mes,fecha,actualizado)
values (p_anio,p_mes,p_fecha,tipo_reporte_inpc);
/*para el caso en que el reporte debe presentar cifras reales y actualizadas, se agreg? una columna*/
/*que a pesar de tener la palabra real contendr? las cifras nominales */
/*y el resto se calcular? para cifras reales*/
----------------------desde aqui parte 'DEL DIA'--------------------------------------
insert into fecxc_caninter_deldia(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_dia)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, 0,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_dia
from fecxc_calendario_cob d, fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and a.f_deposito = p_fecha                 ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, d.mes_cobranza, c.codmoneda;
----------------------hasta aqui parte 'DEL DIA'--------------------------------------
----------------------desde aqui parte 'DEL MES'--------------------------------------
if p_mensualizado = 0 then           /* mensualizado... */
insert into fecxc_caninter_xmes_pre(
segmento, canal,codmoneda, mes, presup_mes)
select b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza, sum(b.importe)/p_formato
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio
and d.mes_cobranza = p_mes
group by b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
insert into fecxc_caninter_xmes_cob_act(e_codigo, segmento, canal,codmoneda, mes,cobranza_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes
from fecxc_calendario_cob d, fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                     --parametro de a?o
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega la columna de cobranzareal_mes*/
insert into fecxc_caninter_xmes_cob_ant(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio-1                     --parametro de a?o
and d.mes_cobranza = p_mes                     --parametro de a?o
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3,c.codmoneda, d.mes_cobranza;
----------------------desde aqui parte 'A LA FECHA'-----------------------------------
/*se agrega columna*/
insert into fecxc_caninter_alafecha_pre(
segmento, canal,codmoneda, mes, presup_mes, presupreal_mes)
select b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza, sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato presup_mes,
sum(b.importe)/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio and d.mes_cobranza <= p_mes   group by b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_alafech_cob_act(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and a.secmoneda in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza =p_anio                 ---parametro de a?o
and d.mes_cobranza <= p_mes   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_alafech_cob_ant(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_alafecha, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_alafecha
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio-1                     --parametro de a?o
and d.mes_cobranza <= p_mes   and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
----------------------hasta aqui parte 'A LA FECHA'--------------------------------------
else    /* a la fehca */
insert into fecxc_caninter_xmes_pre(
segmento, canal,codmoneda, mes, presup_mes)
select b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza, sum(b.importe)/p_formato
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio
and d.mes_cobranza = p_mes
and b.diario <= p_fecha
group by b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
insert into fecxc_caninter_xmes_cob_act(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes
from fecxc_calendario_cob d, fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                     --parametro de a?o
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    and a.f_deposito <= p_fecha group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_xmes_cob_ant(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio-1                     --parametro de a?o
and d.mes_cobranza = p_mes                     --parametro de a?o
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    and a.f_deposito <= (p_fecha)-365 group by a.e_codigo, b.segmento1,b.segmento3,c.codmoneda, d.mes_cobranza;
----------------------hasta aqui parte 'DEL MES'--------------------------------------
----------------------desde aqui parte 'A LA FECHA'-----------------------------------
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_alafecha_pre(
segmento, canal,codmoneda, mes, presup_mes, presupreal_mes)
select b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza, sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=0 then 1  else v_inpc/coalesce(e.inpc_actual,v_inpc) end   else 1 end )/p_formato presup_mes,
sum(b.importe)/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio and b.diario <= p_fecha                 ---parametro del dia
group by b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_alafech_cob_act(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza =p_anio                 ---parametro de a?o
and a.f_deposito <= p_fecha                 ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
/*se agrega columna para c?lculo nominal*/
insert into fecxc_caninter_alafech_cob_ant(
e_codigo, segmento, canal,
codmoneda, mes,cobranza_mes, cobranzareal_mes)
select a.e_codigo, b.segmento1,b.segmento3,
c.codmoneda, d.mes_cobranza,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda) * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranza_mes, sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then (select tipo_cambio_dls from fecxc_tpc where fecha_tpc = a.f_deposito and secmoneda = f.secmoneda)
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from ad_fecxc.fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
and to_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = f.secmoneda)
and conversion_date = a.f_deposito
)
else 1
end
end))/p_formato cobranzareal_mes
from fecxc_monedas c, fecxc_enc_clasificados a
left outer join fecxc_tpc e on (a.secmoneda = e.secmoneda and a.f_deposito = e.fecha_tpc)
, fecxc_det_clasificados b
left outer join fecxc_segmultimon f on (b.segmento1 = f.cod_sec_lin)
, fecxc_calendario_cob d
left outer join fecxc_tpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.e_codigo = b.e_codigo and a.cod_sec_clasifica = b.cod_sec_clasifica and a.secmoneda = c.secmoneda and a.f_deposito between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio-1                     --parametro de a?o
and a.f_deposito <= to_timestamp(p_fecha)-365                 ---parametro del dia
and exists (select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')    group by a.e_codigo, b.segmento1,b.segmento3, c.codmoneda, d.mes_cobranza;
----------------------hasta aqui parte 'A LA FECHA'--------------------------------------
end if;
if p_segmentosesp = 1 then
update fecxc_caninter_deldia up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_caninter_xmes_cob_act up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_caninter_xmes_cob_ant up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_caninter_alafech_cob_act up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
update fecxc_caninter_alafech_cob_ant up_table
set codmoneda = (select codmoneda from fecxc_monedas x, fecxc_segmultimon y where x.secmoneda = y.secmoneda and y.cod_sec_lin = up_table.segmento)
where nullif(segmento::text, '') is not null;
/*
update fecxc_caninter_deldia up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_caninter_xmes_cob_act up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_caninter_xmes_cob_ant up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_caninter_alafech_cob_act up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
update fecxc_caninter_alafech_cob_ant up_table
set codmoneda = (select min(codmoneda) from fecxc_monedas m where m.es_moneda_loccal = 1)
where exists(select 1
from fecxc_segmultimon b
where up_table.segmento = b.cod_sec_lin
and up_table.segmento in (1,2,3,9,4,5,6,7))
and exists(select 1
from fecxc_monedas c
where up_table.codmoneda = c.codmoneda
and (c.es_moneda_loccal is null
or c.es_moneda_loccal = 0));
*/
insert into fecxc_caninter_deldia_tmp(e_codigo,  segmento,  canal,  codmoneda,  mes, cobranza_dia)
select e_codigo,  segmento,  canal,  codmoneda,  mes, sum(cobranza_dia)
from fecxc_caninter_deldia
group by e_codigo,  segmento,  canal,  codmoneda,  mes;
insert into fecxc_caninter_xmes_cob_act_tm(e_codigo, segmento,  canal, codmoneda, mes, cobranza_mes)
select e_codigo, segmento,  canal, codmoneda, mes, sum(cobranza_mes)
from fecxc_caninter_xmes_cob_act
group by e_codigo, segmento,  canal, codmoneda, mes;
insert into fecxc_caninter_xmes_cob_ant_tm(e_codigo,  segmento,  canal, codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal, codmoneda,  mes,  sum(cobranza_mes), sum(cobranzareal_mes)
from fecxc_caninter_xmes_cob_ant
group by e_codigo,  segmento,  canal, codmoneda,  mes,  cobranza_mes;
insert into fecxc_caninter_alafech_cob_ac_(e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal,  codmoneda,  mes,  sum(cobranza_mes), sum(cobranzareal_mes)
from fecxc_caninter_alafech_cob_act
group by e_codigo,  segmento,  canal,  codmoneda,  mes;
insert into fecxc_caninter_alafech_cob_an_(e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal,  codmoneda,  mes,  sum(cobranza_mes), sum(cobranzareal_mes)
from fecxc_caninter_alafech_cob_ant
group by e_codigo,  segmento,  canal,  codmoneda,  mes;
delete from fecxc_caninter_deldia;
insert into fecxc_caninter_deldia(e_codigo,  segmento,  canal,  codmoneda,  mes, cobranza_dia)
select e_codigo,  segmento,  canal,  codmoneda,  mes, cobranza_dia
from fecxc_caninter_deldia_tmp;
delete from fecxc_caninter_xmes_cob_act;
insert into fecxc_caninter_xmes_cob_act(e_codigo, segmento,  canal, codmoneda, mes, cobranza_mes)
select e_codigo, segmento,  canal, codmoneda, mes, cobranza_mes
from fecxc_caninter_xmes_cob_act_tm;
delete from fecxc_caninter_xmes_cob_ant;
insert into fecxc_caninter_xmes_cob_ant(e_codigo,  segmento,  canal, codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal, codmoneda,  mes,  cobranza_mes, cobranzareal_mes
from fecxc_caninter_xmes_cob_ant_tm;
delete from fecxc_caninter_alafech_cob_act;
insert into fecxc_caninter_alafech_cob_act(e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes
from fecxc_caninter_alafech_cob_ac_;
delete from fecxc_caninter_alafech_cob_ant;
insert into fecxc_caninter_alafech_cob_ant(e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes)
select e_codigo,  segmento,  canal,  codmoneda,  mes,  cobranza_mes, cobranzareal_mes
from fecxc_caninter_alafech_cob_an_;
end if;
--  realiza la conversi?n de tipo de cambio dependiendo de su moneda inicial a dls. mn y dls se quedan tal cual.
/*
delete from fecxc_tipocambio_tmp;
insert into fecxc_tipocambio_tmp
select m.codmoneda, nvl(t.tipo_cambio_dls, 0)
from
fecxc_monedas m, fecxc_tpc t
where
m.secmoneda = t.secmoneda
and
t.fecha_tpc = p_fecha;
delete from fecxc_caninter_deldia_tmp;
insert into fecxc_caninter_deldia_tmp
select c.e_codigo, c.segmento, c.canal, 'DLS', c.mes, case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_dia / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_caninter_deldia c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_caninter_deldia a
where exists(select b.e_codigo, b.segmento from fecxc_caninter_deldia_tmp b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_caninter_deldia
select e_codigo, segmento, canal, codmoneda, mes, cobranza_dia from fecxc_caninter_deldia_tmp;
delete from fecxc_caninter_xmes_cob_act_tm;
insert into fecxc_caninter_xmes_cob_act_tm
select c.e_codigo, c.segmento, c.canal, 'DLS', c.mes, case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_caninter_xmes_cob_act c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc =  p_fecha;
delete from fecxc_caninter_xmes_cob_act a
where exists(select b.e_codigo, b.segmento from fecxc_caninter_xmes_cob_act_tm b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_caninter_xmes_cob_act
select e_codigo, segmento, canal, codmoneda, mes, cobranza_mes from fecxc_caninter_xmes_cob_act_tm;
delete from fecxc_caninter_xmes_cob_ant_tm;
insert into fecxc_caninter_xmes_cob_ant_tm
select c.e_codigo, c.segmento, c.canal, 'DLS', c.mes, case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_mes / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_caninter_xmes_cob_ant c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_caninter_xmes_cob_ant a
where exists(select b.e_codigo, b.segmento from fecxc_caninter_xmes_cob_ant_tm b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_caninter_xmes_cob_ant
select e_codigo, segmento, canal, codmoneda, mes, cobranza_mes, cobranzareal_mes from fecxc_caninter_xmes_cob_ant_tm;
delete from fecxc_caninter_alafech_cob_ac_;
insert into fecxc_caninter_alafech_cob_ac_
select c.e_codigo, c.segmento, c.canal, 'DLS', c.mes,  case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls, case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_mes / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_caninter_alafech_cob_act c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_caninter_alafech_cob_act a
where exists(select b.e_codigo, b.segmento from fecxc_caninter_alafech_cob_ac_ b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_caninter_alafech_cob_act
select e_codigo, segmento, canal, codmoneda, mes, cobranza_mes, cobranzareal_mes from fecxc_caninter_alafech_cob_ac_;
delete from fecxc_caninter_alafech_cob_an_;
insert into fecxc_caninter_alafech_cob_an_
select c.e_codigo, c.segmento, c.canal, 'DLS', c.mes, case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_mes / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_caninter_alafech_cob_ant c, fecxc_segmultimon s, fecxc_tpc t
where
c.segmento = s.cod_sec_lin
and
t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and
c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and
t.fecha_tpc = p_fecha;
delete from fecxc_caninter_alafech_cob_ant a
where exists(select b.e_codigo, b.segmento from fecxc_caninter_alafech_cob_an_ b where a.e_codigo = b.e_codigo and a.segmento = b.segmento);
insert into fecxc_caninter_alafech_cob_ant
select e_codigo, segmento, canal, codmoneda, mes, cobranza_mes, cobranzareal_mes from fecxc_caninter_alafech_cob_an_;
update fecxc_caninter_deldia d
set cobranza_dia = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_dia / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_deldia x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS'
where d.codmoneda not in ('MN','DLS');
update fecxc_caninter_deldia set cobranza_dia = 0 where cobranza_dia is null;
update fecxc_caninter_xmes_cob_act d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_xmes_cob_act x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS'
where d.codmoneda not in ('MN','DLS');
update fecxc_caninter_xmes_cob_act set cobranza_mes = 0 where cobranza_mes is null;
update fecxc_caninter_xmes_cob_ant d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_xmes_cob_ant x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS',
d.cobranzareal_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranzareal_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_xmes_cob_ant x where x.e_codigo = d.e_codigo and x.segmento = d.segmento)
where d.codmoneda not in ('MN','DLS');
update fecxc_caninter_xmes_cob_ant set cobranza_mes = 0, cobranzareal_mes = 0 where cobranza_mes is null or cobranzareal_mes is null;
update fecxc_caninter_alafech_cob_act d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_alafech_cob_act x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS',
d.cobranzareal_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranzareal_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_alafech_cob_act x where x.e_codigo = d.e_codigo and x.segmento = d.segmento)
where d.codmoneda not in ('MN','DLS');
update fecxc_caninter_alafech_cob_act set cobranza_mes = 0, cobranzareal_mes = 0 where cobranza_mes is null or cobranzareal_mes is null;
update fecxc_caninter_alafech_cob_ant d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_alafech_cob_ant x where x.e_codigo = d.e_codigo and x.segmento = d.segmento),
d.codmoneda = 'DLS',
d.cobranzareal_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranzareal_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end from fecxc_caninter_alafech_cob_ant x where x.e_codigo = d.e_codigo and x.segmento = d.segmento)
where d.codmoneda not in ('MN','DLS');
update fecxc_caninter_alafech_cob_ant set cobranza_mes = 0, cobranzareal_mes = 0 where cobranza_mes is null or cobranzareal_mes is null;
*/
--     larg se ingresa codigo para cambiar el tipo de cambio de euros a dolares y el tipo de moneda de euros a dolares cuando la empresa sea 552 y el segmento 13
/*
select count(*)
into t_count
from fecxc_tpc
where fecha_tpc= p_fecha
and secmoneda=15;
if t_count>0 then
begin
declare
cursor c_tc is
select canal,nvl(cobranza_dia*tipo_cambio_dls,0) as tcp_actualizado
from fecxc_caninter_deldia a, fecxc_tpc b,fecxc_monedas c
where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;
variables c_tc%rowtype;
begin
for variables in c_tc loop
update fecxc_caninter_deldia
set codmoneda='DLS',
cobranza_dia=variables.tcp_actualizado
where e_codigo=552 and segmento=13 and codmoneda='EUR' and canal=variables.canal;
select count(*)
into t_countdos
from  fecxc_caninter_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
if t_countdos > 1 then
select sum(nvl(cobranza_dia,0))
into t_cobranzames_act
from  fecxc_caninter_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
select min(cobranza_dia)
into t_min
from  fecxc_caninter_deldia
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
delete from fecxc_caninter_deldia
where cobranza_dia=t_min and e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
update fecxc_caninter_deldia
set cobranza_dia=t_cobranzames_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
end if;
/* commit; */
end loop;
end; --for
end;--cursor
/* dmap converted statement start */
begin declarecursor c_tc select is canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado from fecxc_caninter_xmes_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;/* dmap converted statement end */
variables c_tc%rowtype;
begin
for variables in c_tc loop
update fecxc_caninter_xmes_cob_act
set codmoneda='DLS',
cobranza_mes=variables.tcp_actualizado
where e_codigo=552 and segmento=13 and codmoneda='EUR' and canal=variables.canal;
select count(*)
into t_countdos
from  fecxc_caninter_xmes_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;/* dmap converted statement start */
if t_countdos > 1 then
select sum(coalesce(cobranza_mes,0))
into t_cobranzames_act
from  fecxc_caninter_xmes_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;/* dmap converted statement end */
select min(cobranza_mes)
into t_min
from  fecxc_caninter_xmes_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
delete from fecxc_caninter_xmes_cob_act
where cobranza_mes=t_min and e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
update fecxc_caninter_xmes_cob_act
set cobranza_mes=t_cobranzames_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
end if;
/* commit; */
end loop;
end; --for
end;--cursor
/* dmap converted statement start */
begin declarecursor c_tc select is canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado from fecxc_caninter_xmes_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos from fecxc_caninter_xmes_cob_ant a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;/* dmap converted statement end */
variables c_tc%rowtype;
begin
for variables in c_tc loop
update fecxc_caninter_xmes_cob_ant
set codmoneda='DLS',
cobranza_mes=variables.tcp_actualizado,
cobranzareal_mes=variables.tcp_actualizado_dos
where e_codigo=552 and segmento=13 and codmoneda='EUR' and canal=variables.canal;
select count(*)
into t_countdos
from  fecxc_caninter_xmes_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;/* dmap converted statement start */
if t_countdos > 1 then
select sum(coalesce(cobranza_mes,0)),sum(coalesce(cobranzareal_mes,0))
into t_cobranzames_act,t_cobranzames_act_dos
from  fecxc_caninter_xmes_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;/* dmap converted statement end */
select min(cobranza_mes),min(cobranzareal_mes)
into t_min,t_min_dos
from  fecxc_caninter_xmes_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
delete from fecxc_caninter_xmes_cob_ant
where cobranza_mes=t_min and cobranzareal_mes=t_min_dos and e_codigo=552
and segmento=13 and codmoneda='DLS' and canal=variables.canal;
update fecxc_caninter_xmes_cob_ant
set cobranza_mes=t_cobranzames_act,cobranzareal_mes=t_cobranzames_act_dos
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal;
end if;
/* commit; */
end loop;
end; --for
end;--cursor
/* dmap converted statement start */
begin declarecursor c_tc select is canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado from fecxc_caninter_xmes_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos from fecxc_caninter_xmes_cob_ant a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos,mes from fecxc_caninter_alafech_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;/* dmap converted statement end */
variables c_tc%rowtype;
begin
for variables in c_tc loop
update fecxc_caninter_alafech_cob_act
set codmoneda='DLS',
cobranza_mes=variables.tcp_actualizado,
cobranzareal_mes=variables.tcp_actualizado_dos
where e_codigo=552 and segmento=13 and codmoneda='EUR' and canal=variables.canal
and mes=variables.mes;
select count(*)
into t_countdos
from  fecxc_caninter_alafech_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;/* dmap converted statement start */
if t_countdos > 1 then
select sum(coalesce(cobranza_mes,0)),sum(coalesce(cobranzareal_mes,0))
into t_cobranzames_act,t_cobranzames_act_dos
from  fecxc_caninter_alafech_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;/* dmap converted statement end */
select min(cobranza_mes),min(cobranzareal_mes)
into t_min,t_min_dos
from  fecxc_caninter_alafech_cob_act
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
delete from fecxc_caninter_alafech_cob_act
where cobranza_mes=t_min and cobranzareal_mes=t_min_dos and e_codigo=552
and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
update fecxc_caninter_alafech_cob_act
set cobranza_mes=t_cobranzames_act,cobranzareal_mes=t_cobranzames_act_dos
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
end if;
/* commit; */
end loop;
end; --for
end;--cursor
/* dmap converted statement start */
begin declarecursor c_tc select is canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado from fecxc_caninter_xmes_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos from fecxc_caninter_xmes_cob_ant a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos,mes from fecxc_caninter_alafech_cob_act a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha; /* dmap converted statement end *//* dmap converted statement start */begin declare cursor c_tc is select canal,coalesce(cobranza_mes*tipo_cambio_dls,0) as tcp_actualizado,
coalesce(cobranzareal_mes*tipo_cambio_dls,0) as tcp_actualizado_dos,mes from fecxc_caninter_alafech_cob_ant a, fecxc_tpc b,fecxc_monedas c where a.codmoneda=c.codmoneda and c.secmoneda=b.secmoneda and
a.e_codigo=552 and a.segmento=13 and a.codmoneda='EUR'
and fecha_tpc= p_fecha;/* dmap converted statement end */
variables c_tc%rowtype;
begin
for variables in c_tc loop
update fecxc_caninter_alafech_cob_ant
set codmoneda='DLS',
cobranza_mes=variables.tcp_actualizado,
cobranzareal_mes=variables.tcp_actualizado_dos
where e_codigo=552 and segmento=13 and codmoneda='EUR' and canal=variables.canal
and mes=variables.mes;
select count(*)
into t_countdos
from  fecxc_caninter_alafech_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;/* dmap converted statement start */
if t_countdos > 1 then
select sum(coalesce(cobranza_mes,0)),sum(coalesce(cobranzareal_mes,0))
into t_cobranzames_act,t_cobranzames_act_dos
from  fecxc_caninter_alafech_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;/* dmap converted statement end */
select min(cobranza_mes),min(cobranzareal_mes)
into t_min,t_min_dos
from  fecxc_caninter_alafech_cob_ant
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
delete from fecxc_caninter_alafech_cob_ant
where cobranza_mes=t_min and cobranzareal_mes=t_min_dos and e_codigo=552
and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
update fecxc_caninter_alafech_cob_ant
set cobranza_mes=t_cobranzames_act,cobranzareal_mes=t_cobranzames_act_dos
where e_codigo=552 and segmento=13 and codmoneda='DLS' and canal=variables.canal
and mes=variables.mes;
end if;
/* commit; */
end loop;
end; --for
end;--cursor
end if;
*/
end if;
/* commit; */
exception
when no_data_found then
raise exception '%', 'Es necesario capturar un INPC en el cat?logo de INPC para poder obtener los montos ACTUALIZADOS.' using errcode = '45000';
end;
$body$
language plpgsql
;
