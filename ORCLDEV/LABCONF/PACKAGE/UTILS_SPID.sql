create or replace  function  labconf.utils_spid () returns numeric as $body$
begin 

return userenv('sessionid');end;
$body$
language plpgsql
stable;
