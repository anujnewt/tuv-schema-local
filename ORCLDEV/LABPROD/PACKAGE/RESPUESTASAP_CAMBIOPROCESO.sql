create or replace procedure labprod.respuestasap_cambioproceso ( api_keypro numeric, api_keyemp numeric, api_fecmov timestamp(0), api_pering varchar, emp_keypro numeric, fechaing inout timestamp(0), pering inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
pro_keypro numeric;
emp_fecing timestamp(0);
emp_pering varchar(7);
pro_diaper numeric(5);
api_diaper numeric(5);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--select emp_keypro,emp_fecing,emp_pering into pro_keypro,emp_fecing,emp_pering from labprod.nmcoempl  where emp_keyemp = cambioproceso.api_keyemp;
select pro_diaper into strict pro_diaper from labprod.nmloproc where pro_keypro = cambioproceso.emp_keypro;
select pro_diaper into strict api_diaper from labprod.nmloproc where pro_keypro = cambioproceso.api_keypro;
if cambioproceso.pro_diaper  != api_diaper  then
fechaing:=api_fecmov;
pering:=api_pering;
else
fechaing:=emp_fecing;
pering:=emp_pering;
end if;end;
$body$
language plpgsql
;
