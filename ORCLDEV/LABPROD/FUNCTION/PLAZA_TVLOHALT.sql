create or replace  function  labprod."plaza_tvlohalt"  (wn_key_emp numeric,ws_key_dep varchar) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_plz integer;
begin
select plz_keyplz into strict wn_key_plz from (select plz_keyplz from eocoplza
where plz_keyemp = wn_key_emp
and plz_keydep = ws_key_dep
order by  plz_keyplz
) alias0 limit 1;
return wn_key_plz;end;
--dmap converted function completed
$body$
language plpgsql
stable;
