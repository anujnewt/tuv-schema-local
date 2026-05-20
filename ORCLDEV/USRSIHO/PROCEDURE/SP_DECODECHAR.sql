create or replace procedure usrsiho."sp_decodechar"  (ws_datcom1 varchar, ws_datcom2 varchar, ws_datif varchar, ws_datelse varchar, ws_datsal inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
if ws_datcom1 = ws_datcom2 then
ws_datsal := ws_datif;
else
ws_datsal := ws_datelse;
end if;end;
$body$
language plpgsql
;
