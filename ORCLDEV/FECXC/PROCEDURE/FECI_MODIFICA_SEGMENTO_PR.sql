create or replace procedure fecxc."feci_modifica_segmento_pr"  ( p_codigo varchar, p_descripcion varchar, p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_segmento_cat
set cod_segmento = p_codigo,
des_segmento = p_descripcion,
id_usuario_ult_modif = p_usuario
where id_segmento = p_id;end;
$body$
language plpgsql
;
