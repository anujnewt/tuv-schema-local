create or replace  function  labprod."fn_nuevoperiodo"  (wn_pro_nue numeric, wn_pro_ori numeric, ws_per_ori varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- busca el period equivalente para el proceso nuevo en una transferencia sin cambio de n??mero de empleado
ws_per_nue varchar(7);
wd_fec_pag timestamp(0);
begin
begin
select per_fecpag into strict wd_fec_pag
from labprod.nmloperi
where per_keypro = wn_pro_ori
and per_keyper = ws_per_ori;
exception when no_data_found then
return ws_per_ori;
end;
select per_keyper into strict ws_per_nue
from labprod.nmloperi
where per_keypro = wn_pro_nue
and per_keynom = 1
and per_fecini <= wd_fec_pag
and per_fecfin >= wd_fec_pag;
return ws_per_nue;
exception when others then
return ws_per_ori;end;
--dmap converted function completed
$body$
language plpgsql
stable;
