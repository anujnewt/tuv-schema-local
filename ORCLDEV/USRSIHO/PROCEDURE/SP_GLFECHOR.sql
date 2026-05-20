create or replace procedure usrsiho."sp_glfechor"  (wd_fecha inout varchar, ws_hora inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
wd_fecha := to_char(clock_timestamp(), 'dd/mm/yyyy');
ws_hora  := to_char(clock_timestamp(), 'HH24:MI:SS');end;
$body$
language plpgsql
;
