create or replace  function  labprod."fn_basedatos_curp"  ( curp varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(10);
keypro numeric;
status numeric;
base varchar(10);
q_empleado record;
begin
begin
return 'TVNOMINA';
base := 'TELECOM';
for q_empleado in (
select case when nullif(pam_cvesec::text, '') is null then 'TVNOMINA' else 'TELECOM' end base, emp_keypro,emp_status,emp_fecmod
from labprod.nmcoempl
left join labprod.glcopams on pam_keypar = 'SEPB' and emp_keypro = pam_cvesec
where emp_recurp = curp
order by  emp_status
/*
apsi 231017
union all
select case when pam_cvesec is null then 'TVNOMINA' else 'TELECOM' end base, emp_keypro,emp_status,emp_fecmod
from labprod.nmcoempl__rtelecom
left join labprod.glcopams on pam_keypar = 'SEPB' and emp_keypro = pam_cvesec
where emp_recurp = curp
order by  emp_status,emp_fecmod
*/
)
loop
base := q_empleado.base;
keypro := q_empleado.emp_keypro;
status := q_empleado.emp_status;
exit;
end loop;
/* commit; */
return base;
exception
when others then
return 'TVNOMINA';
end;end;
--dmap converted function completed
$body$
language plpgsql
stable;
