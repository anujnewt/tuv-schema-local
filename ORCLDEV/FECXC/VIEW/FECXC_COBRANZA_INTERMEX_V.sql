-- dmap_object_gen_tag : type : view name : fecxc_cobranza_intermex_v
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_cobranza_intermex_v"  ("orden", "tipo", "subtipo", "segmento", "canal", "importe", "importenom", "cod_valor", "dessegmento", "descanal") as select orden,  tipo,  subtipo,  segmento,  canal,  importe,  importenom,  b.cod_valor,  b.desc_valor  dessegmento,  c.desc_valor  descanal
from (
(
select 0 as orden, 'DEL DIA' as tipo, 'REAL' as subtipo, segmento, canal, sum(a.cobranza_dia) as importe,
sum(a.cobranza_dia) as "importenom"
from fecxc_caninter_deldia a
group by segmento, canal
)
union
select a.orden, a.tipo, a.subtipo, a.segmento, a.canal, a.importe, a.importenom
from (
/*se agrega columna de importe nominal*/
select 1 as orden, 'DEL MES' as tipo, 'A?O ANTERIOR' as subtipo, segmento, canal, sum(a.cobranza_mes) as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_xmes_cob_ant a
group by  segmento, canal
union
select 1 as orden,'DEL MES' as tipo, 'REAL' as subtipo, segmento, canal, sum(a.cobranza_mes) as importe,
sum(a.cobranza_mes) as "importenom"
from fecxc_caninter_xmes_cob_act a
group by segmento, canal
union
select 1 as orden,'DEL MES' as tipo, 'PRESUPUESTO' as subtipo, segmento, canal, sum(a.presup_mes) as importe,
sum(a.presup_mes) as "importenom"
from fecxc_caninter_xmes_pre a
group by segmento, canal
)  a
union
/*se agrega columna de importe nominal*/
select 1 as orden,'DEL MES' as tipo, 'VAR REAL VS PPTO' as subtipo,a.segmento,a.canal,
( a.importe - coalesce(b.importe,0.00) ) as importe, ( a.importenom - coalesce(b.importe,0.00) ) as "importenom"
from (
select segmento, canal, sum(a.cobranza_mes) as importe, sum(a.cobranza_mes) as "importenom"
from fecxc_caninter_xmes_cob_act a
group by segmento, canal
) a
left outer join (
select segmento, canal, sum(a.presup_mes) as "importe"
from fecxc_caninter_xmes_pre a
group by segmento, canal
) b on (a.segmento = b.segmento and a.canal = b.canal)
union
/*se agrega columna de importe real o actualizado*/
select 1 as orden,'DEL MES' as tipo, 'VARIACION REAL VS A?O ANTERIOR' as subtipo,a.segmento,a.canal,
( a.importe - coalesce(b.importe,0.00) ) as importe, ( a.importenom - coalesce(b.importenom,0.00) ) as "importenom"
from (
select segmento, canal, sum(a.cobranza_mes) as importe,sum(a.cobranza_mes) as "importenom"
from fecxc_caninter_xmes_cob_act a
group by  segmento, canal
) a
left outer join (
/*se sumariza columna adicional*/
select segmento, canal, sum(a.cobranza_mes) as importe, sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_xmes_cob_ant a
group by segmento, canal
) b on (a.segmento = b.segmento and a.canal = b.canal)
union
select a.orden, a.tipo, a.subtipo, a.segmento, a.canal, a.importe, a.importenom
from (
select 2 as orden,'A LA FECHA' as tipo, 'A?O ANTERIOR' as subtipo, segmento, canal, sum(a.cobranza_mes) as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_ant a
group by  segmento, canal
union
select 2 as orden,'A LA FECHA' as tipo, 'REAL' as subtipo, segmento, canal, sum(a.cobranza_mes) as importe,
sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by segmento, canal
union
select 2 as orden,'A LA FECHA' as tipo, 'PRESUPUESTO' as subtipo, segmento, canal, sum(a.presup_mes) as importe,
sum(a.presupreal_mes) as "importenom"
from fecxc_caninter_alafecha_pre a
group by segmento, canal
union
select 2 as orden,'A LA FECHA' as tipo, 'VAR REAL VS PPTO' as subtipo,a.segmento,a.canal,
( a.importe - coalesce(b.importe,0.00) ) as importe,
( a.importenom - coalesce(b.importenom,0.00) ) as "importenom"
from (
select segmento, canal, sum(a.cobranza_mes) as importe, sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by segmento, canal
) a
left outer join (
select segmento, canal, sum(a.presup_mes) as importe, sum(a.presupreal_mes) as "importenom"
from fecxc_caninter_alafecha_pre a
group by segmento, canal
) b on (a.segmento = b.segmento and a.canal = b.canal)
union
select 2 as orden,'A LA FECHA' as tipo, 'VARIACION REAL VS A?O ANTERIOR' as subtipo,a.segmento,a.canal,
( a.importe - coalesce(b.importe,0.00) ) as importe, ( a.importenom - coalesce(b.importenom,0.00) ) as "importenom"
from (
select segmento, canal, sum(a.cobranza_mes) as importe, sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_act a
group by  segmento, canal
) a
left outer join (
select segmento, canal, sum(a.cobranza_mes) as importe, sum(a.cobranzareal_mes) as "importenom"
from fecxc_caninter_alafech_cob_ant a
group by segmento, canal
) b on (a.segmento = b.segmento and a.canal = b.canal) ) a
) a,
fecxc_det_catalogos b,
fecxc_det_catalogos c
where a.segmento = b.cod_sec_lin
and  b.tipo_cat = 'SEGMENTO'
and  a.canal = c.cod_sec_lin
and (
c.tipo_cat = 'CANAL'
or c.tipo_cat = 'REGION'
or c.tipo_cat = 'DIVISION'
);/* dmap converted statement end */
-- estimed cost of view [ fecxc_cobranza_intermex_v ]: 1.00;
