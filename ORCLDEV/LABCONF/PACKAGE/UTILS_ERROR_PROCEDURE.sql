create or replace  function  labconf.utils_error_procedure () returns varchar as $body$
begin 

return '0';end;
$body$
language plpgsql
stable;
