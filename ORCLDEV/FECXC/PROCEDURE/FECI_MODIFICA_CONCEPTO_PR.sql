create or replace procedure fecxc."feci_modifica_concepto_pr"  ( p_codigo varchar, p_descripcion varchar, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_concepto_cat
set cod_concepto = p_codigo,
des_concepto = p_descripcion,
id_usuario_ult_modif = p_usuario
where id_concepto = p_id;end;
$body$
language plpgsql
;
