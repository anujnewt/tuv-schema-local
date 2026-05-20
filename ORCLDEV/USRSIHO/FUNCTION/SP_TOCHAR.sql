create or replace  function  usrsiho."sp_tochar"  (ws_valor integer default null) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_valcer varchar(20);
wn_valint varchar(20);
ws_valrespuesta varchar(20);
/*on exception in  (-1213)
let wn_valcer = '';
return wn_valcer;
end exception;
let wn_valint = ws_valor;*/
begin
ws_valrespuesta:= null;
--  if ws_valor is null then
--    ws_valrespuesta := '';
--  else
ws_valrespuesta := to_char(ws_valor);
--  end if;
return ws_valrespuesta;end;
--dmap converted function completed
$body$
language plpgsql
stable;
