create or replace procedure feci."feci_modifica_moneda_pr"  ( p_codigo varchar, p_descripcion varchar, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_moneda_cat
set cod_moneda = p_codigo,
des_moneda = p_descripcion,
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where id_moneda = p_id;end;
$body$
language plpgsql
;
