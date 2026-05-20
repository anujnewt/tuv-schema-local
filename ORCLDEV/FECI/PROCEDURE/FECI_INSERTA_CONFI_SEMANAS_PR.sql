create or replace procedure feci."feci_inserta_confi_semanas_pr"  ( p_anio numeric, p_mes numeric, p_fecha_inicio_sem_1 timestamp(0), p_fecha_fin_sem_1 timestamp(0), p_fecha_inicio_sem_2 timestamp(0), p_fecha_fin_sem_2 timestamp(0), p_fecha_inicio_sem_3 timestamp(0), p_fecha_fin_sem_3 timestamp(0), p_fecha_inicio_sem_4 timestamp(0), p_fecha_fin_sem_4 timestamp(0), p_fecha_inicio_sem_5 timestamp(0) default null, p_fecha_fin_sem_5 timestamp(0) default null, p_usuario numeric  default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin
insert into feci_semanas_estimacion_tab(
num_anio ,num_mes,
fec_inicio_semana_1,fec_fin_semana_1,
fec_inicio_semana_2,fec_fin_semana_2,
fec_inicio_semana_3,fec_fin_semana_3,
fec_inicio_semana_4,fec_fin_semana_4,
fec_inicio_semana_5,fec_fin_semana_5,
fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado)
values (
p_anio,p_mes,
to_timestamp(to_char(p_fecha_inicio_sem_1, 'yyyy-MM-dd'),'yyyy-MM-dd'),to_timestamp(to_char(p_fecha_fin_sem_1, 'yyyy-MM-dd'),'yyyy-MM-dd'),
to_timestamp(to_char(p_fecha_inicio_sem_2, 'yyyy-MM-dd'),'yyyy-MM-dd'),to_timestamp(to_char(p_fecha_fin_sem_2, 'yyyy-MM-dd'),'yyyy-MM-dd'),
to_timestamp(to_char(p_fecha_inicio_sem_3, 'yyyy-MM-dd'),'yyyy-MM-dd'),to_timestamp(to_char(p_fecha_fin_sem_3, 'yyyy-MM-dd'),'yyyy-MM-dd'),
to_timestamp(to_char(p_fecha_inicio_sem_4, 'yyyy-MM-dd'),'yyyy-MM-dd'),to_timestamp(to_char(p_fecha_fin_sem_4, 'yyyy-MM-dd'),'yyyy-MM-dd'),
to_timestamp(to_char(p_fecha_inicio_sem_5, 'yyyy-MM-dd'),'yyyy-MM-dd'),to_timestamp(to_char(p_fecha_fin_sem_5, 'yyyy-MM-dd'),'yyyy-MM-dd'),
clock_timestamp(),clock_timestamp(),p_usuario,0,1
)
returning id_semanas_estimacion into id_registro;
open feci_cursors for
select id_semanas_estimacion from feci_semanas_estimacion_tab where id_semanas_estimacion =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
