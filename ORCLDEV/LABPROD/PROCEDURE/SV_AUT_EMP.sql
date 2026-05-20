create or replace procedure labprod."sv_aut_emp"  ( num integer, num_temp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open num_temp for
select plz_cverem,plz_fe1aux from eocoplza where plz_keyemp = num;end;
$body$
language plpgsql
;
