create or replace procedure fecxc."feci_modifica_presupuesto_pr"  ( p_importe numeric, p_id numeric, p_id_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_presupuesto_tab
set num_importe = p_importe,
id_usuario_ult_modif = p_id_usuario
where id_presupuesto = p_id;end;
$body$
language plpgsql
;
