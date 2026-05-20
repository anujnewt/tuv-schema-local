create or replace  function  fecxc.fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn ( piinnumelement numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (piinnumelement = 1) then
return 'Primer';
elsif (piinnumelement = 2) then
return 'Segundo';
elsif (piinnumelement = 3) then
return 'Tercer';
elsif (piinnumelement = 4) then
return 'Cuarto';
elsif (piinnumelement = 5) then
return 'Quinto';
elsif (piinnumelement = 6) then
return 'Sexto';
else
return null;
end if;end;
$body$
language plpgsql
stable;
