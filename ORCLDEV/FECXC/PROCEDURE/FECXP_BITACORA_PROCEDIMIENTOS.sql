create or replace procedure fecxc."fecxp_bitacora_procedimientos"  ( p_usuario_id varchar, p_proceso_numero integer, p_accion varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_version_perp		varchar(100);
v_version_psoin		varchar(100);
v_version_orden		varchar(100);
v_catalogo_perp		varchar(100) := 'FECXP_POLITICAS_ERP';
v_catalogo_psoin	varchar(100) := 'FECXP_POLITICAS_SOIN';
v_catalogo_orden	varchar(100) := 'FECXP_CLASIFICACION_FE';
v_proceso_nombre 	varchar(100);
v_dummy				varchar(100);
begin 

v_proceso_nombre :=
case p_proceso_numero
when 1 then 'FECXP_LLENA_CARATULA_REAL'
when 2 then 'FECXP_LLENA_CARATULA_FORESCAST'
when 3 then 'FECXP_LLENA_CARATULA_PPTO'
when 4 then 'FECXP_LLENA_DET_CONT_ERP'
when 5 then 'FECXP_LLENA_DET_CONT_SOIN'
when 6 then 'FECXP_LLENA_CARATULA_REALD/FECXP_LLENA_CARATULA_PPTO'
when 7 then 'FECXP_POSTEA_COMPARATIVO'
when 8 then 'FECXP_POSTEA_FORECAST'
when 9 then 'FECXP_POSTEA_COMPARATIVO_D'
else 'OTRO PROCESO'
end;
if p_accion = 'INICIO' then
select nextval('sec_ejecucion_proceso') into strict v_dummy;
end if;
select distinct version_id into strict v_version_perp from fecxp_politicas_erp;
select distinct version_id into strict v_version_psoin from fecxp_politicas_soin;
select distinct version_id into strict v_version_orden from fecxp_clasificacion_fe;
if p_proceso_numero >= 7 then
v_version_perp  := '0';
v_version_psoin := '0';
v_version_orden := '0';
v_catalogo_perp := 'N/A';
v_catalogo_psoin := 'N/A';
v_catalogo_orden := 'N/A';
end if;
insert into fecxp_b_ejecucion_proceso(id_proceso, proceso_nombre,   catalogo_nombre,	 version_id,   accion,   usuario_id, fecha_creacion)
select currval('sec_ejecucion_proceso'), 			v_proceso_nombre, v_catalogo_perp,   v_version_perp, p_accion, p_usuario_id, clock_timestamp()
;
if p_proceso_numero < 7 then
insert into fecxp_b_ejecucion_proceso(id_proceso, proceso_nombre,   catalogo_nombre,	 version_id,   accion,   usuario_id, fecha_creacion)
select currval('sec_ejecucion_proceso'), 			v_proceso_nombre, v_catalogo_psoin,   v_version_psoin, p_accion, p_usuario_id, clock_timestamp()
;
insert into fecxp_b_ejecucion_proceso(id_proceso, proceso_nombre,   catalogo_nombre,	 version_id,   accion,   usuario_id, fecha_creacion)
select currval('sec_ejecucion_proceso'), 			v_proceso_nombre, v_catalogo_orden,   v_version_orden, p_accion, p_usuario_id, clock_timestamp()
;
end if;
/* commit; */
end;
$body$
language plpgsql
;
