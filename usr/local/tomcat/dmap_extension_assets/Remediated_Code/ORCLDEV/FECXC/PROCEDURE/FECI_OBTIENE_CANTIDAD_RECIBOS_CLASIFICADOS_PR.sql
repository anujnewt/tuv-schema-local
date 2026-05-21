create or replace procedure fecxc."feci_obtiene_cantidad_recibos_clasificados_pr"  (INOUT feci_cursor refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;

begin 

-- utiliza la variable p_contador para almacenar el conteo
open feci_cursor for
select count(*) as cantidad
from fecxc.feci_recibos_vw
where cod_estado_recibo = 'CLSF';
end;
$body$
language plpgsql
;
