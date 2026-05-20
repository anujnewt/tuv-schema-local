create or replace procedure usrsiho."sp_lee_serial"  (li_serial inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select max(rep_keyrep)
into strict   li_serial
from   usrsiho.holorepo;
exception when no_data_found then li_serial := 0;end;
$body$
language plpgsql
;
