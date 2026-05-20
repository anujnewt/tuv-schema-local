create or replace procedure fecxc."feci_elimina_moneda_pr"  ( p_id numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_moneda_cat
set ind_estado = 0,
id_usuario_ult_modif = p_usuario
where id_moneda = p_id;end;
$body$
language plpgsql
;
