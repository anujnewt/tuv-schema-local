create or replace procedure fecxc."feci_modifica_tipo_cambio_pr"  ( p_fecha varchar, p_codigo varchar, p_valor numeric, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_tipo_cambio_cat
set fec_fecha_tc = to_timestamp(to_char(p_fecha, 'YYYY-MM-DD'),'YYYY-MM-DD'),
cod_moneda = p_codigo,
num_valor = p_valor,
id_usuario_ult_modif = p_usuario
where id_tipo_cambio = p_id;end;
$body$
language plpgsql
;
