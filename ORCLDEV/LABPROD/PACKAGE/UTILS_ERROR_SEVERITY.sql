create or replace  function  labprod.utils_error_severity () returns varchar as $body$
begin 

return '0';end;
$body$
language plpgsql
stable;
