-- dmap_object_gen_tag : type : view name : xxlmk_rep_dur_brks_plat_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_rep_dur_brks_plat_vw"  ("id_ajuste_breaks", "id_canal", "num_break", "des_can_psp", "ind_nivel", "des_nivel", "num_brek_nom_time", "num_venta", "num_capacidad_ini", "venta_plat", "num_ajuste", "des_venta", "des_capacidad_ini", "des_venta_plat", "des_ajuste", "plat", "min_brk_time", "num_duracion", "des_duracion", "capacidad_plat", "des_capacidad_plat", "id_grupo") as select
id_ajuste_breaks,
id_canal,
num_break,
des_can_psp,
ind_nivel,
case when ind_nivel=1 then  'Network' when ind_nivel=2 then  'Nacional' when ind_nivel=3 then  'Regional' when ind_nivel=4 then  'Nacional'  else '' end  as des_nivel,
num_brek_nom_time,
num_venta,
num_capacidad_ini,
venta_plat,
num_ajuste,
to_char(to_timestamp(num_venta, 'sssss'),  'hh24:mi:ss')         as des_venta,
to_char(to_timestamp(num_capacidad_ini, 'sssss'),  'hh24:mi:ss') as des_capacidad_ini,
to_char(to_timestamp(venta_plat, 'sssss'),  'hh24:mi:ss')        as des_venta_plat,
case
when num_ajuste < 0
then num_ajuste||''
else to_char(to_timestamp(num_ajuste, 'sssss'),  'hh24:mi:ss')
end as des_ajuste,
plat,
min_brk_time,
xxmor.xxlmk_ordlmk_pkg_xxlmk_can_dur_exept_conf_fun(id_ajuste_breaks,  id_grupo,  num_break_base)
as duracion,
xxmor.xxlmk_ordlmk_pkg_xxlmk_can_dur_exept_fmt_fun(id_ajuste_breaks,  id_grupo,  num_break_base)
as des_duracion,
capacidad_plat,
to_char(to_timestamp(coalesce(capacidad_plat,  0), 'sssss'),  'hh24:mi:ss') as des_capacidad_plat,
id_grupo
from (
select
abv.id_ajuste_breaks,
abv.id_canal,
abv.num_break,
cl.des_can_psp,
cl.ind_nivel,
durs.break_time,
abv.num_brek_nom_time,
abv.num_capacidad_ini,
abv.num_venta,
abv.num_ajuste,
durs.venta_plat,
'Izzi' as plat,
durs.min_brk_time,
coalesce(adc.num_dur_conf, coalesce(gc.num_duracion, 0)) as num_duracion,
durs.capacidad_plat,
gc.id_grupo,
abv.num_break_base
from
xxmor.xxlmk_ajus_brks_vals_tab abv
join
xxmor.xxlmk_grup_can_niv_tab gcn
on
abv.id_canal = gcn.id_canal
join
xxmor.xxlmk_grupos_canales_tab gc
on
gcn.id_grupo = gc.id_grupo
join
xxmor.xxlmk_canales_lmk_tab cl
on
abv.id_canal = cl.id_canal
left join
xxmor.xxlmk_ajus_dur_conf_grp_tab adc
on
abv.id_ajuste_breaks = adc.id_ajuste_breaks
and adc.id_grupo = gc.id_grupo
and adc.num_break_time = abv.num_break_base
join(
select
gcn.id_grupo,
abv.num_break_base as break_time,
abv.id_ajuste_breaks,
sum(abv.num_venta)         as venta_plat,
min(abv.num_brek_nom_time) as min_brk_time,
sum(abv.num_capacidad_ini) as "capacidad_plat"
from
xxmor.xxlmk_ajus_brks_vals_tab abv
join
xxmor.xxlmk_grup_can_niv_tab gcn
on
abv.id_canal = gcn.id_canal
join
xxmor.xxlmk_canales_lmk_tab cl
on
abv.id_canal = cl.id_canal
where
cl.ind_nivel in (1,
2,
3)
group by
gcn.id_grupo,
abv.id_ajuste_breaks,
abv.num_break_base) durs
on
abv.id_ajuste_breaks = durs.id_ajuste_breaks
and gcn.id_grupo = durs.id_grupo
and abv.num_break_base = durs.break_time
where
cl.ind_nivel in (1,
2,
3)
union
select
abv.id_ajuste_breaks,
abv.id_canal,
abv.num_break,
cl.des_can_psp,
cl.ind_nivel,
durs.break_time,
abv.num_brek_nom_time,
abv.num_capacidad_ini,
abv.num_venta,
abv.num_ajuste,
durs.venta_plat,
'Sky' as plat,
durs.min_brk_time,
coalesce(adc.num_dur_conf, coalesce(gc.num_duracion, 0)) as num_duracion,
durs.capacidad_plat,
gc.id_grupo,
abv.num_break_base
from
xxmor.xxlmk_ajus_brks_vals_tab abv
join
xxmor.xxlmk_grup_can_niv_tab gcn
on
abv.id_canal = gcn.id_canal
join
xxmor.xxlmk_grupos_canales_tab gc
on
gcn.id_grupo = gc.id_grupo
join
xxmor.xxlmk_canales_lmk_tab cl
on
abv.id_canal = cl.id_canal
left join
xxmor.xxlmk_ajus_dur_conf_grp_tab adc
on
abv.id_ajuste_breaks = adc.id_ajuste_breaks
and adc.id_grupo = gc.id_grupo
and adc.num_break_time = abv.num_break_base
join(
select
gcn.id_grupo,
num_break_base as break_time,
abv.id_ajuste_breaks,
sum(abv.num_venta)         as venta_plat,
min(abv.num_brek_nom_time) as min_brk_time,
sum(abv.num_capacidad_ini) as "capacidad_plat"
from
xxmor.xxlmk_ajus_brks_vals_tab abv
join
xxmor.xxlmk_grup_can_niv_tab gcn
on
abv.id_canal = gcn.id_canal
join
xxmor.xxlmk_canales_lmk_tab cl
on
abv.id_canal = cl.id_canal
where
cl.ind_nivel in (1,
4)
group by
gcn.id_grupo,
abv.id_ajuste_breaks,
abv.num_break_base) durs
on
abv.id_ajuste_breaks = durs.id_ajuste_breaks
and gcn.id_grupo = durs.id_grupo
and abv.num_break_base = durs.break_time
where
cl.ind_nivel in (1,
4) ) alias29
order by
id_ajuste_breaks,
id_grupo,
break_time,
plat,
num_brek_nom_time,
ind_nivel;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_rep_dur_brks_plat_vw ]: 1.10;
