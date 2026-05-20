create or replace  function  labprod."f_is_int"  (p_cadena varchar) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_numero integer;
begin
if nullif(p_cadena::text, '') is not null then
v_numero := (replace(p_cadena, ',', '') )::numeric;
if v_numero = 0 then
v_numero :=1;
end if;
return v_numero;
else
return 0;
end if;
exception
when data_exception then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
