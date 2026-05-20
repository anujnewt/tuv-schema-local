create or replace  function  xxmor."xxmor_get_agrupador_mult_fn"  (p_id_solicitud numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado numeric;
begin
select count(agrupador_multiple)
into strict   resultado
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (
select trim(both agrupador)
from  xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
);
return resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
