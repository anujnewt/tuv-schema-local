create or replace procedure feci."feci_modifica_confi_semanas_pr"  ( p_id numeric, p_anio numeric, p_mes numeric, p_fecha_inicio_sem_1 timestamp(0), p_fecha_fin_sem_1 timestamp(0), p_fecha_inicio_sem_2 timestamp(0), p_fecha_fin_sem_2 timestamp(0), p_fecha_inicio_sem_3 timestamp(0), p_fecha_fin_sem_3 timestamp(0), p_fecha_inicio_sem_4 timestamp(0), p_fecha_fin_sem_4 timestamp(0), p_fecha_inicio_sem_5 timestamp(0), p_fecha_fin_sem_5 timestamp(0), p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_semanas_estimacion_tab
set
fec_inicio_semana_1 = to_timestamp(to_char(p_fecha_inicio_sem_1, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_fin_semana_1 = to_timestamp(to_char(p_fecha_fin_sem_1, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_inicio_semana_2 = to_timestamp(to_char(p_fecha_inicio_sem_2, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_fin_semana_2 = to_timestamp(to_char(p_fecha_fin_sem_2, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_inicio_semana_3 = to_timestamp(to_char(p_fecha_inicio_sem_3, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_fin_semana_3 = to_timestamp(to_char(p_fecha_fin_sem_3, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_inicio_semana_4 = to_timestamp(to_char(p_fecha_inicio_sem_4, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_fin_semana_4 = to_timestamp(to_char(p_fecha_fin_sem_4, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_inicio_semana_5 = to_timestamp(to_char(p_fecha_inicio_sem_5, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_fin_semana_5 = to_timestamp(to_char(p_fecha_fin_sem_5, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario
where
id_semanas_estimacion = p_id;end;
$body$
language plpgsql
;
