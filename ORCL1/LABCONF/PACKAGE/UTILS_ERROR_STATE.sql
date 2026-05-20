create or replace  function  labconf.utils_error_state () returns varchar as $body$
begin 

return '0';end;
utils;
$body$
language plpgsql
stable;
