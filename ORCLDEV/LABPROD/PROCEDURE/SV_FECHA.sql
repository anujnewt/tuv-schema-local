create or replace procedure labprod."sv_fecha"  ( fec inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open fec for
select to_char(clock_timestamp(),'yyyy-MM-dd'), min(vac_keyemp) from nmcocvac;end;
$body$
language plpgsql
;
