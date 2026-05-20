create or replace  function  labconf."year"  (ws_dat timestamp(0)) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de conceptos por proceso.
wn_year integer;
begin
select extract(year from ws_dat)
into strict wn_year
;
return wn_year;end;
--dmap converted function completed
$body$
language plpgsql
stable;
