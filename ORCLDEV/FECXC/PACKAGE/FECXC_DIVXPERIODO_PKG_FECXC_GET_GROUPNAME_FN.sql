create or replace  function  fecxc.fecxc_divxperiodo_pkg_fecxc_get_groupname_fn ( piinidagrup numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (piinidagrup = 6) then
return 'Semestre';
elsif (piinidagrup = 3) then
return 'Trimestre';
elsif (piinidagrup = 2) then
return 'Bimestre';
else
return null;
end if;end;
$body$
language plpgsql
stable;
