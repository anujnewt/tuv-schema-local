create or replace  function  labprod.utils_spid () returns numeric as $body$
begin 

return userenv('sessionid');end;
$body$
language plpgsql
stable;
