create or replace procedure fecxc."feci_modifica_empresa_pr"  ( p_codigo varchar, p_descripcion varchar, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_empresa_cat
set cod_empresa = p_codigo,
des_empresa = p_descripcion,
id_usuario_ult_modif = p_usuario
where id_empresa = p_id;end;
$body$
language plpgsql
;
