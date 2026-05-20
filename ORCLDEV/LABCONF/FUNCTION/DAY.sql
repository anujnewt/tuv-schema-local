create or replace  function  labconf."day"  (ws_dat timestamp(0)) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de conceptos por proceso.
wn_day integer;
begin
select extract(day from ws_dat)
into strict wn_day
;
return wn_day;end;
--dmap converted function completed
$body$
language plpgsql
stable;
