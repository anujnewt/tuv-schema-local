create or replace procedure fecxc."feci_modifica_iva_pr"  ( p_codigo varchar, p_valor numeric, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_porcentaje_iva_cat
set cod_porcentaje_iva = p_codigo,
num_valor = p_valor,
id_porcentaje_iva = p_usuario
where id_porcentaje_iva = p_id;end;
$body$
language plpgsql
;
