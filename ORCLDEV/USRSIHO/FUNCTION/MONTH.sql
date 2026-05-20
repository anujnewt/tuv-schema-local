create or replace  function  usrsiho."month"  (ws_dat timestamp(0)) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de conceptos por proceso.
wn_month integer;
begin
select extract(month from ws_dat)
into strict wn_month
;
return wn_month;end;
--dmap converted function completed
$body$
language plpgsql
stable;
