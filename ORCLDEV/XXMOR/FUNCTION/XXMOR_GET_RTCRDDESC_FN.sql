create or replace  function  xxmor."xxmor_get_rtcrddesc_fn"  (p_id_solicitud numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(350);
begin
select replace(e.rtcrddscr, am.ca_rtcrd_substr, am.ca_rtcrd_aux)
into strict resultado
from  xxmor_solicitudes_enc_tab e,
xxmor_cat_agrupador_mult_tab am
where id_solicitud     = p_id_solicitud
and e.agrupador      = am.agrupador_multiple
and am.prefijo_canal = (
select oracle.substr(stnid,0,2)
from xxmor_solicitudes_det_tab d
where d.id_solicitud = e.id_solicitud
limit 1);
return resultado;
exception
when no_data_found then
return null;
when too_many_rows then
return null;
when others then
return null;end;
--dmap converted function completed
$body$
language plpgsql
stable;
