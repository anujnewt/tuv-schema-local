create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_aut_urgente2_pr ( p_id_solicitud numeric, poinnum_auts inout numeric ) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
aut_lns cursor for
select  id_ordhdr, num_linea,
'Autorizacin - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre ('||to_char(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi')||')' as desc_aut
from   xxlmk_ordln_tab d,
(select ind_tipo_orden,
num_dia,
num_dia_cierre,
num_hora_cierre||':'||num_minuto_cierre as hora_cierre,
to_char(clock_timestamp(),'D') hoy,
case when num_dia = (to_char(clock_timestamp(),'D'))::numeric  then
to_date(to_char(clock_timestamp(), 'yyyymmdd')
||' '||num_hora_cierre||':'||num_minuto_cierre,'YYYYMMDD HH24:MI')
end as dia_cierre_ini,
next_day(to_date(to_char(clock_timestamp(), 'yyyymmdd')||'23:59:59','YYYYMMDDHH24:MI:SS'), num_dia_cierre) as dia_cierre_fin
from   xxlmk_conf_ord_urg_tab
) c
where  id_ordhdr = p_id_solicitud
and    nullif(c.dia_cierre_ini::text, '') is not null
and    to_char(to_timestamp(xxlmk_ordlmk_pkg_xxlmk_sol_fechas_fun(id_ordhdr, num_linea, 'F_1A_T'),'YYYYMMDd'),'D') = c.num_dia_cierre
and    to_timestamp(xxlmk_ordlmk_pkg_xxlmk_sol_fechas_fun(id_ordhdr, num_linea, 'F_1A_T'),'yyyymmdd')
between trunc(c.dia_cierre_ini+1) and trunc(c.dia_cierre_fin)
and    clock_timestamp() > c.dia_cierre_ini
and    c.ind_tipo_orden = (select ind_tipo_orden
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id_solicitud
)
and not exists (select 1 from xxlmk_autorizaciones_tab a where a.id_orden = id_ordhdr and a.ind_tipo_aut = 'URG' );
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
execute 'ALTER SESSION SET NLS_TERRITORY=MEXICO;' ; /* dmap converted statement */
end;
poinnum_auts := 0;
for aut_ln in aut_lns
loop
insert into xxlmk_autorizaciones_tab(id_aut, id_orden, ind_estatus,
ind_tipo_aut, ind_nivel, num_linea,
des_aut,
fec_creacion, cve_creado_por,
fec_actualizacion, cve_actualizado_por
)
values (nextval('xxlmk_autorizaciones_sq'), aut_ln.id_ordhdr, 1,
'URG', 'L', aut_ln.num_linea,
aut_ln.desc_aut,
clock_timestamp(), 'System',
clock_timestamp(), 'System');
get diagnostics ora2pg_rowcount = row_count;
poinnum_auts := poinnum_auts +  ora2pg_rowcount;
update  xxlmk_ordln_tab
set     ind_estatus = 3
where   id_ordhdr = p_id_solicitud
and     num_linea = aut_ln.num_linea;
end loop;end;
$body$
language plpgsql
;
