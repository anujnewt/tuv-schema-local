create or replace procedure fecxc."fecxc_editext_rep"  ( p_anio numeric, p_mes numeric, p_fecha timestamp(0), p_inpc numeric, p_formato numeric, p_mensualizado numeric, p_segmentosesp numeric, p_segmento numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_inpc                  decimal(20,11);
v_inpc2                  decimal(20,11);
begin 

--obtiene la cobranza del dia ***division***
/*
delete from fecxc_cobranza_deldia;
insert into fecxc_cobranza_deldia(e_codigo, segmento,codmoneda, cobranza_dia)
select a.e_codigo, b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and f.cod_sec_lin is not null and (c.es_moneda_loccal is null or c.es_moneda_loccal = 0) and e.tipo_cambio is not null then e.tipo_cambio else 1 end))/p_formato cobranza_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and a.f_deposito = p_fecha                ---parametro del dia
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--obtiene la cobranza del dia ***segmento*** ***concepto*** ***division***
--old version
/*
delete from fecxc_cobranza_deldia_scd;
insert into fecxc_cobranza_deldia_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_dia)
select a.e_codigo, b.segmento1,b.segmento2,b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and f.cod_sec_lin is not null and (c.es_moneda_loccal is null or c.es_moneda_loccal = 0) and e.tipo_cambio is not null then e.tipo_cambio else 1 end))/p_formato cobranza_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and a.f_deposito = p_fecha                ---parametro del dia
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
*/
delete from fecxc_cobranza_deldia_scd;
insert into fecxc_cobranza_deldia_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_dia)
select a.e_codigo, b.segmento1,b.segmento2,b.segmento3,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) = 22
then e.tipo_cambio_dls
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
if p_mensualizado = 0 then           /* mensualizado... */
--obtiene cobranza del mes ***division***
/*
delete from fecxc_cobranza_delmes;
insert into fecxc_cobranza_delmes(e_codigo, segmento,codmoneda, cobranza_mes)
select a.e_codigo, b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and f.cod_sec_lin is not null and (c.es_moneda_loccal is null or c.es_moneda_loccal = 0) and e.tipo_cambio is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio             --parametro de a?o
and d.mes_cobranza = p_mes             --parametro de mes
and a.f_deposito <= p_fecha
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc  (+)
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--obtiene cobranza del mes ***segmento*** ***concepto*** ***division***
delete from fecxc_cobranza_delmes_scd;
insert into fecxc_cobranza_delmes_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_mes)
select a.e_codigo, b.segmento1, b.segmento2, b.segmento3,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
--llena cobranza del a la fecha ***division***
/*
delete from fecxc_cobranza_alafecha;
insert into fecxc_cobranza_alafecha(e_codigo, segmento,codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo, b.segmento3,
c.codmoneda,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_mes,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato cobranzareal_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and d.mes_cobranza <= p_mes
and a.f_deposito <= p_fecha
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc  (+)
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--llena cobranza del a la fecha ***segmento*** ***concepto*** ***division***
delete from fecxc_cobranza_alafecha_scd;
insert into fecxc_cobranza_alafecha_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo, b.segmento1, b.segmento2, b.segmento3,
c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
--llena cobranza anterior mismo dia ***division***
/*
delete from fecxc_cobranza_anterior;
insert into fecxc_cobranza_anterior(e_codigo, segmento,codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_anterior,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato cobranzareal_anterior
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio -1                    --parametro de a?o
and d.mes_cobranza <= p_mes                        --parametro de mes
and d.anio_cobranza = e.ano_inpc  (+)
and d.mes_cobranza = e.mes_inpc    (+)
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--llena cobranza anterior mismo dia ****segmento*** ***concepto*** **division***
delete from fecxc_cobranza_anterior_scd;
insert into fecxc_cobranza_anterior_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1, b.segmento2, b.segmento3,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2,b.segmento3, c.codmoneda;
--obtiene el presupuesto del mes ***division***
/*
delete from fecxc_presup_delmes;
insert into fecxc_presup_delmes(segmento, codmoneda, presup_mes, presupreal_mes)
select b.segmento3, c.codmoneda,sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato presup_mes,
sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato presupreal_mes
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and d.mes_cobranza = p_mes                      --parametro de mes
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc   (+)
and b.segmento1 = 15
group by b.segmento3, c.codmoneda;
*/
--obtiene el presupuesto del mes ***segmento*** ***concepto*** ***division***
delete from fecxc_presup_delmes_scd;
insert into fecxc_presup_delmes_scd(segmento, concepto, division, codmoneda, presup_mes, presupreal_mes)
select b.segmento1,b.segmento2,b.segmento3, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_mes,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                       --parametro de mes
and b.segmento1 = p_segmento group by b.segmento1,b.segmento2,b.segmento3, c.codmoneda;
--obtiene el presupuesto a la fecha ***division***
/*
delete from fecxc_presup_alafecha;
insert into fecxc_presup_alafecha(segmento, codmoneda, presup_alafecha, presupreal_alafecha)
select b.segmento3, c.codmoneda,sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato presup_alafecha,
sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato presupreal_alafecha
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and d.mes_cobranza <= p_mes                  --parametro del mes
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc   (+)
and b.segmento1 = 15
group by b.segmento3, c.codmoneda;
*/
--obtiene el presupuesto a la fecha ***segmento*** ***concepto*** ***division***
delete from fecxc_presup_alafecha_scd;
insert into fecxc_presup_alafecha_scd(segmento, concepto, division, codmoneda, presup_alafecha, presupreal_alafecha)
select b.segmento1,b.segmento2,b.segmento3, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_alafecha,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_alafecha
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza <= p_mes                   --parametro del mes
and b.segmento1 = p_segmento group by b.segmento1,b.segmento2,b.segmento3, c.codmoneda;
else /* a una fecha dada */
--obtiene cobranza del mes ***division***
/*
delete from fecxc_cobranza_delmes;
insert into fecxc_cobranza_delmes(e_codigo, segmento,codmoneda, cobranza_mes)
select a.e_codigo, b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio             --parametro de a?o
and d.mes_cobranza = p_mes             --parametro de mes
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc   (+)
and a.f_deposito <= p_fecha
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--obtiene cobranza del mes ***segmento*** ***concepto*** ***division***
delete from fecxc_cobranza_delmes_scd;
insert into fecxc_cobranza_delmes_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_mes)
select a.e_codigo,b.segmento1,b.segmento2,b.segmento3,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo,b.segmento1,b.segmento2,b.segmento3,c.codmoneda;
--llena cobranza a la fecha ***division***
/*
delete from fecxc_cobranza_alafecha;
insert into fecxc_cobranza_alafecha(e_codigo, segmento,codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo, b.segmento3,
c.codmoneda,sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_mes,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato cobranzareal_mes
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and a.f_deposito <= p_fecha                ---parametro del dia
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc  (+)
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--llena cobranza a la fecha ****segmento*** ***concepto*** **division***
delete from fecxc_cobranza_alafecha_scd;
insert into fecxc_cobranza_alafecha_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_alafecha, cobranzareal_alafecha)
select a.e_codigo, b.segmento1, b.segmento2, b.segmento3,
c.codmoneda,sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
--llena cobranza anterior mismo dia ***division***
/*
delete from fecxc_cobranza_anterior;
insert into fecxc_cobranza_anterior(e_codigo, segmento,codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento3,c.codmoneda,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato cobranza_anterior,
sum(b.importe*(case when p_segmentosesp = 1 and nullif(f.cod_sec_lin::text, '') is not null and (nullif(c.es_moneda_loccal::text, '') is null or c.es_moneda_loccal = 0) and nullif(e.tipo_cambio::text, '') is not null then e.tipo_cambio else 1 end)*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato cobranzareal_anterior
from fecxc_enc_clasificados a, fecxc_det_clasificados b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e,
fecxc_tpc e,
fecxc_segmultimon f
where a.e_codigo = b.e_codigo
and a.cod_sec_clasifica = b.cod_sec_clasifica
and a.secmoneda = c.secmoneda
and a.f_deposito between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio -1                    --parametro de a?o
and a.f_deposito <= to_timestamp(p_fecha) - interval '365 day'                 ---parametro del dia
and d.anio_cobranza = e.ano_inpc  (+)
and d.mes_cobranza = e.mes_inpc    (+)
and exists(select 1 from fecxc_det_clasfecxc clas
where b.cod_sec_catclas = clas.cod_sec_catclas
and b.cod_sec_det = clas.cod_sec_det
and clas.excluir_enreportes = 'NO')
and a.secmoneda = e.secmoneda (+)
and a.f_deposito = e.fecha_tpc (+)
and b.segmento1 = f.cod_sec_lin (+)
and b.segmento1 = 15
group by a.e_codigo, b.segmento3, c.codmoneda;
*/
--llena cobranza anterior mismo dia ***segmento*** ***concepto*** ***division***
delete from fecxc_cobranza_anterior_scd;
insert into fecxc_cobranza_anterior_scd(e_codigo, segmento, concepto, division, codmoneda, cobranza_anterior, cobranzareal_anterior)
select a.e_codigo, b.segmento1, b.segmento2, b.segmento3,c.codmoneda,
sum(b.importe*(case
when p_segmentosesp = 0
then 1
else
case
when nullif(f.cod_sec_lin::text, '') is null
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) not in (22)
then 1
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then e.tipo_cambio
when nullif(f.cod_sec_lin::text, '') is not null and f.secmoneda not in (22)
and (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda) in (22)
then e.tipo_cambio_dls * case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end
when
nullif(f.cod_sec_lin::text, '') is not null
and f.secmoneda not in (22)
and f.secmoneda <> (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda)
then
(select round((conversion_rate)::numeric,4)
from fecxc_tpc_multimoneda_vw
where from_currency = (select mon_oracle from ad_fecxc.fecxc_tpc_multimoneda where secmoneda = (select coalesce(q.eq_sif,0) from fecxc_monedas_equivalencia q where q.secmoneda = a.secmoneda))
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
and clas.excluir_enreportes = 'NO')    and b.segmento1 = p_segmento group by a.e_codigo, b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
--llena presupuesto del mes ***division***
/*
delete from fecxc_presup_delmes;
insert into fecxc_presup_delmes(segmento, codmoneda, presup_mes, presupreal_mes)
select b.segmento3, c.codmoneda,sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato presup_mes,
sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato presupreal_mes
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and d.mes_cobranza = p_mes                      --parametro de mes
and b.diario <= p_fecha
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc   (+)
and b.segmento1 = 15
group by b.segmento3, c.codmoneda;
*/
--llena presupuesto del mes ****segmento*** ***concepto*** **division***
delete from fecxc_presup_delmes_scd;
insert into fecxc_presup_delmes_scd(segmento, concepto, division, codmoneda, presup_mes, presupreal_mes)
select b.segmento1, b.segmento2, b.segmento3, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_mes,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_mes
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and d.mes_cobranza = p_mes                       --parametro de mes
and b.diario <= p_fecha   and b.segmento1 = p_segmento group by b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
--llena presupuesto del alafecha ***division***
/*
delete from fecxc_presup_alafecha;
insert into fecxc_presup_alafecha(segmento, codmoneda, presup_alafecha,presupreal_alafecha)
select b.segmento3, c.codmoneda,sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,1,v_inpc/nvl(e.inpc_actual,v_inpc),1),1))/p_formato presup_alafecha,
sum(b.importe*decode(c.es_moneda_loccal,1,decode(p_inpc,2,v_inpc2/nvl(e.inpc_actual,v_inpc2),1),1))/p_formato presupreal_alafecha
from fecxc_enc_de_presu a, fecxc_det_pres_diario b, fecxc_monedas c, fecxc_calendario_cob d, fecxc_inpc e
where a.sec_presup = b.sec_presup
and a.secmoneda = c.secmoneda
and b.diario between d.fecha_inicio and d.fecha_fin
and d.anio_cobranza = p_anio                    --parametro de a?o
and b.diario <= p_fecha
and d.anio_cobranza = e.ano_inpc (+)
and d.mes_cobranza = e.mes_inpc   (+)
and b.segmento1 = 15
group by b.segmento3, c.codmoneda;
*/
--llena presupuesto del alafecha ****segmento*** ***concepto*** **division***
delete from fecxc_presup_alafecha_scd;
insert into fecxc_presup_alafecha_scd(segmento, concepto, division, codmoneda, presup_alafecha,presupreal_alafecha)
select b.segmento1, b.segmento2, b.segmento3, c.codmoneda,sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=1 then v_inpc/coalesce(e.inpc_actual,v_inpc)  else 1 end   else 1 end )/p_formato presup_alafecha,
sum(b.importe*case when c.es_moneda_loccal=1 then case when p_inpc=2 then v_inpc2/coalesce(e.inpc_actual,v_inpc2)  else 1 end   else 1 end )/p_formato presupreal_alafecha
from fecxc_monedas c, fecxc_det_pres_diario b, fecxc_enc_de_presu a, fecxc_calendario_cob d
left outer join fecxc_inpc e on (d.anio_cobranza = e.ano_inpc and d.mes_cobranza = e.mes_inpc)
where a.sec_presup = b.sec_presup and a.secmoneda = c.secmoneda and b.diario between d.fecha_inicio and d.fecha_fin and d.anio_cobranza = p_anio                     --parametro de a?o
and b.diario <= p_fecha   and b.segmento1 = p_segmento group by b.segmento1, b.segmento2, b.segmento3, c.codmoneda;
end if;
--realiza la conversion de tipo de cambio dependiendo de su moneda inicial a dls.
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
--obtiene los registros que no coincidan con la moneda asignada a su segmento
delete from fecxc_cobranza_deldia_scd_tmp;
insert into fecxc_cobranza_deldia_scd_tmp
select c.e_codigo, c.segmento, c.concepto, c.division, 'DLS',
case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_dia / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_cobranza_deldia_scd c, fecxc_segmultimon s, fecxc_tpc t
where c.segmento = s.cod_sec_lin
and t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and t.fecha_tpc = p_fecha;  --to_timestamp('16/07/2010','DD/MM/YYYY');
delete from fecxc_cobranza_deldia_scd a
where exists(select 1 from fecxc_cobranza_deldia_scd_tmp b
where a.e_codigo = b.e_codigo and a.segmento = b.segmento
and a.division = b.division and a.concepto = a.concepto
);
insert into fecxc_cobranza_deldia_scd
select e_codigo, segmento, concepto, division, codmoneda, cobranza_dia from fecxc_cobranza_deldia_scd_tmp;
delete from fecxc_cobranza_delmes_scd_tmp;
insert into fecxc_cobranza_delmes_scd_tmp
select c.e_codigo, c.segmento, c.concepto, c.division, 'DLS',
case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_mes / t.tipo_cambio_dls)
end as cambio_dls
from fecxc_cobranza_delmes_scd c, fecxc_segmultimon s, fecxc_tpc t
where c.segmento = s.cod_sec_lin
and t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_delmes_scd a
where exists(select 1 from fecxc_cobranza_delmes_scd_tmp b
where a.e_codigo = b.e_codigo and a.segmento = b.segmento
and a.division = b.division and a.concepto = a.concepto
);
insert into fecxc_cobranza_delmes_scd
select e_codigo, segmento, concepto, division, codmoneda, cobranza_mes from fecxc_cobranza_delmes_scd_tmp;
delete from fecxc_cobranza_alafecha_scd_tm;
insert into fecxc_cobranza_alafecha_scd_tm
select c.e_codigo, c.segmento, concepto, division, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_alafecha / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_alafecha / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_cobranza_alafecha_scd c, fecxc_segmultimon s, fecxc_tpc t
where c.segmento = s.cod_sec_lin
and t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_alafecha_scd a
where exists(select 1 from fecxc_cobranza_alafecha_scd_tm b
where a.e_codigo = b.e_codigo and a.segmento = b.segmento
and a.division = b.division and a.concepto = a.concepto
);
insert into fecxc_cobranza_alafecha_scd
select e_codigo, segmento, concepto, division, codmoneda, cobranza_alafecha, cobranzareal_alafecha from fecxc_cobranza_alafecha_scd_tm;
delete from fecxc_cobranza_anterior_scd_tm;
insert into fecxc_cobranza_anterior_scd_tm
select c.e_codigo, c.segmento, concepto, division, 'DLS', case
when t.tipo_cambio_dls is null then 0
else (c.cobranza_anterior / t.tipo_cambio_dls)
end as cambio_dls,
case
when t.tipo_cambio_dls is null then 0
else (c.cobranzareal_anterior / t.tipo_cambio_dls)
end as cambioreal_dls
from fecxc_cobranza_anterior_scd c, fecxc_segmultimon s, fecxc_tpc t
where c.segmento = s.cod_sec_lin
and t.secmoneda in (select secmoneda from fecxc_monedas where codmoneda = c.codmoneda)
and c.codmoneda <> (select m.codmoneda from fecxc_monedas m where m.secmoneda = s.secmoneda)
and t.fecha_tpc = p_fecha;
delete from fecxc_cobranza_anterior_scd a
where exists(select 1 from fecxc_cobranza_anterior_scd_tm b
where a.e_codigo = b.e_codigo and a.segmento = b.segmento
and a.division = b.division and a.concepto = a.concepto
);
insert into fecxc_cobranza_anterior_scd
select e_codigo, segmento, concepto, division, codmoneda, cobranza_anterior, cobranzareal_anterior from fecxc_cobranza_anterior_scd_tm;
--realiza la conversion a dlls de los montos que se encuentren en otra moneda
update fecxc_cobranza_deldia_scd d
set cobranza_dia = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_dia / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end
from fecxc_cobranza_deldia_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
and x.concepto = d.concepto and x.division = d.division),
d.codmoneda = 'DLS'
where d.codmoneda not in ('DLS');
update fecxc_cobranza_deldia_scd set cobranza_dia = 0 where cobranza_dia is null;
update fecxc_cobranza_delmes_scd d
set cobranza_mes = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_mes / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end
from fecxc_cobranza_delmes_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
and x.concepto = d.concepto and x.division = d.division),
d.codmoneda = 'DLS'
where d.codmoneda not in ('DLS');
update fecxc_cobranza_delmes_scd set cobranza_mes = 0 where cobranza_mes is null;
/*
update fecxc_cobranza_alafecha_scd d
set cobranza_alafecha = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_alafecha / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end
from fecxc_cobranza_alafecha_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
and x.concepto = d.concepto and x.division = d.division),
d.codmoneda = 'DLS'--,
--d.cobranzareal_alafecha = (select case
--                                    when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
--                                    else d.cobranzareal_alafecha / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
--                                  end
--                            from fecxc_cobranza_alafecha_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
--                            and x.concepto = d.concepto and x.division = d.division)
where d.codmoneda not in ('DLS');
update fecxc_cobranza_alafecha_scd set cobranza_alafecha = 0, cobranzareal_alafecha = 0 where cobranza_alafecha is null or cobranzareal_alafecha is null;
update fecxc_cobranza_anterior_scd d
set cobranza_anterior = (select case
when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
else d.cobranza_anterior / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
end
from fecxc_cobranza_anterior_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
and x.concepto = d.concepto and x.division = d.division),
d.codmoneda = 'DLS'--,
--d.cobranzareal_anterior = (select case
--                                when (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = x.codmoneda) is null then 0
--                                else d.cobranzareal_anterior / (select t.tipo_cambio_dls from fecxc_tipocambio_tmp t where t.codmoneda = d.codmoneda)
--                             end
--                            from fecxc_cobranza_anterior_scd x where x.e_codigo = d.e_codigo and x.segmento = d.segmento
--                            and x.concepto = d.concepto and x.division = d.division)
where d.codmoneda not in ('DLS');
update fecxc_cobranza_anterior_scd set cobranza_anterior = 0, cobranzareal_anterior = 0 where cobranza_anterior is null or cobranzareal_anterior is null;
*/
*/
--carga tabla para reporte editorial extranjero
delete from fecxc_editext_det_rep;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select division, concepto, codmoneda from fecxc_cobranza_deldia_scd group by division, concepto, codmoneda  order by  division, concepto;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select a.division, a.concepto, a.codmoneda from fecxc_cobranza_delmes_scd a
where not exists (select 1 from fecxc_editext_det_rep b where a.division = b.division and a.concepto = b.concepto)
group by a.division, a.concepto, a.codmoneda  order by  a.division, a.concepto;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select a.division, a.concepto, a.codmoneda from fecxc_presup_delmes_scd a
where not exists (select 1 from fecxc_editext_det_rep b where a.division = b.division and a.concepto = b.concepto)
group by a.division, a.concepto, a.codmoneda  order by  a.division, a.concepto;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select a.division, a.concepto, a.codmoneda from fecxc_cobranza_alafecha_scd a
where not exists (select 1 from fecxc_editext_det_rep b where a.division = b.division and a.concepto = b.concepto)
group by a.division, a.concepto, a.codmoneda  order by  a.division, a.concepto;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select a.division, a.concepto, a.codmoneda from fecxc_presup_alafecha_scd a
where not exists (select 1 from fecxc_editext_det_rep b where a.division = b.division and a.concepto = b.concepto)
group by a.division, a.concepto, a.codmoneda  order by  a.division, a.concepto;
insert into fecxc_editext_det_rep(division, concepto, codmoneda)
select a.division, a.concepto, a.codmoneda from fecxc_cobranza_anterior_scd a
where not exists (select 1 from fecxc_editext_det_rep b where a.division = b.division and a.concepto = b.concepto)
group by a.division, a.concepto, a.codmoneda  order by  a.division, a.concepto;
--actualiza montos cobranza del dia
update fecxc_editext_det_rep a
set cobranza_dia = (select sum(b.cobranza_dia) from fecxc_cobranza_deldia_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos cobranza del mes
update fecxc_editext_det_rep a
set cobranza_mes = (select sum(b.cobranza_mes) from fecxc_cobranza_delmes_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos presupuesto del mes
update fecxc_editext_det_rep a
set presup_mes = (select sum(b.presup_mes) from fecxc_presup_delmes_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos variacion del mes
update fecxc_editext_det_rep
set varia_mes = coalesce(cobranza_mes,0) - coalesce(presup_mes,0);
--actualiza porcentaje del mes
update fecxc_editext_det_rep
set perc_mes = case
when coalesce(presup_mes,0) = 0 then 0
else ((coalesce(cobranza_mes,0) - coalesce(presup_mes,0)) / presup_mes)*100
end;
--actualiza montos cobranza a la fecha
update fecxc_editext_det_rep a
set cobranza_alafecha = (select sum(b.cobranza_alafecha) from fecxc_cobranza_alafecha_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos presupuesto la fecha
update fecxc_editext_det_rep a
set presup_alafecha = (select sum(b.presup_alafecha) from fecxc_presup_alafecha_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos variacion a la fecha
update fecxc_editext_det_rep
set varia_alafecha = coalesce(cobranza_alafecha,0) - coalesce(presup_alafecha,0);
--actualiza porcentaje a la fecha
update fecxc_editext_det_rep
set perc_alafecha = case
when coalesce(presup_alafecha,0) = 0 then 0
else ((coalesce(cobranza_alafecha,0) - coalesce(presup_alafecha,0)) / presup_alafecha)*100
end;
--actualiza montos cobranza anterior
update fecxc_editext_det_rep a
set cobranza_anterior = (select sum(b.cobranza_anterior) from fecxc_cobranza_anterior_scd b where a.division = b.division and a.concepto = b.concepto group by a.division, a.concepto);
--actualiza montos variacion anterior
update fecxc_editext_det_rep
set varia_anterior = coalesce(cobranza_alafecha,0) - coalesce(cobranza_anterior,0);
--actualiza porcentaje anterior
update fecxc_editext_det_rep
set perc_anterior = case
when coalesce(cobranza_anterior,0) = 0 then 0
else ((coalesce(cobranza_alafecha,0) - coalesce(cobranza_anterior,0)) / cobranza_anterior)*100
end;
update fecxc_editext_det_rep set cobranza_dia = 0 where nullif(cobranza_dia::text, '') is null;
update fecxc_editext_det_rep set cobranza_mes = 0 where nullif(cobranza_mes::text, '') is null;
update fecxc_editext_det_rep set presup_mes = 0 where nullif(presup_mes::text, '') is null;
update fecxc_editext_det_rep set cobranza_alafecha = 0 where nullif(cobranza_alafecha::text, '') is null;
update fecxc_editext_det_rep set presup_alafecha = 0 where nullif(presup_alafecha::text, '') is null;
update fecxc_editext_det_rep set cobranza_dia = 0 where nullif(cobranza_dia::text, '') is null;
update fecxc_editext_det_rep set cobranza_anterior = 0 where nullif(cobranza_anterior::text, '') is null;
update fecxc_editext_det_rep a set division_desc = (select b.desc_valor from fecxc_det_catalogos b where a.division = b.cod_sec_lin),
a.concepto_desc = (select b.desc_valor from fecxc_det_catalogos b where a.concepto = b.cod_sec_lin);
delete from fecxc_editext_g_fin_rep;
insert into fecxc_editext_g_fin_rep(division_desc, cobranza_dia, cobranza_mes, presup_mes, varia_mes, perc_mes,
cobranza_alafecha, presup_alafecha, varia_alafecha, perc_alafecha,cobranza_anterior, varia_anterior, perc_anterior)
select division_desc, cobranza_dia, cobranza_mes, presup_mes, variacion_mes, round((perc_mes)::numeric,2) as perc_mes,
cobranza_alafecha, presup_alafecha, variacion_alafecha, round((perc_alafecha)::numeric,2) as perc_alafecha,
cobranza_anterior, variacion_anterior, round((perc_anterior)::numeric, 2) as perc_anterior
from fecxc_editext_g_rep_vw
where nullif(division_desc::text, '') is not null;
delete from ad_fecxc.fecxc_editext_fin_rep;
insert into ad_fecxc.fecxc_editext_fin_rep(division_desc, concepto_desc, cobranza_dia, cobranza_mes, presup_mes, varia_mes, perc_mes,
cobranza_alafecha, presup_alafecha, varia_alafecha, perc_alafecha,
cobranza_anterior, varia_anterior, perc_anterior,orden,ordenc)
select division_desc, concepto_desc, cobranza_dia, cobranza_mes, presup_mes, variacion_mes, round((perc_mes)::numeric,2) as perc_mes,
cobranza_alafecha, presup_alafecha, variacion_alafecha, round((perc_alafecha)::numeric,2) as perc_alafecha,
cobranza_anterior, variacion_anterior, round((perc_anterior)::numeric, 2) as perc_anterior,
case when division_desc = '~TOTAL EDITORIAL EXTRANJERO' then 2
else 1
end as orden,
case when concepto_desc like '~TOTAL%' then 2
else 1
end as ordenc
from fecxc_editext_rep_vw
where nullif(division_desc::text, '') is not null;
/* commit; */
end;
$body$
language plpgsql
;
