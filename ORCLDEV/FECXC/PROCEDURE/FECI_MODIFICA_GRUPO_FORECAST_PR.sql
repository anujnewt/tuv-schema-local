create or replace procedure fecxc."feci_modifica_grupo_forecast_pr"  ( p_codigo varchar, p_descripcion varchar, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_grupo_forecast_cat
set cod_grupo_forecast = p_codigo,
des_grupo_forecast = p_descripcion,
id_usuario_ult_modif = p_usuario
where id_grupo_forecast = p_id;end;
$body$
language plpgsql
;
