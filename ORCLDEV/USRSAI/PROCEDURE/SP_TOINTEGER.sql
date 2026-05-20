create or replace procedure usrsai."sp_tointeger"  (ws_cadena varchar,wd_valor inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
wd_valor:=ws_cadena;end;
$body$
language plpgsql
;
