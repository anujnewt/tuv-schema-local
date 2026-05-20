create or replace  function  fecxc.fecxc_divxperiodo_pkg_fecxc_get_monthname_fn ( piinidmonth numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (piinidmonth = 1) then
return 'Enero';
elsif (piinidmonth = 2) then
return 'Febrero';
elsif (piinidmonth = 3) then
return 'Marzo';
elsif (piinidmonth = 4) then
return 'Abril';
elsif (piinidmonth = 5) then
return 'Mayo';
elsif (piinidmonth = 6) then
return 'Junio';
elsif (piinidmonth = 7) then
return 'Julio';
elsif (piinidmonth = 8) then
return 'Agosto';
elsif (piinidmonth = 9) then
return 'Septiembre';
elsif (piinidmonth = 10) then
return 'Octubre';
elsif (piinidmonth = 11) then
return 'Noviembre';
elsif (piinidmonth = 12) then
return 'Diciembre';
end if;end;
$body$
language plpgsql
stable;
