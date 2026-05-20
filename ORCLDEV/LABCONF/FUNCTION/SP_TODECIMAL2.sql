create or replace  function  labconf."sp_todecimal2"  (ws_cadena varchar) returns decimal as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_valor decimal(12,2);
begin
wd_valor := ws_cadena;
return wd_valor;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
