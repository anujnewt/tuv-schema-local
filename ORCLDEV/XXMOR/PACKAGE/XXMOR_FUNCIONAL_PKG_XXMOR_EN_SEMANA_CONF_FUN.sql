create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_en_semana_conf_fun ( p_dia_inicio varchar, p_hora_inicio varchar, p_dia_fin varchar, p_hora_fin varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
d_aux_fin           integer;
d_aux_ini           integer;
d_aux_hoy           integer;
d_aux_hoy_nombre    varchar(23);
v_resultado         integer;
v_fec_ini           timestamp(0);
v_fec_fin           timestamp(0);
v_fec_hoy           timestamp(0);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
begin
execute 'ALTER SESSION SET NLS_TERRITORY=MEXICO;' ; /* dmap converted statement */
end;
select trim(both to_char(clock_timestamp(),'DAY','nls_date_language=spanish'))
into strict d_aux_hoy_nombre
;/* dmap converted statement start */
perform dbms_output.put_line( concat(' dia hoy: ', d_aux_hoy_nombre)  );/* dmap converted statement end */
if p_dia_inicio = 'LUNES' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 1
when 'MARTES'       then 2
when 'MIERCOLES'    then 3
when 'JUEVES'       then 4
when 'VIERNES'      then 5
when 'SABADO'       then 6
when 'DOMINGO'      then 7
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 1
when 'MARTES'       then 2
when 'MIERCOLES'    then 3
when 'JUEVES'       then 4
when 'VIERNES'      then 5
when 'SABADO'       then 6
when 'DOMINGO'      then 7
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 1
when 'MARTES'       then 2
when 'MIERCOLES'    then 3
when 'JUEVES'       then 4
when 'VIERNES'      then 5
when 'SABADO'       then 6
when 'DOMINGO'      then 7
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio = 'MARTES' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 7
when 'MARTES'       then 1
when 'MIERCOLES'    then 2
when 'JUEVES'       then 3
when 'VIERNES'      then 4
when 'SABADO'       then 5
when 'DOMINGO'      then 6
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 7
when 'MARTES'       then 1
when 'MIERCOLES'    then 2
when 'JUEVES'       then 3
when 'VIERNES'      then 4
when 'SABADO'       then 5
when 'DOMINGO'      then 6
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 7
when 'MARTES'       then 1
when 'MIERCOLES'    then 2
when 'JUEVES'       then 3
when 'VIERNES'      then 4
when 'SABADO'       then 5
when 'DOMINGO'      then 6
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio =   'MIERCOLES' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 6
when 'MARTES'       then 7
when 'MIERCOLES'    then 1
when 'JUEVES'       then 2
when 'VIERNES'      then 3
when 'SABADO'       then 4
when 'DOMINGO'      then 5
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 6
when 'MARTES'       then 7
when 'MIERCOLES'    then 1
when 'JUEVES'       then 2
when 'VIERNES'      then 3
when 'SABADO'       then 4
when 'DOMINGO'      then 5
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 6
when 'MARTES'       then 7
when 'MIERCOLES'    then 1
when 'JUEVES'       then 2
when 'VIERNES'      then 3
when 'SABADO'       then 4
when 'DOMINGO'      then 5
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio =  'JUEVES' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 5
when 'MARTES'       then 6
when 'MIERCOLES'    then 7
when 'JUEVES'       then 1
when 'VIERNES'      then 2
when 'SABADO'       then 3
when 'DOMINGO'      then 4
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 5
when 'MARTES'       then 6
when 'MIERCOLES'    then 7
when 'JUEVES'       then 1
when 'VIERNES'      then 2
when 'SABADO'       then 3
when 'DOMINGO'      then 4
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 5
when 'MARTES'       then 6
when 'MIERCOLES'    then 7
when 'JUEVES'       then 1
when 'VIERNES'      then 2
when 'SABADO'       then 3
when 'DOMINGO'      then 4
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio =  'VIERNES' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 4
when 'MARTES'       then 5
when 'MIERCOLES'    then 6
when 'JUEVES'       then 7
when 'VIERNES'      then 1
when 'SABADO'       then 2
when 'DOMINGO'      then 3
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 4
when 'MARTES'       then 5
when 'MIERCOLES'    then 6
when 'JUEVES'       then 7
when 'VIERNES'      then 1
when 'SABADO'       then 2
when 'DOMINGO'      then 3
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 4
when 'MARTES'       then 5
when 'MIERCOLES'    then 6
when 'JUEVES'       then 7
when 'VIERNES'      then 1
when 'SABADO'       then 2
when 'DOMINGO'      then 3
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio = 'SABADO' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 3
when 'MARTES'       then 4
when 'MIERCOLES'    then 5
when 'JUEVES'       then 6
when 'VIERNES'      then 7
when 'SABADO'       then 1
when 'DOMINGO'      then 2
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 3
when 'MARTES'       then 4
when 'MIERCOLES'    then 5
when 'JUEVES'       then 6
when 'VIERNES'      then 7
when 'SABADO'       then 1
when 'DOMINGO'      then 2
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 3
when 'MARTES'       then 4
when 'MIERCOLES'    then 5
when 'JUEVES'       then 6
when 'VIERNES'      then 7
when 'SABADO'       then 1
when 'DOMINGO'      then 2
else 0 end
into strict  d_aux_hoy
;
elsif p_dia_inicio = 'DOMINGO' then
select
case upper(p_dia_inicio)
when 'LUNES'        then 2
when 'MARTES'       then 3
when 'MIERCOLES'    then 4
when 'JUEVES'       then 5
when 'VIERNES'      then 6
when 'SABADO'       then 7
when 'DOMINGO'      then 1
else 0 end
into strict  d_aux_ini
;
select
case upper(p_dia_fin)
when 'LUNES'        then 2
when 'MARTES'       then 3
when 'MIERCOLES'    then 4
when 'JUEVES'       then 5
when 'VIERNES'      then 6
when 'SABADO'       then 7
when 'DOMINGO'      then 1
else 0 end
into strict  d_aux_fin
;
select
case upper(d_aux_hoy_nombre)
when 'LUNES'        then 2
when 'MARTES'       then 3
when 'MIERCOLES'    then 4
when 'JUEVES'       then 5
when 'VIERNES'      then 6
when 'SABADO'       then 7
when 'DOMINGO'      then 1
else 0 end
into strict  d_aux_hoy
;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('dia_ini: ', d_aux_ini, '  dia fin', d_aux_fin, ' dia hoy: ', d_aux_hoy)) ;/* dmap converted statement end *//* dmap converted statement start */
select to_date( concat('2001010', to_char(d_aux_ini), ' ', p_hora_inicio) ,'YYYYMMDD HH24MI') as fec_ini,
to_date( concat('2001010', to_char(d_aux_fin), ' ', p_hora_fin) ,'YYYYMMDD HH24MI') as fec_fin,
to_date( concat('2001010', to_char(d_aux_hoy), ' ', to_char(clock_timestamp(),'HH24MI')) ,'YYYYMMDD HH24MI') as fec_hoy
into strict   v_fec_ini,
v_fec_fin,
v_fec_hoy
;/* dmap converted statement end */
if v_fec_hoy between  v_fec_ini and v_fec_fin then
v_resultado:= 0;
else
v_resultado:= 1;
end if;
return v_resultado;end;
$body$
language plpgsql
;
