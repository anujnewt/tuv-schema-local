create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_aut_urgente_pr ( p_id_solicitud numeric, poinnum_auts inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
execute 'ALTER SESSION SET NLS_TERRITORY=MEXICO;' ; /* dmap converted statement */
end;/* dmap converted statement start */
insert into xxlmk_autorizaciones_tab(id_aut, id_orden, ind_estatus,
ind_tipo_aut, ind_nivel, num_linea,
des_aut,
fec_creacion, cve_creado_por,
fec_actualizacion, cve_actualizado_por
)
select nextval('xxlmk_autorizaciones_sq'), id_ordhdr, 1,
'URG', 'L', num_linea,
concat('Autorizacin - Linea URGENTE: La linea tiene transmisiones que estan fuera de la hora de cierre (', to_char(c.dia_cierre_ini,'DD/MM/YYYY hh24:mi'), ')') ,
clock_timestamp(), 'System',
clock_timestamp(), 'System'
from   xxlmk_ordln_tab d,
(select ind_tipo_orden,
num_dia,
num_dia_cierre,
concat(num_hora_cierre, ':', num_minuto_cierre)  as hora_cierre,
to_char(clock_timestamp(),'D') hoy,
case when num_dia = (to_char(clock_timestamp(),'D'))::numeric  then
to_date( concat(to_char(clock_timestamp(), 'yyyymmdd'), ' ', num_hora_cierre, ':', num_minuto_cierre) ,'YYYYMMDD HH24:MI')
end as dia_cierre_ini,
next_day(to_date( concat(to_char(clock_timestamp(), 'yyyymmdd'), '23:59:59') ,'YYYYMMDDHH24:MI:SS'),
case when num_dia_cierre=1 then  'MON' when num_dia_cierre=2 then  'TUE' when num_dia_cierre=3 then  'WED' when num_dia_cierre=4 then  'THU' when num_dia_cierre=5 then  'FRI' when num_dia_cierre=6 then  'SAT' when num_dia_cierre=7 then  'SUN' end
) as dia_cierre_fin
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
/*and    not exists        (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud     = d.id_solicitud
and    c.numlinea_concom  = d.linea
and    c.numlinea_concom  is not null
and    c.campo_concom     = urgente
and    to_number(d.linea) = to_number(c.numlinea_concom)
)
and not exists           (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    c.numlinea_concom      is not null
and    upper(c.accion_concom) = rechazo
and    to_number(d.linea)     = to_number(c.numlinea_concom)
)
and exists               (select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    er.estat_id_foraneo is null
)*/
get diagnostics poinnum_auts = row_count;/* dmap converted statement end */
exception
when others then
poinnum_auts := 0;end;
$body$
language plpgsql
;
