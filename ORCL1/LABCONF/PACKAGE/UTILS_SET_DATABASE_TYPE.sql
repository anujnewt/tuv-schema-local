create or replace procedure labconf.utils_set_database_type (p_database_type varchar) as $body$
begin 

perform set_config('utils.database_type', p_database_type, false);end;
$body$
language plpgsql
;
