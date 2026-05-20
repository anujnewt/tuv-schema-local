create or replace  function  xxmor."xxmor_existe_fza_vtas_fn"  ( p_i_id_fza_vtas numeric, p_i_agrupador varchar, p_i_region varchar, p_i_sufijo varchar, p_i_accthdrid varchar, p_i_usrchr varchar, p_i_sptchr varchar, p_i_inclusion numeric ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- cursor para verificar si la combinaci?
-- existe.
cur_valida_combinacion cursor(p_inclusion  numeric) for
select v.id_fza_ventas
from   xxmor_fzas_ventas_ids_vw v
where  v.agrupador        = p_i_agrupador
and    v.region           = p_i_region
and    coalesce(v.sufijo,'*')  = coalesce(p_i_sufijo,'*')
and    coalesce(v.cliente,'*') = coalesce(p_i_accthdrid,'*')
and    coalesce(v.usrchr,'|')  = coalesce(p_i_usrchr,'|')
and    v.sptchr           = p_i_sptchr
and    v.inclusion        = p_inclusion;
lin_fza_ventas      numeric;
begin
open cur_valida_combinacion(p_i_inclusion);
fetch cur_valida_combinacion
into  lin_fza_ventas;
if not found then
close cur_valida_combinacion;
lin_fza_ventas := 0;
/*if p_i_inclusion = 0 then
open cur_valida_combinacion(1);
fetch cur_valida_combinacion
into  lin_fza_ventas;
if cur_valida_combinacion%notfound then
lin_fza_ventas := 0;
end if;
close cur_valida_combinacion;
else
open cur_valida_combinacion(0);
fetch cur_valida_combinacion
into  lin_fza_ventas;
if cur_valida_combinacion%notfound then
lin_fza_ventas := 0;
end if;
close cur_valida_combinacion;
end if;*/
end if;
/*if lin_fza_ventas > 0 then
if lin_fza_ventas = p_i_id_fza_vtas then
lin_fza_ventas := 2;
else
lin_fza_ventas := 1;
end if;
end if;*/
return coalesce(lin_fza_ventas,0);
exception
when no_data_found then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
