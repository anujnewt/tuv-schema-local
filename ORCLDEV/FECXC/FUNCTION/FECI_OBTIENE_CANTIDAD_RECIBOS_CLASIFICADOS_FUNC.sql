create or replace  function  fecxc."feci_obtiene_cantidad_recibos_clasificados_func"  () returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_contador numeric;
begin
-- utiliza la variable v_contador para almacenar el conteo
select count(*) into strict v_contador
from fecxc.feci_recibos_vw
where cod_estado_recibo = 'CLSF';
-- retorna el valor del contador
return v_contador;end;
--dmap converted function completed
$body$
language plpgsql
stable;
