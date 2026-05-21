create or replace procedure fecxc."feci_obtener_operaciones_pr"  (INOUT feci_cursor refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;

begin 

open feci_cursor for
select
id_operacion,
des_agrupador,
cod_operacion,
des_nombre,
des_nombre,
cod_tipo_operacion
from feci_operacion_tab 
where ind_estado =1;
end;
$body$
language plpgsql
;
