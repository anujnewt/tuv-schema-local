create or replace procedure feci."feci_modifica_iva_pr"  ( p_codigo varchar, p_descripcion numeric, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_porcentaje_iva_cat
set
cod_porcentaje_iva = p_codigo,
num_valor = p_descripcion,
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where id_porcentaje_iva = p_id;end;
$body$
language plpgsql
;
