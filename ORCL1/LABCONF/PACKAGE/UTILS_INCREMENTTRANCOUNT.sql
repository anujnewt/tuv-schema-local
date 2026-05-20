create or replace procedure labconf.utils_incrementtrancount () as $body$
begin 

perform set_config('utils.trancount', current_setting('utils.trancount')::numeric(10) + 1, false);end;
$body$
language plpgsql
;
