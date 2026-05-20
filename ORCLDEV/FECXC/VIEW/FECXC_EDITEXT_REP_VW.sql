-- dmap_object_gen_tag : type : view name : fecxc_editext_rep_vw
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_editext_rep_vw"  ("division_desc", "concepto_desc", "cobranza_dia", "cobranza_mes", "presup_mes", "variacion_mes", "perc_mes", "cobranza_alafecha", "presup_alafecha", "variacion_alafecha", "perc_alafecha", "cobranza_anterior", "variacion_anterior", "perc_anterior") as select case when nullif(division_desc::text,  '') is null and nullif(concepto_desc::text,  '') is null then '~TOTAL EDITORIAL EXTRANJERO'
else division_desc
end as division_desc,
case when nullif(concepto_desc::text,  '') is null and nullif(division_desc::text,  '') is not null then '~TOTAL ' || division_desc
else concepto_desc
end as concepto_desc,
cobranza_dia,  cobranza_mes,  presup_mes,  variacion_mes,  perc_mes,
cobranza_alafecha,  presup_alafecha,  variacion_alafecha,  perc_alafecha,
cobranza_anterior,  variacion_anterior,  perc_anterior
from fecxc_editext_paso_vw;/* dmap converted statement end */
-- estimed cost of view [ fecxc_editext_rep_vw ]: 1.10;
