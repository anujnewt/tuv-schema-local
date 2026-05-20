create or replace  function  labconf.utils_error_line () returns varchar as $body$
begin 

return '0';end;
$body$
language plpgsql
stable;
