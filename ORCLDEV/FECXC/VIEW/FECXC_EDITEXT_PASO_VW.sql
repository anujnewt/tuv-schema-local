-- dmap_object_gen_tag : type : view name : fecxc_editext_paso_vw
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_editext_paso_vw"  ("division_desc", "concepto_desc", "cobranza_dia", "cobranza_mes", "presup_mes", "variacion_mes", "perc_mes", "cobranza_alafecha", "presup_alafecha", "variacion_alafecha", "perc_alafecha", "cobranza_anterior", "variacion_anterior", "perc_anterior") as select division_desc ,   concepto_desc ,
sum(cobranza_dia) cobranza_dia,
sum(cobranza_mes) cobranza_mes,
sum( presup_mes) presup_mes,
sum(variacion_mes) variacion_mes,
case
when sum(presup_mes) = 0
then 0
else   (( sum(cobranza_mes) - sum(presup_mes)) / sum(presup_mes))  * 100
end  perc_mes,
sum(cobranza_alafecha) cobranza_alafecha,
sum( presup_alafecha) presup_alafecha,
sum(variacion_alafecha) variacion_alafecha,
case
when sum(presup_alafecha) = 0
then 0
else   ((sum(cobranza_alafecha) - sum(presup_alafecha)) / sum(presup_alafecha)) * 100
end  perc_alafecha,
sum(cobranza_anterior) cobranza_anterior,
sum(variacion_anterior) variacion_anterior,
case
when sum(cobranza_anterior) = 0
then 0
else   ((sum(cobranza_alafecha) - sum(cobranza_anterior)) / sum(cobranza_anterior)) * 100
end perc_anterior
from (
select distinct   division_desc , concepto_desc ,
cobranza_dia,
cobranza_mes, presup_mes,
(cobranza_mes -presup_mes)  variacion_mes,
cobranza_alafecha,
presup_alafecha,
(cobranza_alafecha - presup_alafecha) variacion_alafecha,
cobranza_anterior,
(cobranza_alafecha  - cobranza_anterior) variacion_anterior
from fecxc.fecxc_editext_det_rep
where division in (select cod_sec_lin
from fecxc_det_catalogos
where tipo_cat = 'DIVISION'
and rep_edit_ext = 1)
and concepto in (select cod_sec_lin
from fecxc_det_catalogos
where tipo_cat = 'CONCEPTO'
and rep_edit_ext = 1)
order by  division_desc, concepto_desc ) alias32
group by  cube(division_desc, concepto_desc)
order by  division_desc, concepto_desc;/* dmap converted statement end */
-- estimed cost of view [ fecxc_editext_paso_vw ]: 1.00;
