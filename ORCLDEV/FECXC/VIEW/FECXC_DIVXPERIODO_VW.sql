-- dmap_object_gen_tag : type : view name : fecxc_divxperiodo_vw
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_divxperiodo_vw"  ("orden", "tipo", "subtipo", "segmento", "canal", "mes", "importe", "importenom", "cod_valor", "dessegmento", "descanal") as select orden,
tipo,
subtipo,
segmento,
canal,
mes,
importe,
importenom,
b.cod_valor,
b.desc_valor dessegmento,
c.desc_valor descanal
from (
select a.orden,
a.tipo,
a.subtipo,
a.segmento,
a.canal,
a.mes,
a.importe,
a.importenom
from
(select 2        as orden,
'A LA FECHA'   as tipo,
'A?O ANTERIOR' as subtipo,
segmento,
canal,
mes,
sum(a.cobranza_mes)     as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_ant a
group by segmento,
canal,
mes
union
select 2       as orden,
'A LA FECHA' as tipo,
'REAL'       as subtipo,
segmento,
canal,
mes,
sum(a.cobranza_mes)     as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by segmento,
canal,
mes
union
select 2        as orden,
'A LA FECHA'  as tipo,
'PRESUPUESTO' as subtipo,
segmento,
canal,
mes,
sum(a.presup_mes)     as importe,
sum(a.presupreal_mes) as "importenom"
from fecxc_caninter_alafecha_pre a
group by segmento,
canal,
mes
union
select 2             as orden,
'A LA FECHA'       as tipo,
'VAR REAL VS PPTO' as subtipo,
a.segmento,
a.canal,
a.mes,
( a.importe    - coalesce(b.importe,0.00) )    as importe,
( a.importenom - coalesce(b.importenom,0.00) ) as "importenom"
from (select segmento,
canal,
mes,
sum(a.cobranza_mes)     as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by segmento,
canal,
mes
) a
left outer join (select segmento,
canal,
mes,
sum(a.presup_mes)     as importe,
sum(a.presupreal_mes) as "importenom"
from fecxc_caninter_alafecha_pre a
group by segmento,
canal,
mes
) b on (a.segmento = b.segmento and a.canal = b.canal)
union
select 2                           as orden,
'A LA FECHA'                     as tipo,
'VARIACI?N REAL VS A?O ANTERIOR' as subtipo,
a.segmento,
a.canal,
a.mes,
( a.importe    - coalesce(b.importe,0.00) )    as importe,
( a.importenom - coalesce(b.importenom,0.00) ) as "importenom"
from (select segmento,
canal,
mes,
sum(a.cobranza_mes)     as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by segmento,
canal,
mes
) a
left outer join (select segmento,
canal,
mes,
sum(a.cobranza_mes)     as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_ant a
group by segmento,
canal,
mes
) b on (a.segmento = b.segmento and a.canal = b.canal) ) a ) a,
fecxc_det_catalogos b,
fecxc_det_catalogos c
where a.segmento = b.cod_sec_lin
and b.tipo_cat   = 'SEGMENTO'
and a.canal      = c.cod_sec_lin
and ( c.tipo_cat = 'CANAL'
or c.tipo_cat    = 'REGION'
or c.tipo_cat    = 'DIVISION' );/* dmap converted statement end */
-- estimed cost of view [ fecxc_divxperiodo_vw ]: 1.00;
