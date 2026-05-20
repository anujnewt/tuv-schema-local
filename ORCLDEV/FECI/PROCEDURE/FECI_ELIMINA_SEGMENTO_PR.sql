create or replace procedure feci."feci_elimina_segmento_pr"  ( p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_segmento_cat
set ind_estado = 0,
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where id_segmento = p_id;end;
$body$
language plpgsql
;
