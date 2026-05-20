create or replace  function  fecxc.fecxc_divxperiodo_pkg_fecxc_get_months_fn ( piinidagrup numeric, piinnumelement numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (piinidagrup = 6 and piinnumelement = 1) then
return '1,2,3,4,5,6';
elsif (piinidagrup = 6 and piinnumelement = 2) then
return '7,8,9,10,11,12';
elsif (piinidagrup = 3 and piinnumelement = 1) then
return '1,2,3';
elsif (piinidagrup = 3 and piinnumelement = 2) then
return '4,5,6';
elsif (piinidagrup = 3 and piinnumelement = 3) then
return '7,8,9';
elsif (piinidagrup = 3 and piinnumelement = 4) then
return '10,11,12';
elsif (piinidagrup = 2 and piinnumelement = 1) then
return '1,2';
elsif (piinidagrup = 2 and piinnumelement = 2) then
return '3,4';
elsif (piinidagrup = 2 and piinnumelement = 3) then
return '5,6';
elsif (piinidagrup = 2 and piinnumelement = 4) then
return '7,8';
elsif (piinidagrup = 2 and piinnumelement = 5) then
return '9,10';
elsif (piinidagrup = 2 and piinnumelement = 6) then
return '11,12';
end if;end;
$body$
language plpgsql
stable;
