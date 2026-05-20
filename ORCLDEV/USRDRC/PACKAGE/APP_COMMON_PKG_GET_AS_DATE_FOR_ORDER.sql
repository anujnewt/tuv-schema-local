create or replace  function  usrdrc.app_common_pkg_get_as_date_for_order (pisttext varchar) returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
if nullif(pisttext::text, '') is null then
return to_timestamp('01/01/0001','dd/mm/yyyy');
else
return to_timestamp(pisttext,'dd/mm/yyyy');
end if;
exception
when others then
return clock_timestamp();
end;end;
$body$
language plpgsql
;
